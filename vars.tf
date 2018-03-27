variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}


variable "public_server_port" {
  description = "The public port that ELB will listen on"
  default = 80
}
