# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

* [Introduction](#introduction)
* [Instructions](#instructions)
* [Output](#output)

## Introduction
This project is part of the Udacity Azure ML Nanodegree.\
In order to deploy a customizable, scalable web server in Azure, Packer and Terraform is used. Instructions as well as the output is detailed below.

## Instructions
### Policy
Before getting started, I created a policy that ensures all indexed resources are tagged and deny deployment if they do not.

It was created in the terminal (first screenshot) but also visible in the Azure portal (second screenshot). The policy is written in a `policy.json` file.

![tagging-policy](./policy/tagging-policy.png)

![tagging-policy-portal](./policy/tagging-policy-portal.png)

### Packer
As a second step, I used Packer to create a server image in order to support the application deployment later on with Terraform. 

Instructions:
1. Log in to Azure CLI: `az login`.
2. Create Azure resource group for the server image: `az group create`. Alternatively done in the Azure portal.
3. Create Azure credentials: `az ad sp create-for-rbac`.
4. Define `server.json` packer template: This template builds an Ubuntu 16.04 LTS image, installs NGINX, then deprovisions the VM.
5. Set variabales: Either using the command line, using a file or using environment variables. I used the latter and set my environment variables as temporarily by using the `export` command in the terminal.
6. Build packer image by running `packer build server.json` in the terminal.

Once it is finishe building the packer image, you can see in the portal as following:
![packer](./packer/packer.png)

### Terraform
Text

## Output
Text