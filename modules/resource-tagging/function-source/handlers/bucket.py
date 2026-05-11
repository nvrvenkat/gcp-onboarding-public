from google.cloud import storage

storage_client = storage.Client()


def handle_bucket(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"Bucket Asset Name: {asset_name}")

    parts = asset_name.split("/")

    bucket_name = parts[-1]

    bucket = storage_client.bucket(bucket_name)

    bucket.reload()

    existing_labels = bucket.labels

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    bucket.labels = merged_labels

    bucket.patch()

    print(f"Labels updated for bucket {bucket_name}")