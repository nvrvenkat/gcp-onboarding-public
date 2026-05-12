from googleapiclient.discovery import build

container = build("container", "v1")


def handle_gke_cluster(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"GKE Cluster Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 8:
        print("Invalid GKE cluster asset format")
        return

    project = parts[4]

    location = parts[6]

    cluster_name = parts[7]

    print(f"Project: {project}")
    print(f"Location: {location}")
    print(f"Cluster: {cluster_name}")

    full_name = (
        f"projects/{project}/locations/{location}/clusters/{cluster_name}"
    )

    cluster = (
        container.projects()
        .locations()
        .clusters()
        .get(
            name=full_name
        )
        .execute()
    )

    existing_labels = cluster.get("resourceLabels", {})

    print(f"Existing Labels: {existing_labels}")

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    print(f"Merged Labels: {merged_labels}")

    if existing_labels == merged_labels:

        print("Labels already present")

        return

    body = {
        "resourceLabels": merged_labels,
        "labelFingerprint": cluster["labelFingerprint"]
    }

    operation = (
        container.projects()
        .locations()
        .clusters()
        .setResourceLabels(
            projectId=project,
            zone=location,
            clusterId=cluster_name,
            body=body
        )
        .execute()
    )

    print("GKE labels update started")

    print(operation)