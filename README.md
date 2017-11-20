# .NET Core ECS demo

Deployment requirements:
* Terraform (https://terraform.io)
* Docker (https://www.docker.com/)

Deploy the ECR repository:
```
cd terraform/ecr-repo
terraform plan
terraform apply
```

Build the Docker container:
```
docker build --rm -f Dockerfile -t dotnet-ecs-demo:latest .
```

Login to ECR and push the Docker image:
```
aws ecr get-login
docker tag dotnet-ecs-demo <AWS ACCOUNT ID>.dkr.ecr.us-east-1.amazonaws.com/dotnet-ecs-demo:latest
docker push <AWS ACCOUNT ID>.dkr.ecr.us-east-1.amazonaws.com/dotnet-ecs-demo
```

Deploy the ECS cluster and the demo container:
```
cd terraform
terraform plan
terraform apply
```
