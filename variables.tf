variable "lite_topic" {
  type = list(object({
    name   = string
    region = optional(string)
    zone   = optional(string)
    partition_config = optional(list(object({
      count                 = number
      publish_mib_per_sec   = optional(number)
      subscribe_mib_per_sec = optional(number)
    })), [])
    retention_config = optional(list(object({
      per_partition_bytes = string
      period              = optional(string)
    })), [])
    reservation_config = optional(list(object({
      throughput_reservation = optional(string)
    })), [])
    subscription = optional(list(object({
      name                 = string
      region               = optional(string)
      zone                 = optional(string)
      delivery_requirement = string
    })))
    reservation = optional(list(object({
      name                = string
      throughput_capacity = number
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for a in var.lite_topic.*.subscription : true if a != null && contains(["DELIVER_IMMEDIATELY", "DELIVER_AFTER_STORED", "DELIVERY_REQUIREMENT_UNSPECIFIED"], a[0].delivery_requirement)])
    error_message = "Valid values are : DELIVER_IMMEDIATELY, DELIVER_AFTER_STORED, DELIVERY_REQUIREMENT_UNSPECIFIED."
  }
}

variable "schema" {
  type = list(object({
    id         = any
    name       = string
    type       = optional(string)
    definition = optional(string)
    iam = optional(list(object({
      members = list(string)
      role    = string
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for b in var.schema : true if b != null && contains(["TYPE_UNSPECIFIED", "PROTOCOL_BUFFER", "AVRO"], b.type)])
    error_message = "Valid values are : TYPE_UNSPECIFIED, PROTOCOL_BUFFER, AVRO."
  }
}

variable "subscription" {
  type = list(object({
    id                           = any
    name                         = string
    topic_id                     = any
    labels                       = optional(map(string))
    ack_deadline_seconds         = optional(number)
    message_retention_duration   = optional(string)
    retain_acked_messages        = optional(bool)
    filter                       = optional(string)
    enable_message_ordering      = optional(bool)
    enable_exactly_once_delivery = optional(bool)
    bigquery_config = optional(list(object({
      table                 = string
      use_table_schema      = optional(bool)
      use_topic_schema      = optional(bool)
      write_metadata        = optional(bool)
      drop_unknown_fields   = optional(bool)
      service_account_email = optional(string)
    })), [])
    cloud_storage_config = optional(list(object({
      filename_prefix          = optional(string)
      filename_suffix          = optional(string)
      filename_datetime_format = optional(string)
      max_duration             = optional(string)
      max_bytes                = optional(number)
      max_messages             = optional(number)
      bucket                   = optional(string)
      service_account_email    = optional(string)
      avro_config = optional(list(object({
        write_metadata   = optional(bool)
        use_topic_schema = optional(bool)
      })), [])
    })), [])
    push_config = optional(list(object({
      push_endpoint = string
      attributes    = optional(map(string))
      oidc_token = optional(list(object({
        service_account_email = string
        audience              = optional(string)
      })))
      no_wrapper = optional(list(object({
        write_metadata = bool
      })))
    })), [])
    expiration_policy = optional(list(object({
      ttl = string
    })), [])
    dead_letter_policy = optional(list(object({
      dead_letter_topic     = optional(string)
      max_delivery_attempts = optional(number)
    })), [])
    retry_policy = optional(list(object({
      maximum_backoff = optional(string)
      minimum_backoff = optional(string)
    })), [])
    iam = optional(list(object({
      members = list(string)
      role    = string
    })))
  }))
  default = []
}

variable "topic" {
  type = list(object({
    id                         = any
    name                       = string
    labels                     = optional(map(string))
    message_retention_duration = optional(string)
    ingestion_data_source_settings = optional(list(object({
      aws_kinesis = optional(list(object({
        aws_role_arn        = string
        consumer_arn        = string
        gcp_service_account = string
        stream_arn          = string
      })), [])
      cloud_storage = optional(list(object({
        bucket                     = any
        minimum_object_create_time = optional(string)
        match_glob                 = optional(string)
      })), [])
      platform_logs_settings = optional(list(object({
        severity = optional(string)
      })), [])
    })), [])
    message_storage_policy = optional(list(object({
      allowed_persistence_regions = list(string)
      enforce_in_transit          = optional(bool)
    })), [])
    schema_settings = optional(list(object({
      schema   = string
      encoding = optional(string)
    })), [])
    iam = optional(list(object({
      members = list(string)
      role    = string
    })))
  }))
  default = []
}