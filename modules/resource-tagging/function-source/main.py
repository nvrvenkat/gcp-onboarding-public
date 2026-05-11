import base64
import json
import os

from googleapiclient.discovery import build

LABELS = json.loads(os.environ["LABELS"])

compute = build("compute", "v1")


def main(event, context):

    pubsub_message = base64.b64decode(event["data"]).decode("utf-8")

    message_json = json.loads(pubsub_message)

    asset = message_json.get("asset", {})

    asset_type = asset.get("assetType", "")

    resource_data = asset.get("resource", {}).get("data", {})

    if asset_type == "compute.googleapis.com/Instance":

        project = resource_data["project"]

        zone = resource_data["zone"].split("/")[-1]

        instance_name = resource_data["name"]

        instance = compute.instances().get(
            project=project,
            zone=zone,
            instance=instance_name
        ).execute()

        existing_labels = instance.get("labels", {})

        merged_labels = {
            **existing_labels,
            **LABELS
        }

        compute.instances().setLabels(
            project=project,
            zone=zone,
            instance=instance_name,
            body={
                "labels": merged_labels,
                "labelFingerprint": instance["labelFingerprint"]
            }
        ).execute()

        print(f"Labels updated for {instance_name}")