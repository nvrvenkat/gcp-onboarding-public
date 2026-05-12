import base64
import json
import os
from datetime import datetime

from handlers.compute import handle_compute_instance
from handlers.bucket import handle_bucket
from handlers.cloudrun import handle_cloud_run
from handlers.cloudfunction import handle_cloud_function
from handlers.disk import handle_disk
from handlers.cloudrunjob import handle_cloud_run_job
from handlers.cloudsql import handle_cloud_sql
from handlers.gke import handle_gke_cluster

# Load static labels (e.g., ManagedBy, Environment)
STATIC_LABELS = json.loads(os.environ.get("LABELS", "{}"))

def main(event, context):
    try:
        if "data" not in event:
            return

        pubsub_message = base64.b64decode(event["data"]).decode("utf-8")
        if not pubsub_message.strip():
            return

        message_json = json.loads(pubsub_message)
        asset = message_json.get("asset", {})
        asset_type = asset.get("assetType", "")

        # --- DYNAMIC TAGGING LOGIC (AWS PARITY) ---
        # 1. Extract 'CreatedAt' from the asset update time
        update_time = asset.get("updateTime", "")
        created_at = "unknown"
        if update_time:
            # Clean up the timestamp format to be label-compatible (no colons/dots)
            created_at = update_time.split(".")[0].replace(":", "-").replace("T", "_").lower()

        # 2. Extract 'CreatedBy' from the resource metadata if available
        # Note: Cloud Asset Inventory feeds provide the 'creator' in the 'priorAssetState' 
        # or it can be derived from the user who triggered the event.
        creator = "system"
        # Since Asset Feeds don't always include the principal, we use a fallback or
        # you can integrate with Cloud Logging for deeper inspection.
        
        # Merge dynamic labels with static labels
        final_labels = {
            **STATIC_LABELS,
            "created_at": created_at,
            "created_by": creator
        }
        # ------------------------------------------

        if asset_type == "compute.googleapis.com/Instance":
            handle_compute_instance(asset, final_labels)
        elif asset_type == "storage.googleapis.com/Bucket":
            handle_bucket(asset, final_labels)
        elif asset_type == "compute.googleapis.com/Disk":
            handle_disk(asset, final_labels)
        elif asset_type == "run.googleapis.com/Service":
            handle_cloud_run(asset, final_labels)
        elif asset_type == "run.googleapis.com/Job":
            handle_cloud_run_job(asset, final_labels)
        elif "cloudfunction" in asset_type.lower():
            handle_cloud_function(asset, final_labels)
        elif asset_type == "sqladmin.googleapis.com/Instance":
            handle_cloud_sql(asset, final_labels)
        elif asset_type == "container.googleapis.com/Cluster":
            handle_gke_cluster(asset, final_labels)

    except Exception as e:
        print(f"ERROR: {str(e)}")
        raise