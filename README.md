# Inference Server for Bot Score Prediction

## Overview
This project implements a RESTful inference server using FastAPI to predict the probability of a transaction being performed by a bot. The server is containerized using Docker and prepared for cloud deployment with Terraform.

---

## Features
- **Model Integration**: Uses a pre-trained logistic regression model.
- **RESTful API**: A POST endpoint at `/bot-score` for predictions.
- **Performance**: Targets a p99 latency of under 200ms.
- **Persistence**: Logs all requests and responses to an S3 bucket.
- **Containerization**: Deployable via Docker.
- **Infrastructure as Code**: Terraform scripts for cloud deployment.
- **Unit Testing**: Comprehensive test cases for functionality and performance.

---

## Prerequisites
1. **Software**:
   - Python 3.9+
   - Docker
   - Terraform
   - AWS CLI (for cloud resource management)

2. **Dependencies**:
   - FastAPI
   - Uvicorn
   - Scikit-learn
   - Boto3

3. **AWS Configuration**:
   - This is for cloud deployment of the server. Here AWS is taken as an example. It can be deployed in any cloud using Terraform Scripts being modified accordingly.
   - Set up AWS credentials using `aws configure`.

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

### 4. Deploy with Terraform
1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```
2. Apply the configuration:
   ```bash
   terraform apply
   ```
   Confirm the resource creation when prompted.

### 5. Testing
Run unit tests:
```bash
pytest tests/
```

---

## API Reference
### Endpoint: `/bot-score`
**Method**: `POST`

**Request Body Schema**:
```json
{
  "x1": 0.1,
  "x2": 0.2
}
```

**Response**:
```json
{
  "p_bot": 0.123
}
```

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

## Production Readiness
- **Scaling**: Used ECS auto-scaling to handle traffic spikes.
- **Security**: Implement IAM roles for S3 and ECS task access.
- **Error Handling**: Add retry logic for S3 operations and robust error handling in the API.
- **Load Testing**: Use tools like Locust to simulate high traffic and measure performance.

---

