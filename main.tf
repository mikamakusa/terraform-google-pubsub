resource "google_pubsub_lite_reservation" "this" {
  count               = length(var.lite_reservation)
  name                = lookup(var.lite_reservation[count.index], "name")
  throughput_capacity = lookup(var.lite_reservation[count.index], "throughput_capacity")
  region              = lookup(var.lite_reservation[count.index], "region")
  project             = try(data.google_project.this.number)
}

resource "google_pubsub_lite_subscription" "this" {
  count   = length(var.lite_topic) == 0 ? 0 : length(var.lite_subscription)
  name    = lookup(var.lite_subscription[count.index], "name")
  topic   = element(google_pubsub_lite_topic.this.*.name, lookup(var.lite_subscription[count.index], "topic_id"))
  region  = lookup(var.lite_subscription[count.index], "region")
  zone    = lookup(var.lite_subscription[count.index], "zone")
  project = try(data.google_project.this.number)

  dynamic "delivery_config" {
    for_each = try(lookup(var.lite_subscription[count.index], "delivery_config") == null ? [] : ["delivery_config"])
    content {
      delivery_requirement = lookup(delivery_config.value, "delivery_requirement")
    }
  }
}

resource "google_pubsub_lite_topic" "this" {
  count   = length(var.lite_topic)
  name    = lookup(var.lite_topic[count.index], "name")
  region  = lookup(var.lite_topic[count.index], "region")
  zone    = lookup(var.lite_topic[count.index], "zone")
  project = try(data.google_project.this.number)

  dynamic "partition_config" {
    for_each = try(lookup(var.lite_topic[count.index], "partition_config") == null ? [] : ["partition_config"])
    content {
      count = lookup(partition_config.value, "count")
      capacity {
        publish_mib_per_sec   = lookup(partition_config.value, "publish_mib_per_sec")
        subscribe_mib_per_sec = lookup(partition_config.value, "subscribe_mib_per_sec")
      }
    }
  }

  dynamic "retention_config" {
    for_each = try(lookup(var.lite_topic[count.index], "retention_config") == null ? [] : ["retention_config"])
    content {
      per_partition_bytes = lookup(retention_config.value, "per_partition_bytes")
      period              = lookup(retention_config.value, "period")
    }
  }

  dynamic "reservation_config" {
    for_each = try(lookup(var.lite_topic[count.index], "reservation_config") == null ? [] : ["reservation_config"])
    content {
      throughput_reservation = lookup(reservation_config.value, "throughput_reservation")
    }
  }
}

resource "google_pubsub_schema" "this" {
  count      = length(var.schema)
  name       = lookup(var.schema[count.index], "name")
  type       = lookup(var.schema[count.index], "type")
  definition = lookup(var.schema[count.index], "definition")
  project    = try(data.google_project.this.number)
}

resource "google_pubsub_schema_iam_binding" "this" {
  count   = length(var.schema) == 0 ? 0 : length(var.schema_iam_binding)
  members = lookup(var.schema_iam_binding[count.index], "members")
  role    = lookup(var.schema_iam_binding[count.index], "role")
  schema  = element(google_pubsub_schema.this.*.name, lookup(var.schema_iam_binding[count.index], "schema_id"))
}

resource "google_pubsub_subscription" "this" {
  count                        = length(var.topic) == 0 ? 0 : length(var.subscription)
  name                         = lookup(var.subscription[count.index], "name")
  topic                        = element(google_pubsub_topic.this.*.id, lookup(var.subscription[count.index], "topic_id"))
  labels                       = lookup(var.subscription[count.index], "labels")
  ack_deadline_seconds         = lookup(var.subscription[count.index], "ack_deadline_seconds")
  message_retention_duration   = lookup(var.subscription[count.index], "message_retention_duration")
  retain_acked_messages        = lookup(var.subscription[count.index], "retain_acked_messages")
  filter                       = lookup(var.subscription[count.index], "filter")
  enable_message_ordering      = lookup(var.subscription[count.index], "enable_message_ordering")
  enable_exactly_once_delivery = lookup(var.subscription[count.index], "enable_exactly_once_delivery")
  project                      = try(data.google_project.this.number)

  dynamic "bigquery_config" {
    for_each = try(lookup(var.subscription[count.index], "bigquery_config") == null ? [] : ["bigquery_config"])
    content {
      table                 = lookup(bigquery_config.value, "table")
      use_table_schema      = lookup(bigquery_config.value, "use_table_schema")
      use_topic_schema      = lookup(bigquery_config.value, "use_topic_schema")
      write_metadata        = lookup(bigquery_config.value, "write_metadata")
      drop_unknown_fields   = lookup(bigquery_config.value, "drop_unknown_fields")
      service_account_email = lookup(bigquery_config.value, "service_account_email")
    }
  }

  dynamic "cloud_storage_config" {
    for_each = try(lookup(var.subscription[count.index], "cloud_storage_config") == null ? [] : ["cloud_storage_config"])
    content {
      bucket                   = try(data.google_storage_bucket.this.name)
      filename_prefix          = lookup(cloud_storage_config.value, "filename_prefix")
      filename_suffix          = lookup(cloud_storage_config.value, "filename_suffix")
      filename_datetime_format = lookup(cloud_storage_config.value, "filename_datetime_format")
      max_duration             = lookup(cloud_storage_config.value, "max_duration")
      max_bytes                = lookup(cloud_storage_config.value, "max_bytes")
      max_messages             = lookup(cloud_storage_config.value, "max_messages")
      service_account_email    = try(data.google_service_account.this.email)

      dynamic "avro_config" {
        for_each = try(lookup(cloud_storage_config.value, "avro_config") == null ? [] : ["avro_config"])
        content {
          write_metadata   = lookup(avro_config.value, "write_metadata")
          use_topic_schema = lookup(avro_config.value, "use_topic_schema")
        }
      }
    }
  }

  dynamic "push_config" {
    for_each = try(lookup(var.subscription[count.index], "push_config") == null ? [] : ["push_config"])
    content {
      push_endpoint = lookup(push_config.value, "push_endpoint")
      attributes    = lookup(push_config.value, "attributes")

      dynamic "oidc_token" {
        for_each = try(lookup(push_config.value, "oidc_token") == null ? [] : ["oidc_token"])
        content {
          service_account_email = lookup(oidc_token.value, "service_account_email")
          audience              = lookup(oidc_token.value, "audience")
        }
      }

      dynamic "no_wrapper" {
        for_each = try(lookup(push_config.value, "no_wrapper") == null ? [] : ["no_wrapper"])
        content {
          write_metadata = lookup(no_wrapper.value, "write_metadata")
        }
      }
    }
  }

  dynamic "expiration_policy" {
    for_each = try(lookup(var.subscription[count.index], "expiration_policy") == null ? [] : ["expiration_policy"])
    content {
      ttl = lookup(expiration_policy.value, "ttl")
    }
  }

  dynamic "dead_letter_policy" {
    for_each = try(lookup(var.subscription[count.index], "dead_letter_policy") == null ? [] : ["dead_letter_policy"])
    content {
      dead_letter_topic     = lookup(dead_letter_policy.value, "dead_letter_topic")
      max_delivery_attempts = lookup(dead_letter_policy.value, "max_delivery_attempts")
    }
  }

  dynamic "retry_policy" {
    for_each = try(lookup(var.subscription[count.index], "retry_policy") == null ? [] : ["retry_policy"])
    content {
      maximum_backoff = lookup(retry_policy.value, "maximum_backoff")
      minimum_backoff = lookup(retry_policy.value, "minimum_backoff")
    }
  }
}

resource "google_pubsub_subscription_iam_binding" "this" {
  count        = length(var.subscription) == 0 ? 0 : length(var.subscription_iam_binding)
  members      = lookup(var.subscription_iam_binding[count.index], "members")
  role         = lookup(var.subscription_iam_binding[count.index], "role")
  subscription = element(google_pubsub_subscription.this.*.name, lookup(var.subscription_iam_binding[count.index], "subscription_id"))
}

resource "google_pubsub_topic" "this" {
  count                      = length(var.topic)
  name                       = lookup(var.topic[count.index], "name")
  labels                     = lookup(var.topic[count.index], "labels")
  message_retention_duration = lookup(var.topic[count.index], "message_retention_duration")
  project                    = data.google_project.this.project_id

  dynamic "ingestion_data_source_settings" {
    for_each = try(lookup(var.topic[count.index], "ingestion_data_source_settings") == null ? [] : ["ingestion_data_source_settings"])
    iterator = ingestion
    content {
      dynamic "aws_kinesis" {
        for_each = try(lookup(ingestion.value, "aws_kinesis") == null ? [] : ["aws_kinesis"])
        iterator = aws
        content {
          aws_role_arn        = lookup(aws.value, "aws_role_arn")
          consumer_arn        = lookup(aws.value, "consumer_arn")
          gcp_service_account = lookup(aws.value, "gcp_service_account")
          stream_arn          = lookup(aws.value, "stream_arn")
        }
      }
      dynamic "cloud_storage" {
        for_each = try(lookup(ingestion.value, "cloud_storage") == null ? [] : ["cloud_storage"])
        iterator = gcs
        content {
          bucket                     = lookup(gcs.value, "bucket")
          minimum_object_create_time = lookup(gcs.value, "minimum_object_create_time")
          match_glob                 = lookup(gcs.value, "match_glob")
        }
      }
      dynamic "platform_logs_settings" {
        for_each = try(lookup(ingestion.value, "platform_logs_settings") == null ? [] : ["platform_logs_settings"])
        iterator = pls
        content {
          severity = lookup(pls.value, "severity")
        }
      }
    }
  }

  dynamic "message_storage_policy" {
    for_each = try(lookup(var.topic[count.index], "message_storage_policy") == null ? [] : ["message_storage_policy"])
    iterator = message
    content {
      allowed_persistence_regions = lookup(message.value, "allowed_persistence_regions")
      enforce_in_transit          = lookup(message.value, "enforce_in_transit")
    }
  }

  dynamic "schema_settings" {
    for_each = try(lookup(var.topic[count.index], "schema_settings") == null ? [] : ["schema_settings"])
    iterator = schema
    content {
      schema   = lookup(schema.value, "schema")
      encoding = lookup(schema.value, "encoding")
    }
  }
}

resource "google_pubsub_topic_iam_binding" "this" {
  count   = length(var.topic) == 0 ? 0 : length(var.topic_iam_binding)
  members = lookup(var.topic_iam_binding[count.index], "members")
  role    = lookup(var.topic_iam_binding[count.index], "role")
  topic   = element(google_pubsub_topic.this.*.name, lookup(var.topic_iam_binding[count.index], "topic_id"))
  project = data.google_project.this.project_id
}