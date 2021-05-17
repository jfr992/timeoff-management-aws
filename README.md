<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">timeoff-management-deploy-traditional</h3>

  <p align="center">
    CI/CD Pipeline to deploy/update timeoff-management app using Cloudformation, CodeBuild and CodeDeploy.
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#architecture">Architecture of the solution</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This repo contains the steps and the code needed to deploy the infrastructure and componentes needed to deploy the timeoff-management app. It can be reproduced if the guide is followed strictly.

### Built With

This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.
* [timeoff-management-application](https://github.com/timeoff-management/timeoff-management-application)
* [AWS Cloudformation]
* [AWS CodeDeploy]
* [AWS CodeBuild]
* [Other Services: AWS SSM, S3, AWS CloudWatch]


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

- Fork the timeoff-management-application to your repositories to work from a feature/branch for the source-control deploy.

- aws cli V2.0

- An additional subnet if the default vpc is used.

- Nat gateway for the EC2 instances to access internet (download and install packages).

- 2 adittional routes for each subnet to access the internet: adding the entry 0.0.0.0/0 and link it to the previously created NAT Gateway.

- Link previously created routes to the private subnets.

- If public acess needed create an additional subnet and allow internet access with an InternetGateway.

- IAM user with proper permissions to use the CLI (AWS ACCESS KEY ID AND SECRET ACESS KEY).

- Personal access token from github (ref:https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)

### Architecture diagrams of the solution
1.  Infrastructure to host the app

<p align="center">
  <a href="https://github.com/jfr992/timeoff-management-aws">
    <img src="images/infrastructure.png" alt="infrastructure" width="700" height="600">
  </a>
</p>

2.  Pipeline to deploy infrastructure

<br />
<p align="center">
  <a href="https://github.com/jfr992/timeoff-management-aws">
    <img src="images/infrapipeline.png" alt="infrapipeline" width="700" height="600">
  </a>
</p>

3.  CI/CD deployment

<br />
<p align="center">
  <a href="https://github.com/jfr992/timeoff-management-aws">
    <img src="images/pipeline.png" alt="pipeline" width="700" height="600">
  </a>
</p>

### Steps to deploy the solution

1. Create the additional resources mentioned in pre-requisites section with aws cli or management console.

2. Configure AWS CLI to access your account.
   ```sh
   aws configure
   ```
3. Create or update an AWS Secret for the github access token.
   ```sh
   aws secretsmanager create-secret --name githubaccess-token --secret-string '{"token":"<PERSONALTOKENHERE>"}' --region <REGION-HERE>
   ```
4. Deploy the previous infrastructure using AWS CLI and cloudformation
   ```sh
   aws cloudformation create-stack --stack-name previous-infrastructure --template-body file://path/to/previous-infrastructure.yaml --parameters file://previous-infrastructure.json --capabilities CAPABILITY_IAM
   ```
  Wait for the stack to get in CREATE_COMPLETE STATE

  <p align="center">
    <a href="https://github.com/jfr992/timeoff-management-aws">
      <img src="images/previousInfrastructuredeploystack.png" alt="previousInfrastructuredeploystack" style="width:100%">
    </a>
  </p>

5. After the stacks is deployed, the infrastructure pipeline triggers the creation of the infrastructure stack to host the timeoff-management app (see architecture diagram)

  <p align="center">
    <a href="https://github.com/jfr992/timeoff-management-aws">
      <img src="images/infrastack.png" alt="infrastack" style="width:100%">
    </a>
  </p>

  Wait for the EC2 instances to get in a healthy state:

  <p align="center">
    <a href="https://github.com/jfr992/timeoff-management-aws">
      <img src="images/ec2healthy.png" alt="ec2healthy" style="width:100%">
    </a>
  </p>

6. Deploy the app deploy stack using AWS CLI and cloudformation

   ```sh
  aws cloudformation create-stack --stack-name app-deploy --template-body file:///path/to/app-deploy.yaml --parameters file:///path/toapp-deploy.json --capabilities CAPABILITY_IAM
   ```
  
  Wait for the stack to be in CREATE_COMPLETE STATE

  <p align="center">
    <a href="https://github.com/jfr992/timeoff-management-aws">
      <img src="images/appdeploystack.png" alt="ec2healthy" style="width:100%">
    </a>
  </p>

7. After the stacks is deployed, the app pipeline triggers the deployment of the timeoff-management app to the ec2 instances.

    <div class="row">
      <div class="column">
        <img src="images/apppipelineinprogress.png" alt="apppipelineinprogress" style="width:100%">
      </div>
      <div class="column">
        <img src="images/apppipelinesteps.png" alt="apppipelinesteps" style="width:100%">
      </div>
      <div class="column">
        <img src="images/codedeployprogress.png" alt="codedeployprogress" style="width:100%">
      </div>
    </div>

8. Wait for CodeDeploy to update the app on each instance, and check that the target groups are in healthy state:

    <div class="row">
      <div class="column">
        <img src="images/codedeployhooks.png" alt="codedeployhooks" style="width:100%">
      </div>
      <div class="column">
        <img src="images/httptg.png" alt="httptg" style="width:100%">
      </div>
      <div class="column">
        <img src="images/httpstg.png" alt="httpstg" style="width:100%">
      </div>
    </div>


<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://https://github.com/jfr992/timeoff-management-aws/issues) for a list of proposed features (and known issues).



