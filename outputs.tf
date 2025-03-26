## google_pubsub_lite_reservation
output "google_pubsub_lite_reservation_name" {
  value = try(google_pubsub_lite_reservation.this.*.name)
}

output "google_pubsub_lite_reservation_throughput_capacity" {
  value = try(google_pubsub_lite_reservation.this.*.throughput_capacity)
}

## google_pubsub_lite_subscription
output "google_pubsub_lite_subscription_name" {
  value = try(google_pubsub_lite_subscription.this.*.name)
}

output "google_pubsub_lite_subscription_topic" {
  value = try(google_pubsub_lite_subscription.this.*.topic)
}

## google_pubsub_lite_topic
output "google_pubsub_lite_topic_name" {
  value = try(google_pubsub_lite_topic.this.*.name)
}

output "google_pubsub_lite_topic_reservation_config" {
  value = try(google_pubsub_lite_topic.this.*.reservation_config)
}

output "google_pubsub_lite_topic_retention_config" {
  value = try(google_pubsub_lite_topic.this.*.retention_config)
}

output "google_pubsub_lite_topic_partition_config" {
  value = try(google_pubsub_lite_topic.this.*.partition_config)
}

## google_pubsub_schema
output "google_pubsub_schema_name" {
  value = try(google_pubsub_schema.this.*.name)
}

## google_pubsub_schema_iam_binding
output "google_pubsub_schema_iam_binding_id" {
  value = try(google_pubsub_schema_iam_binding.this.*.id)
}

output "google_pubsub_schema_iam_binding_schema" {
  value = try(google_pubsub_schema_iam_binding.this.*.schema)
}

## google_pubsub_subscription
output "google_pubsub_subscription_name" {
  value = try(google_pubsub_subscription.this.*.name)
}

output "google_pubsub_subscription_topic" {
  value = try(google_pubsub_subscription.this.*.topic)
}

## google_pubsub_subscription_iam_binding
output "google_pubsub_subscription_iam_binding_id" {
  value = try(google_pubsub_subscription_iam_binding.this.*.id)
}

## google_pubsub_topic
output "google_pubsub_topic_name" {
  value = try(google_pubsub_topic.this.*.name)
}

## google_pubsub_topic_iam_binding
output "google_pubsub_topic_iam_binding_id" {
  value = try(google_pubsub_topic_iam_binding.this.*.id)
}

output "google_pubsub_topic_iam_binding_topic" {
  value = try(google_pubsub_topic_iam_binding.this.*.topic)
}
