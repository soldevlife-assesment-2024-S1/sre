# Create a new RDS instance
terraform init

# Plan the creation of the RDS instance
terraform plan

# Apply the plan
terraform apply -auto-approve -var="identifier=ticket-service" -var="tags_name=ticket-service"
terraform apply -auto-approve -var="identifier=booking-service" -var="tags_name=booking-service"
terraform apply -auto-approve -var="identifier=user-service" -var="tags_name=user-service"
terraform apply -auto-approve -var="identifier=recommendation-service" -var="tags_name=recommendation-service"

