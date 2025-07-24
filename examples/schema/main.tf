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
}