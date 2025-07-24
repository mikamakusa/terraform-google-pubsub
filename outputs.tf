## google_pubsub_lite_reservation
output "lite_reservation" {
  value = {
    for a in google_pubsub_lite_reservation.this : a => {
      id                  = a.id
      name                = a.name
      throughput_capacity = a.throughput_capacity
    }
  }
}

## google_pubsub_lite_subscription
output "lite_subscription" {
  value = {
    for a in google_pubsub_lite_subscription.this : a => {
      id              = a.id
      name            = a.name
      topic           = a.topic
      delivery_config = a.delivery_config
      zone            = a.zone
    }
  }
}

## google_pubsub_lite_topic
output "lite_topic" {
  value = {
    for a in google_pubsub_lite_topic.this : a => {
      id                 = a.id
      name               = a.name
      partition_config   = a.partition_config
      reservation_config = a.reservation_config
      retention_config   = a.retention_config
      zone               = a.zone
    }
  }
}

## google_pubsub_schema
output "schema" {
  value = {
    for a in google_pubsub_schema.this : a => {
      id   = a.id
      name = a.name
    }
  }
}

## google_pubsub_schema_iam_binding
output "schema_iam_binding" {
  value = {
    for a in google_pubsub_schema_iam_binding.this : a => {
      id        = a.id
      role      = a.role
      condition = a.condition
      etag      = a.etag
      schema    = a.schema
    }
  }
}

## google_pubsub_subscription
output "subscription" {
  value = {
    for a in google_pubsub_subscription.this : a => {
      id                           = a.id
      name                         = a.name
      topic                        = a.topic
      push_config                  = a.push_config
      cloud_storage_config         = a.cloud_storage_config
      labels                       = a.labels
      ack_deadline_seconds         = a.ack_deadline_seconds
      bigquery_config              = a.bigquery_config
      dead_letter_policy           = a.dead_letter_policy
      effective_labels             = a.effective_labels
      enable_exactly_once_delivery = a.enable_exactly_once_delivery
      enable_message_ordering      = a.enable_message_ordering
      expiration_policy            = a.expiration_policy
      message_retention_duration   = a.message_retention_duration
      retain_acked_messages        = a.retain_acked_messages
      retry_policy                 = a.retry_policy
    }
  }
}

## google_pubsub_subscription_iam_binding
output "subscription_iam_binding" {
  value = {
    for a in google_pubsub_subscription_iam_binding.this : a => {
      id        = a.id
      condition = a.condition
      role      = a.role
      members   = a.members
      etag      = a.etag
    }
  }
}

## google_pubsub_topic
output "topic" {
  value = {
    for a in google_pubsub_topic.this : a => {
      id                             = a.id
      name                           = a.name
      ingestion_data_source_settings = a.ingestion_data_source_settings
      message_retention_duration     = a.message_retention_duration
      effective_labels               = a.effective_labels
      labels                         = a.labels
      kms_key_name                   = a.kms_key_name
      message_storage_policy         = a.message_storage_policy
      schema_settings                = a.schema_settings
    }
  }
}

## google_pubsub_topic_iam_binding
output "topic_iam_binding" {
  value = {
    for a in google_pubsub_topic_iam_binding.this : a => {
      id        = a.id
      etag      = a.etag
      members   = a.members
      role      = a.role
      condition = a.condition
      topic     = a.topic
    }
  }
}
