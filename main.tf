resource "google_pubsub_lite_topic" "this" {
  for_each = { for a in var.lite_topic : a.name => a }
  name     = each.value.name
  region   = each.value.region
  zone     = each.value.zone
  project  = data.google_project.this.number

  dynamic "partition_config" {
    for_each = { for a in var.lite_topic : a.name => a if contains(keys(a), "partition_config") && a.partition_config != null }
    content {
      count = lookup(each.value, "count")
      capacity {
        publish_mib_per_sec   = lookup(each.value, "publish_mib_per_sec")
        subscribe_mib_per_sec = lookup(each.value, "subscribe_mib_per_sec")
      }
    }
  }

  dynamic "retention_config" {
    for_each = { for a in var.lite_topic : a.name => a if contains(keys(a), "retention_config") && a.retention_config != null }
    content {
      per_partition_bytes = lookup(each.value, "per_partition_bytes")
      period              = lookup(each.value, "period")
    }
  }

  dynamic "reservation_config" {
    for_each = { for a in var.lite_topic : a.name => a if contains(keys(a), "reservation_config") && a.reservation_config != null }
    content {
      throughput_reservation = lookup(each.value, "throughput_reservation")
    }
  }
}

resource "google_pubsub_lite_subscription" "this" {
  for_each = { for b in var.lite_topic : b.name => b if contains(keys(b), "subscription") && b.subscription != null }
  name     = lookup(each.value, "name")
  topic    = google_pubsub_lite_topic.this[each.key].name
  region   = lookup(each.value, "region")
  zone     = lookup(each.value, "zone")
  project  = data.google_project.this.number

  delivery_config {
    delivery_requirement = lookup(each.value, "delivery_requirement")
  }
}

resource "google_pubsub_lite_reservation" "this" {
  for_each            = { for b in var.lite_topic : b.name => b if contains(keys(b), "reservation") && b.reservation != null }
  name                = lookup(each.value, "name")
  throughput_capacity = lookup(each.value, "throughput_capacity")
}

resource "google_pubsub_schema" "this" {
  for_each   = { for c in var.schema : c.name => c }
  name       = each.value.name
  type       = each.value.type
  definition = each.value.definition
  project    = data.google_project.this.number
}

resource "google_pubsub_schema_iam_binding" "this" {
  for_each = { for c in var.schema : c.name => c if contains(keys(c), "iam") && c.iam != null }
  members  = lookup(each.value, "members")
  role     = lookup(each.value, "role")
  schema   = google_pubsub_schema.this[each.key].name
}

resource "google_pubsub_subscription" "this" {
  for_each                     = { for c in var.subscription : c.name => c }
  name                         = join("-", [each.value.name, "subscription"])
  topic                        = google_pubsub_topic.this[join("-", [each.value.name, "topic"])].id
  labels                       = each.value.labels
  ack_deadline_seconds         = each.value.ack_deadline_seconds
  message_retention_duration   = each.value.message_retention_duration
  retain_acked_messages        = each.value.retain_acked_messages
  filter                       = each.value.filter
  enable_message_ordering      = each.value.enable_message_ordering
  enable_exactly_once_delivery = each.value.enable_exactly_once_delivery
  project                      = try(data.google_project.this.number)

  dynamic "bigquery_config" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "bigquery_config") && c.bigquery_config != null }
    content {
      table                 = lookup(each.value, "table")
      use_table_schema      = lookup(each.value, "use_table_schema")
      use_topic_schema      = lookup(each.value, "use_topic_schema")
      write_metadata        = lookup(each.value, "write_metadata")
      drop_unknown_fields   = lookup(each.value, "drop_unknown_fields")
      service_account_email = lookup(each.value, "service_account_email")
    }
  }

  dynamic "cloud_storage_config" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "cloud_storage_config") && c.cloud_storage_config != null }
    content {
      bucket                   = lookup(each.value, "bucket")
      filename_prefix          = lookup(each.value, "filename_prefix")
      filename_suffix          = lookup(each.value, "filename_suffix")
      filename_datetime_format = lookup(each.value, "filename_datetime_format")
      max_duration             = lookup(each.value, "max_duration")
      max_bytes                = lookup(each.value, "max_bytes")
      max_messages             = lookup(each.value, "max_messages")
      service_account_email    = lookup(each.value, "service_account_email")

      dynamic "avro_config" {
        for_each = { for c in var.subscription.*.cloud_storage_config : c.name => c if contains(keys(c), "avro_config") && c.avro_config != null }
        content {
          write_metadata   = lookup(each.value, "write_metadata")
          use_topic_schema = lookup(each.value, "use_topic_schema")
        }
      }
    }
  }

  dynamic "push_config" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "push_config") && c.push_config != null }
    content {
      push_endpoint = lookup(push_config.value, "push_endpoint")
      attributes    = lookup(push_config.value, "attributes")

      dynamic "oidc_token" {
        for_each = { for c in var.subscription.*.push_config : c.name => c if contains(keys(c), "oidc_token") && c.oidc_token != null }
        content {
          service_account_email = lookup(each.value, "service_account_email")
          audience              = lookup(each.value, "audience")
        }
      }

      dynamic "no_wrapper" {
        for_each = { for c in var.subscription.*.push_config : c.name => c if contains(keys(c), "no_wrapper") && c.no_wrapper != null }
        content {
          write_metadata = lookup(each.value, "write_metadata")
        }
      }
    }
  }

  dynamic "expiration_policy" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "expiration_policy") && c.expiration_policy != null }
    content {
      ttl = lookup(each.value, "ttl")
    }
  }

  dynamic "dead_letter_policy" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "dead_letter_policy") && c.dead_letter_policy != null }
    content {
      dead_letter_topic     = lookup(each.value, "dead_letter_topic")
      max_delivery_attempts = lookup(each.value, "max_delivery_attempts")
    }
  }

  dynamic "retry_policy" {
    for_each = { for c in var.subscription : c.name => c if contains(keys(c), "retry_policy") && c.retry_policy != null }
    content {
      maximum_backoff = lookup(each.value, "maximum_backoff")
      minimum_backoff = lookup(each.value, "minimum_backoff")
    }
  }
}

resource "google_pubsub_subscription_iam_binding" "this" {
  for_each     = { for d in var.subscription : d.name => d if contains(keys(d), "iam") && d.iam != null }
  members      = lookup(each.value, "members")
  role         = lookup(each.value, "role")
  subscription = google_pubsub_subscription.this[each.key].name
}

resource "google_pubsub_topic" "this" {
  for_each                   = { for e in var.topic : e.name => e }
  depends_on                 = [google_pubsub_schema.this]
  name                       = join("-", [each.value.name, "topic"])
  labels                     = each.value.labels
  message_retention_duration = each.value.message_retention_duration
  project                    = data.google_project.this.project_id

  dynamic "ingestion_data_source_settings" {
    for_each = { for e in var.topic : e.name => e if contains(keys(e), "ingestion_data_source_settings") && e.ingestion_data_source_settings != null }
    iterator = ingestion
    content {
      dynamic "aws_kinesis" {
        for_each = { for e in var.topic.*.ingestion_data_source_settings : e.name => e if contains(keys(e), "aws_kinesis") && e.aws_kinesis != null }
        iterator = aws
        content {
          aws_role_arn        = lookup(each.value, "aws_role_arn")
          consumer_arn        = lookup(each.value, "consumer_arn")
          gcp_service_account = lookup(each.value, "gcp_service_account")
          stream_arn          = lookup(each.value, "stream_arn")
        }
      }
      dynamic "cloud_storage" {
        for_each = { for e in var.topic.*.ingestion_data_source_settings : e.name => e if contains(keys(e), "cloud_storage") && e.cloud_storage != null }
        iterator = gcs
        content {
          bucket                     = lookup(each.value, "bucket")
          minimum_object_create_time = lookup(each.value, "minimum_object_create_time")
          match_glob                 = lookup(each.value, "match_glob")
        }
      }
      dynamic "platform_logs_settings" {
        for_each = { for e in var.topic.*.ingestion_data_source_settings : e.name => e if contains(keys(e), "platform_logs_settings") && e.platform_logs_settings != null }
        iterator = pls
        content {
          severity = lookup(each.value, "severity")
        }
      }
    }
  }

  dynamic "message_storage_policy" {
    for_each = { for e in var.topic : e.name => e if contains(keys(e), "message_storage_policy") && e.message_storage_policy != null }
    iterator = message
    content {
      allowed_persistence_regions = lookup(each.value, "allowed_persistence_regions")
      enforce_in_transit          = lookup(each.value, "enforce_in_transit")
    }
  }

  dynamic "schema_settings" {
    for_each = { for e in var.topic : e.name => e if contains(keys(e), "schema_settings") && e.schema_settings != null }
    iterator = schema
    content {
      schema   = lookup(each.value, "schema")
      encoding = lookup(each.value, "encoding")
    }
  }
}

resource "google_pubsub_topic_iam_binding" "this" {
  for_each = { for e in var.topic : e.name => e if contains(keys(e), "iam") && e.iam != null }
  members  = lookup(each.value, "members")
  role     = lookup(each.value, "role")
  topic    = google_pubsub_topic.this[each.key].name
}