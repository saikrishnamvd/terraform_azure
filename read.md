# Inference Server for Bot Score Prediction

## Overview
This project implements a RESTful inference server using FastAPI to predict the probability of a transaction being performed by a bot. The server is containerized using Docker and prepared for cloud deployment with Terraform.

---

## Features
- **API Endpoint**: A single POST endpoint at `/bot-score` to serve predictions.
- **Dockerized**: Fully containerized for portability and deployment.
- **Cloud Storage Integration**: Logs requests and responses to AWS S3.
- **Performance**: Optimized for sub-200ms p99 latency.
- **Infrastructure as Code**: Terraform scripts for AWS cloud deployment.
- **Unit Testing**: Comprehensive tests to ensure robustness.
- **Port Configuration**: Runs on port 8887 as specified.

---

## Prerequisites
1. **Software**:
   - Python 3.9+ with pip.
   - Docker: Ensure Docker is installed and running.
   - Terraform: Installed and configured with AWS credentials.
   - AWS CLI (for cloud resource management)

2. **AWS Configuration**:
   - Set up AWS credentials using `aws configure`.
   - S3 bucket created for logging requests and responses.
   - IAM user with access to S3 and EC2.
     
3. **Dependencies**:
   - FastAPI
   - Uvicorn
   - Scikit-learn
   - Boto3

---

## Installation and Usage

### 1. Install Python Dependencies
```bash
pip install -r requirements.txt
```

### 2. Run Locally
If you want to run the server locally, Start the FastAPI server:
```bash
uvicorn app.main:app --host 0.0.0.0 --port 8887
```
Access the API documentation at `http://localhost:8887/docs`. and POST endpoint at `/bot-score` for predictions.

### 3. Docker Setup
Build and run the Docker container:
```bash
docker build -t inference-server .
docker run -p 8887:8887 inference-server
```

### 4. Test the API
Send a POST request to `http://localhost:8887/bot-score` :
   ```bash
   curl -X POST http://localhost:8887/bot-score \
    -H "Content-Type: application/json" \
    -d @sample-body.json
   ```
Expected Response:
   ```json
   {
    "p_bot": 0.123
}
   ```
   
## Cloud Deployment with Terraform
1. **Configure AWS Credentials**: Set AWS credentials as environment variables:
   ```bash
   export AWS_ACCESS_KEY_ID=<your-access-key>
   export AWS_SECRET_ACCESS_KEY=<your-secret-key>
   ```
2. **Initialize Terraform**:
   ```bash
   cd terraform/
   terraform init
   ```
3. **Apply Terraform Scripts**:
   ```bash
   terraform apply
   ```
4. **Access the Server**:
   Once the deployment is complete, Terraform will output the public URL of the server. Use this URL to send POST requests.

---

## Monitoring and Logs
  - **AWS CloudWatch**:
      - Monitor server performance, logs, and resource utilization.
  - **Request Logging**:
      - Requests and responses are stored in an S3 bucket for analytics.
  - **Performance Metrics**:
      - p99 latency is monitored via logs and CloudWatch alarms.

---


## Deployment
### Steps:
1. Build the Docker image and push it to a container registry (e.g., AWS ECR).
2. Deploy the infrastructure using the provided Terraform scripts.
3. The ECS service will run the Docker container, and the load balancer DNS will expose the API.

### Monitoring:
- **AWS CloudWatch**: Monitor ECS metrics such as CPU and memory usage.
- **Custom Logs**: Store request/response logs in the S3 bucket.

---
### 5. Testing
Run unit tests:
```bash
pytest tests/
```
---

## Production Readiness
- **Scaling**: Used ECS auto-scaling to handle traffic spikes.
- **Security**: Implement IAM roles for S3 and ECS task access.
- **Error Handling**: Add retry logic for S3 operations and robust error handling in the API.
- **Load Testing**: Use tools like Locust to simulate high traffic and measure performance.

---
