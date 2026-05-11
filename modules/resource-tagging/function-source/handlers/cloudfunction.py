from googleapiclient.discovery import build

cloudfunctions = build("cloudfunctions", "v2")


def handle_cloud_function(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"Cloud Function Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 8:
        print("Invalid Cloud Function asset format")
        return

    project = parts[4]

    region = parts[6]

    function_name = parts[8]

    print(f"Project: {project}")
    print(f"Region: {region}")
    print(f"Function Name: {function_name}")

    full_name = (
        f"projects/{project}/locations/{region}/functions/{function_name}"
    )

    function = cloudfunctions.projects().locations().functions().get(
        name=full_name
    ).execute()

    existing_labels = function.get("labels", {})

    print(f"Existing Labels: {existing_labels}")

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    print(f"Merged Labels: {merged_labels}")

    body = {
        "labels": merged_labels
    }

    operation = (
        cloudfunctions.projects()
        .locations()
        .functions()
        .patch(
            name=full_name,
            updateMask="labels",
            body=body
        )
        .execute()
    )

    print("Patch operation started")

    print(operation)