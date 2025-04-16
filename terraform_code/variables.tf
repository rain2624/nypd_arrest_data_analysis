variable "credentials" {
  description = "My credentials"
  default     = "./keys/my_cred.json"
}

variable "project" {
  description = "Name of the project"
  default     = "elaborate-haven-440913-q2"
}

variable "region" {
  description = "Project Location"
  default     = "us-central1"
}

variable "bucket" {
  description = "Name of the bucket"
  default     = "elaborate-haven-440913-q2-nypd-arrest-data"
}

variable "location" {
  description = "Project location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "big-query dataset name"
  default     = "nypd_arrest_data"
}
