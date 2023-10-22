
---

# Terraform AWS RDS Database Dump Automation and RDS Provisioning

## Objective

The objective of this Terraform script is to automate the provisioning of key AWS resources, including an Amazon RDS (Relational Database Service) instance and an Amazon EC2 (Elastic Compute Cloud) instance. This script also transfers and executes SQL scripts on the EC2 instance to interact with the RDS database.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Terraform Configuration](#terraform-configuration)
- [Usage](#usage)
- [Key Components](#key-components)
- [License](#license)

## Prerequisites

Before using this script, make sure you have the following prerequisites in place:

1. **AWS CLI Configuration:** Ensure that you have the AWS CLI configured with valid access keys. You should have the necessary permissions to create and manage RDS instances and EC2 instances.

2. **Terraform Installation:** Make sure Terraform is installed on your local machine. You can download and install Terraform from the [official Terraform website](https://www.terraform.io/downloads.html).

## Terraform Configuration

1. **Modify Variables:** In the `variables.tf` file, you can set various variables to match your specific requirements. These variables include the AWS region, RDS credentials, EC2 instance details, and more.

2. **SSH Key Pair:** Ensure that an SSH key pair is available for the EC2 instance. The `aws_key_pair` resource in the Terraform configuration should be updated with your key name and the path to your public key.

3. **SQL Scripts:** This script expects two files, `obbs.sql` and `connect_to_rds.sh`, to be present in the same directory as the Terraform configuration. Make sure these files are available, and customize them if needed.

4. **Security Group Rules:** The security group rules are configured to allow incoming traffic on common ports (e.g., 3306 for MySQL, 22 for SSH, and 80 for HTTP) for the EC2 instance. Adjust the security group rules in the `aws_security_group` resource to meet your security requirements.

5. **Customization:** Feel free to adjust other settings and configurations in the Terraform script to align with your specific use case and infrastructure needs.

## Usage

1. **Initialize Configuration:** Run the following command to initialize the Terraform configuration:

   ```shell
   terraform init
   ```

2. **Plan the Infrastructure:** Use the following command to see what changes will be applied without actually making any changes:

   ```shell
   terraform plan
   ```

3. **Apply the Configuration:** Execute the following command to create the AWS resources based on the Terraform configuration:

   ```shell
   terraform apply
   ```

4. **SQL Script Execution:** After the resources are created, the SQL script `obbs.sql` will be transferred to the EC2 instance. The `connect_to_rds.sh` script will be executed on the EC2 instance to connect to the RDS instance and import the SQL dump.

5. **Destroy Resources:** To remove the AWS resources when they are no longer needed, use the following command:

   ```shell
   terraform destroy
   ```

## Key Components

- **aws_db_instance**:
  - Defines the AWS RDS instance with configurations like allocated storage, instance type, and security group settings.

- **aws_security_group**:
  - Specifies security group rules to allow incoming traffic to the EC2 instance, including SSH, HTTP, and MySQL (port 3306).

- **aws_key_pair**:
  - Creates an AWS key pair for the EC2 instance, facilitating SSH access.

- **aws_instance**:
  - Provisions the EC2 instance with specified configurations, including the Amazon Machine Image (AMI), instance type, and security group.

- **null_resource**:
  - Used for local and remote execution of scripts to transfer the SQL dump file and execute the `connect_to_rds.sh` script on the EC2 instance.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---


---

**Note:** Ensure that the actual `obbs.sql` and `connect_to_rds.sh` files are properly configured and have the necessary logic for your use case. The provided README assumes the presence of these files in the same directory as the Terraform configuration.