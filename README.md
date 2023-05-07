# This project

This project creates a containerized web service project. The project uses [Terraform](https://www.terraform.io/) to define and deploy a containerized Node.js web service on [Amazon Elastic Container Service (Amazon ECS)](https://aws.amazon.com/pm/ecs/). The project deploys a containerized app to an Amazon ECS cluster on AWS Fargate serverless compute. After your workflow runs successfully, the sample web service is publicly available through the Application Load Balancer.

`/iac` contains the infrastructure as code (IaC) terraform files.

`/src` contains the application source code

`/bin` contains the frontend source code.  


## Usage

```
npm install
npm start
```

Go to [http://localhost:3000](http://localhost:3000/)

## Usage with Docker

```
docker build -t quest:latest .
docker run -p 3000:3000 quest:latest
```

## Running Tests

```
npm run build
npm test
trivy image quest:latest
```