# Automated Web App Deployment on AWS using Terraform & Docker

An automated DevOps micro-project showcasing Infrastructure as Code (IaC) and Containerization practices.

## 🛠️ Technologies Used
* **Operating System:** Ubuntu Linux
* **Containerization:** Docker
* **Infrastructure as Code:** Terraform
* **Cloud Provider:** Amazon Web Services (AWS EC2)
* **Web Server:** Nginx

## 🚀 Project Architecture & Workflow
1. **Containerization:** Created a custom Docker image packaging a custom HTML web page served by Nginx.
2. **Infrastructure provisioning:** Utilized Terraform to dynamically provision an AWS EC2 instance (`t3.micro`) alongside automated Security Groups (opening ports 22 and 8080).
3. **Automated Bootstrapping:** Configured EC2 `user_data` to automatically install Docker, clone this GitHub repository, build the custom image, and run the container upon server initialization.

## 📄 How to Run
1. Configure AWS Credentials.
2. Initialize Terraform: `terraform init`
3. Deploy to AWS: `terraform apply --auto-approve`
