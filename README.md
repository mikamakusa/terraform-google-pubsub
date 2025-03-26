## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.13.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.13.0 |

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
| [google_service_account.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |
| [google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | `null` | no |
| <a name="input_lite_reservation"></a> [lite\_reservation](#input\_lite\_reservation) | n/a | <pre>list(object({<br/>    id                  = any<br/>    name                = string<br/>    throughput_capacity = number<br/>  }))</pre> | `[]` | no |
| <a name="input_lite_subscription"></a> [lite\_subscription](#input\_lite\_subscription) | n/a | <pre>list(object({<br/>    id       = any<br/>    name     = string<br/>    topic_id = any<br/>    region   = optional(string)<br/>    zone     = optional(string)<br/>    delivery_config = optional(list(object({<br/>      delivery_requirement = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_lite_topic"></a> [lite\_topic](#input\_lite\_topic) | n/a | <pre>list(object({<br/>    id     = any<br/>    name   = string<br/>    region = optional(string)<br/>    zone   = optional(string)<br/>    partition_config = optional(list(object({<br/>      count                 = number<br/>      publish_mib_per_sec   = optional(number)<br/>      subscribe_mib_per_sec = optional(number)<br/>    })), [])<br/>    retention_config = optional(list(object({<br/>      per_partition_bytes = string<br/>      period              = optional(string)<br/>    })), [])<br/>    reservation_config = optional(list(object({<br/>      throughput_reservation = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | n/a | <pre>list(object({<br/>    id         = any<br/>    name       = string<br/>    type       = optional(string)<br/>    definition = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_schema_iam_binding"></a> [schema\_iam\_binding](#input\_schema\_iam\_binding) | n/a | <pre>list(object({<br/>    id        = any<br/>    members   = list(string)<br/>    role      = string<br/>    schema_id = any<br/>  }))</pre> | `[]` | no |
| <a name="input_subscription"></a> [subscription](#input\_subscription) | n/a | <pre>list(object({<br/>    id                           = any<br/>    name                         = string<br/>    topic_id                     = any<br/>    labels                       = optional(map(string))<br/>    ack_deadline_seconds         = optional(number)<br/>    message_retention_duration   = optional(string)<br/>    retain_acked_messages        = optional(bool)<br/>    filter                       = optional(string)<br/>    enable_message_ordering      = optional(bool)<br/>    enable_exactly_once_delivery = optional(bool)<br/>    bigquery_config = optional(list(object({<br/>      table                 = string<br/>      use_table_schema      = optional(bool)<br/>      use_topic_schema      = optional(bool)<br/>      write_metadata        = optional(bool)<br/>      drop_unknown_fields   = optional(bool)<br/>      service_account_email = optional(string)<br/>    })), [])<br/>    cloud_storage_config = optional(list(object({<br/>      filename_prefix          = optional(string)<br/>      filename_suffix          = optional(string)<br/>      filename_datetime_format = optional(string)<br/>      max_duration             = optional(string)<br/>      max_bytes                = optional(number)<br/>      max_messages             = optional(number)<br/>      avro_config = optional(list(object({<br/>        write_metadata   = optional(bool)<br/>        use_topic_schema = optional(bool)<br/>      })), [])<br/>    })), [])<br/>    push_config = optional(list(object({<br/>      push_endpoint = string<br/>      attributes    = optional(map(string))<br/>      oidc_token = optional(list(object({<br/>        service_account_email = string<br/>        audience              = optional(string)<br/>      })))<br/>      no_wrapper = optional(list(object({<br/>        write_metadata = bool<br/>      })))<br/>    })), [])<br/>    expiration_policy = optional(list(object({<br/>      ttl = string<br/>    })), [])<br/>    dead_letter_policy = optional(list(object({<br/>      dead_letter_topic     = optional(string)<br/>      max_delivery_attempts = optional(number)<br/>    })), [])<br/>    retry_policy = optional(list(object({<br/>      maximum_backoff = optional(string)<br/>      minimum_backoff = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_subscription_iam_binding"></a> [subscription\_iam\_binding](#input\_subscription\_iam\_binding) | n/a | <pre>list(object({<br/>    id              = any<br/>    members         = list(string)<br/>    role            = string<br/>    subscription_id = any<br/>  }))</pre> | `[]` | no |
| <a name="input_topic"></a> [topic](#input\_topic) | n/a | <pre>list(object({<br/>    id                         = any<br/>    name                       = string<br/>    labels                     = optional(map(string))<br/>    message_retention_duration = optional(string)<br/>    ingestion_data_source_settings = optional(list(object({<br/>      aws_kinesis = optional(list(object({<br/>        aws_role_arn        = string<br/>        consumer_arn        = string<br/>        gcp_service_account = string<br/>        stream_arn          = string<br/>      })), [])<br/>      cloud_storage = optional(list(object({<br/>        bucket                     = any<br/>        minimum_object_create_time = optional(string)<br/>        match_glob                 = optional(string)<br/>      })), [])<br/>      platform_logs_settings = optional(list(object({<br/>        severity = optional(string)<br/>      })), [])<br/>    })), [])<br/>    message_storage_policy = optional(list(object({<br/>      allowed_persistence_regions = list(string)<br/>      enforce_in_transit          = optional(bool)<br/>    })), [])<br/>    schema_settings = optional(list(object({<br/>      schema   = string<br/>      encoding = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_topic_iam_binding"></a> [topic\_iam\_binding](#input\_topic\_iam\_binding) | n/a | <pre>list(object({<br/>    id       = any<br/>    members  = list(string)<br/>    role     = string<br/>    topic_id = any<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_pubsub_lite_reservation_name"></a> [google\_pubsub\_lite\_reservation\_name](#output\_google\_pubsub\_lite\_reservation\_name) | # google\_pubsub\_lite\_reservation |
| <a name="output_google_pubsub_lite_reservation_throughput_capacity"></a> [google\_pubsub\_lite\_reservation\_throughput\_capacity](#output\_google\_pubsub\_lite\_reservation\_throughput\_capacity) | n/a |
| <a name="output_google_pubsub_lite_subscription_name"></a> [google\_pubsub\_lite\_subscription\_name](#output\_google\_pubsub\_lite\_subscription\_name) | # google\_pubsub\_lite\_subscription |
| <a name="output_google_pubsub_lite_subscription_topic"></a> [google\_pubsub\_lite\_subscription\_topic](#output\_google\_pubsub\_lite\_subscription\_topic) | n/a |
| <a name="output_google_pubsub_lite_topic_name"></a> [google\_pubsub\_lite\_topic\_name](#output\_google\_pubsub\_lite\_topic\_name) | # google\_pubsub\_lite\_topic |
| <a name="output_google_pubsub_lite_topic_partition_config"></a> [google\_pubsub\_lite\_topic\_partition\_config](#output\_google\_pubsub\_lite\_topic\_partition\_config) | n/a |
| <a name="output_google_pubsub_lite_topic_reservation_config"></a> [google\_pubsub\_lite\_topic\_reservation\_config](#output\_google\_pubsub\_lite\_topic\_reservation\_config) | n/a |
| <a name="output_google_pubsub_lite_topic_retention_config"></a> [google\_pubsub\_lite\_topic\_retention\_config](#output\_google\_pubsub\_lite\_topic\_retention\_config) | n/a |
| <a name="output_google_pubsub_schema_iam_binding_id"></a> [google\_pubsub\_schema\_iam\_binding\_id](#output\_google\_pubsub\_schema\_iam\_binding\_id) | # google\_pubsub\_schema\_iam\_binding |
| <a name="output_google_pubsub_schema_iam_binding_schema"></a> [google\_pubsub\_schema\_iam\_binding\_schema](#output\_google\_pubsub\_schema\_iam\_binding\_schema) | n/a |
| <a name="output_google_pubsub_schema_name"></a> [google\_pubsub\_schema\_name](#output\_google\_pubsub\_schema\_name) | # google\_pubsub\_schema |
| <a name="output_google_pubsub_subscription_iam_binding_id"></a> [google\_pubsub\_subscription\_iam\_binding\_id](#output\_google\_pubsub\_subscription\_iam\_binding\_id) | # google\_pubsub\_subscription\_iam\_binding |
| <a name="output_google_pubsub_subscription_name"></a> [google\_pubsub\_subscription\_name](#output\_google\_pubsub\_subscription\_name) | # google\_pubsub\_subscription |
| <a name="output_google_pubsub_subscription_topic"></a> [google\_pubsub\_subscription\_topic](#output\_google\_pubsub\_subscription\_topic) | n/a |
| <a name="output_google_pubsub_topic_iam_binding_id"></a> [google\_pubsub\_topic\_iam\_binding\_id](#output\_google\_pubsub\_topic\_iam\_binding\_id) | # google\_pubsub\_topic\_iam\_binding |
| <a name="output_google_pubsub_topic_iam_binding_topic"></a> [google\_pubsub\_topic\_iam\_binding\_topic](#output\_google\_pubsub\_topic\_iam\_binding\_topic) | n/a |
| <a name="output_google_pubsub_topic_name"></a> [google\_pubsub\_topic\_name](#output\_google\_pubsub\_topic\_name) | # google\_pubsub\_topic |
