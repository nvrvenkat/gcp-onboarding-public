from googleapiclient.discovery import build

run = build("run", "v2")


def handle_cloud_run(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"Cloud Run Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 9:
        print("Invalid Cloud Run asset format")
        return

    project = parts[4]

    region = parts[6]

    service_name = parts[8]

    print(f"Project: {project}")
    print(f"Region: {region}")
    print(f"Service: {service_name}")

    full_name = (
        f"projects/{project}/locations/{region}/services/{service_name}"
    )

    service = (
        run.projects()
        .locations()
        .services()
        .get(
            name=full_name
        )
        .execute()
    )

    metadata = service.get("labels", {})

    print(f"Existing Labels: {metadata}")

    merged_labels = {
        **metadata,
        **LABELS
    }

    print(f"Merged Labels: {merged_labels}")

    if metadata == merged_labels:

        print("Labels already present")

        return

    body = {
        "labels": merged_labels
    }

    operation = (
        run.projects()
        .locations()
        .services()
        .patch(
            name=full_name,
            updateMask="labels",
            body=body
        )
        .execute()
    )

    print("Cloud Run label update started")

    print(operation)