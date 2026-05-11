from googleapiclient.discovery import build

compute = build("compute", "v1")


def handle_disk(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"Disk Asset Name: {asset_name}")

    parts = asset_name.split("/")

    project = parts[4]

    zone = parts[6]

    disk_name = parts[8]

    disk = compute.disks().get(
        project=project,
        zone=zone,
        disk=disk_name
    ).execute()

    existing_labels = disk.get("labels", {})

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    compute.disks().setLabels(
        project=project,
        zone=zone,
        resource=disk_name,
        body={
            "labels": merged_labels,
            "labelFingerprint": disk["labelFingerprint"]
        }
    ).execute()

    print(f"Labels updated for disk {disk_name}")