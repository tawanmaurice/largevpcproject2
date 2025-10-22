# EC2 demo outputs
output "web_public_ip"  { value = aws_instance.web.public_ip }
output "web_public_dns" { value = aws_instance.web.public_dns }
output "web_http_url"   { value = "http://${aws_instance.web.public_dns}" }
