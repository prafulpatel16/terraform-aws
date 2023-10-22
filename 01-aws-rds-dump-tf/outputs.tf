#output "rds_endpoint" {
#  value = aws_db_instance.rds-demo.endpoint
#}

output "Prafuls-Webserver-Public-IP" {
  value = aws_instance.webserver.public_ip
}

