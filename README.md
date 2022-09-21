# TerraEC2+Ansible+Jenkins


- Ansible + Terraform - A terraform code to create a VPC and its components, create an EC2 instance and install Jenkins on the EC2 instance using Ansible, run ansible command within/from terraform itself. Try to print the jenkins default password as an output using bash script. 

1) Create an EC2 instance and VPC

2) Create a Security Group and whitelist the port 22, 80, 443 and 8080.

3) Fetch the Public IP

4) Run Ansible Playbook

   - Install Java, Install Jenkins

   - Print Jenkins default password


   ![174525141-39a32cbc-f215-4ebd-93f8-2e836ceb264e](https://user-images.githubusercontent.com/85149943/191419688-f0c2f824-9d9d-4aa5-a4ea-ba2554104cf2.png)
