provider "google" {}

module "pubsub" {
  source = "../../"
  lite_topic = [{
    name = "example"
    partition_config = [
      {
        count = 1
        capacity = [
          {
            publish_mib_per_sec   = 4
            subscribe_mib_per_sec = 8
          }
        ]
      }
    ]
    subscription = [{
      name                 = "example"
      delivery_requirement = "DELIVER_AFTER_STORED"
    }]
  }]
}