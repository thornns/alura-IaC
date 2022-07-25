output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  value       = aws_instance.alura01.public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = aws_instance.alura01.private_ip
}