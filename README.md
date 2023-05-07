# This project

This project creates a containerized web service project. The project uses [Terraform](https://www.terraform.io/) to define and deploy a containerized Node.js web service on [Amazon Elastic Container Service (Amazon ECS)](https://aws.amazon.com/pm/ecs/). The project deploys a containerized app to an Amazon ECS cluster on AWS Fargate serverless compute. After your workflow runs successfully, the sample web service is publicly available through the Application Load Balancer.

The deployed application can be accessed at https://dev.quest.nbekenov.com/

## Project Structure

`/iac` contains the infrastructure as code (IaC) terraform files.

`/src` contains the application source code

`/test` contains dummy unit tests for application.

`/bin` contains the frontend source code.  

`/.codecatalyst` conatins workflow definition

`/scripts` helper scrips used in the workflow

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