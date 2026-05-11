import time

from googleapiclient.discovery import build

compute = build("compute", "v1")


def handle_compute_instance(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"VM Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 9:
        print("Invalid VM asset format")
        return

    project = parts[4]

    zone = parts[6]

    instance_name = parts[8]

    print(f"Project: {project}")
    print(f"Zone: {zone}")
    print(f"Instance: {instance_name}")

    instance = None

    for attempt in range(5):

        try:

            print(f"Attempt {attempt + 1}")

            instance = compute.instances().get(
                project=project,
                zone=zone,
                instance=instance_name
            ).execute()

            break

        except Exception as e:

            print(str(e))

            time.sleep(10)

    if not instance:
        print("VM not available")
        return

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

    print(f"Labels updated for VM {instance_name}")