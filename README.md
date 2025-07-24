## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.13.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_pubsub_lite_reservation.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_lite_reservation) | resource |
| [google_pubsub_lite_subscription.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_lite_subscription) | resource |
| [google_pubsub_lite_topic.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_lite_topic) | resource |
| [google_pubsub_schema.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema) | resource |
| [google_pubsub_schema_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema_iam_binding) | resource |
| [google_pubsub_subscription.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_binding) | resource |
| [google_pubsub_topic.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_binding.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_binding) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lite_topic"></a> [lite\_topic](#input\_lite\_topic) | n/a | <pre>list(object({<br/>    id     = any<br/>    name   = string<br/>    region = optional(string)<br/>    zone   = optional(string)<br/>    partition_config = optional(list(object({<br/>      count                 = number<br/>      publish_mib_per_sec   = optional(number)<br/>      subscribe_mib_per_sec = optional(number)<br/>    })), [])<br/>    retention_config = optional(list(object({<br/>      per_partition_bytes = string<br/>      period              = optional(string)<br/>    })), [])<br/>    reservation_config = optional(list(object({<br/>      throughput_reservation = optional(string)<br/>    })), [])<br/>    subscription = optional(list(object({<br/>      name                 = string<br/>      region               = optional(string)<br/>      zone                 = optional(string)<br/>      delivery_requirement = string<br/>    })))<br/>    reservation = optional(list(object({<br/>      name                = string<br/>      throughput_capacity = number<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | n/a | <pre>list(object({<br/>    id         = any<br/>    name       = string<br/>    type       = optional(string)<br/>    definition = optional(string)<br/>    iam = optional(list(object({<br/>      members = list(string)<br/>      role    = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_subscription"></a> [subscription](#input\_subscription) | n/a | <pre>list(object({<br/>    id                           = any<br/>    name                         = string<br/>    topic_id                     = any<br/>    labels                       = optional(map(string))<br/>    ack_deadline_seconds         = optional(number)<br/>    message_retention_duration   = optional(string)<br/>    retain_acked_messages        = optional(bool)<br/>    filter                       = optional(string)<br/>    enable_message_ordering      = optional(bool)<br/>    enable_exactly_once_delivery = optional(bool)<br/>    bigquery_config = optional(list(object({<br/>      table                 = string<br/>      use_table_schema      = optional(bool)<br/>      use_topic_schema      = optional(bool)<br/>      write_metadata        = optional(bool)<br/>      drop_unknown_fields   = optional(bool)<br/>      service_account_email = optional(string)<br/>    })), [])<br/>    cloud_storage_config = optional(list(object({<br/>      filename_prefix          = optional(string)<br/>      filename_suffix          = optional(string)<br/>      filename_datetime_format = optional(string)<br/>      max_duration             = optional(string)<br/>      max_bytes                = optional(number)<br/>      max_messages             = optional(number)<br/>      bucket                   = optional(string)<br/>      service_account_email    = optional(string)<br/>      avro_config = optional(list(object({<br/>        write_metadata   = optional(bool)<br/>        use_topic_schema = optional(bool)<br/>      })), [])<br/>    })), [])<br/>    push_config = optional(list(object({<br/>      push_endpoint = string<br/>      attributes    = optional(map(string))<br/>      oidc_token = optional(list(object({<br/>        service_account_email = string<br/>        audience              = optional(string)<br/>      })))<br/>      no_wrapper = optional(list(object({<br/>        write_metadata = bool<br/>      })))<br/>    })), [])<br/>    expiration_policy = optional(list(object({<br/>      ttl = string<br/>    })), [])<br/>    dead_letter_policy = optional(list(object({<br/>      dead_letter_topic     = optional(string)<br/>      max_delivery_attempts = optional(number)<br/>    })), [])<br/>    retry_policy = optional(list(object({<br/>      maximum_backoff = optional(string)<br/>      minimum_backoff = optional(string)<br/>    })), [])<br/>    iam = optional(list(object({<br/>      members = list(string)<br/>      role    = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_topic"></a> [topic](#input\_topic) | n/a | <pre>list(object({<br/>    id                         = any<br/>    name                       = string<br/>    labels                     = optional(map(string))<br/>    message_retention_duration = optional(string)<br/>    ingestion_data_source_settings = optional(list(object({<br/>      aws_kinesis = optional(list(object({<br/>        aws_role_arn        = string<br/>        consumer_arn        = string<br/>        gcp_service_account = string<br/>        stream_arn          = string<br/>      })), [])<br/>      cloud_storage = optional(list(object({<br/>        bucket                     = any<br/>        minimum_object_create_time = optional(string)<br/>        match_glob                 = optional(string)<br/>      })), [])<br/>      platform_logs_settings = optional(list(object({<br/>        severity = optional(string)<br/>      })), [])<br/>    })), [])<br/>    message_storage_policy = optional(list(object({<br/>      allowed_persistence_regions = list(string)<br/>      enforce_in_transit          = optional(bool)<br/>    })), [])<br/>    schema_settings = optional(list(object({<br/>      schema   = string<br/>      encoding = optional(string)<br/>    })), [])<br/>    iam = optional(list(object({<br/>      members = list(string)<br/>      role    = string<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lite_reservation"></a> [lite\_reservation](#output\_lite\_reservation) | # google\_pubsub\_lite\_reservation |
| <a name="output_lite_subscription"></a> [lite\_subscription](#output\_lite\_subscription) | # google\_pubsub\_lite\_subscription |
| <a name="output_lite_topic"></a> [lite\_topic](#output\_lite\_topic) | # google\_pubsub\_lite\_topic |
| <a name="output_schema"></a> [schema](#output\_schema) | # google\_pubsub\_schema |
| <a name="output_schema_iam_binding"></a> [schema\_iam\_binding](#output\_schema\_iam\_binding) | # google\_pubsub\_schema\_iam\_binding |
| <a name="output_subscription"></a> [subscription](#output\_subscription) | # google\_pubsub\_subscription |
| <a name="output_subscription_iam_binding"></a> [subscription\_iam\_binding](#output\_subscription\_iam\_binding) | # google\_pubsub\_subscription\_iam\_binding |
| <a name="output_topic"></a> [topic](#output\_topic) | # google\_pubsub\_topic |
| <a name="output_topic_iam_binding"></a> [topic\_iam\_binding](#output\_topic\_iam\_binding) | # google\_pubsub\_topic\_iam\_binding |
