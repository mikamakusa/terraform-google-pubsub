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
    name = "example"
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
  subscription = [{
    name                 = "example"
    ack_deadline_seconds = 20
    push_config = [
      {
        push_endpoint = "https://example.com/push"
        attributes = {
          x-goog-version = "v1"
        }
      }
    ]
  }]
}