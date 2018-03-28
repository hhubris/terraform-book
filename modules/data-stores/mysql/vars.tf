variable "db_name" {
  description = "The database name, default example"
  default = "example"
}

variable "db_user" {
  description = "The database username, default admin"
  default = "admin"
}

variable "db_password" {
  description = "The password for the example mysql db"
}

variable "skip_final_snapshot" {
  description = "Determines if a final snapshot is required before a DB is removed, default false"
  default = false
}

