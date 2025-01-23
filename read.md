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
If you want to run the Server with Docker Container, Build and run the Docker container:
```bash
docker build -t inference-server .
docker run -p 8887:8887 inference-server
```
Access the API documentation at `http://localhost:8887/docs`. and POST endpoint at `/bot-score` for predictions.

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
---

## Cloud Deployment with Terraform
In order to deploy the infra using IaS Tool i.e., Terraform, follow the below steps.
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

## Considerations for Production
  - **Scalability**:
      - Use AWS Elastic Load Balancer and auto-scaling groups to handle traffic spikes.
  - **Security**:
      - Implement HTTPS with an SSL certificate.
      - Use IAM roles for secure access to S3 and EC2 resources.
  - **Observability**:
      - Integrate with Prometheus and Grafana for advanced monitoring.
  - **Fault Tolerance**:
      - Deploy the server in multiple availability zones.
   
---

## Unit Testing
Run the test suite to ensure functionality::
```bash
pytest tests/
```
---

## Conclusion
This project demonstrates a robust, scalable, and cloud-ready inference server. The clear separation of concerns, use of best practices, and attention to production readiness make it suitable for real-world deployment.

---
