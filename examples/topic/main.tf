provider "google" {}

module "pubsub" {
  source = "../../"
  schema = [{
    name = "example"
    type = "PROTOCOL_BUFFER"
    iam = [{
      role = "roles/viewer"
      members = [
        "user:jane@example.com",
      ]
    }]
  }]
  topic = [{
    name = "example-topic"
    schema_settings = [
      {
        schema   = "projects/my-project-name/schemas/example"
        encoding = "JSON"
      }
    ]
    iam = [{
      role = "roles/viewer"
      members = [
        "user:jane@example.com",
      ]
    }]
  }]
}