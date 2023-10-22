### 🚀 Introduction

In the dynamic world of cloud computing, mastering the right tools and technologies is the key to unleashing your full potential. In this journey, we'll explore a comprehensive toolkit of AWS services and other essential tools that every cloud enthusiast and aspiring cloud engineer should be familiar with. Buckle up as we dive into a world of cloud possibilities!

![Cloud Journey](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9taxkdh30w8o03a630fg.png)

### Objective

The objective of this post is to share knowledge about #aws cloud services, how to use them, and where to consume these services to solve real-world business challenges.

### 🚀 Use Case

In a real-world scenario, our database team faced the challenge of deploying database services and importing substantial data dumps for a migration project. This project aimed to transfer a large volume of data into a MySQL database before launching a web application.

### 💡 Solution

I embraced this challenge and embarked on a mission to efficiently resolve the migration of massive data dumps to an #aws RDS MySQL database. And I did it the smart way - with automation, leveraging the power of Terraform.

**Solution Diagram:**

![Solution Diagram](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/u0qkkmxlm76gr8ye9l8b.png)

Stay tuned for an exciting journey into the world of seamless database migration in the AWS cloud. 🌥️💾💼

#### 💻 Tools & Technologies Covered

Let's take a closer look at the tools and technologies we'll be delving into:

#### AWS Services

🌐 VPC (Virtual Private Cloud) - Create isolated network environments in the AWS cloud.
🔒 Security Groups - Define and manage inbound/outbound traffic rules to your AWS resources.
💻 EC2 Machine (Elastic Compute Cloud) - Launch scalable virtual servers in the cloud.
🗄️ AWS RDS (Relational Database Service) - MySQL - Manage MySQL databases with ease, handled by AWS.

#### Other Tools

🔧 Terraform - The Infrastructure as Code tool to automate and manage cloud resources.
🐙 GitHub - Collaborate, store, and version your code effectively.
🖋️ VS Code (Visual Studio Code) - A versatile, free code editor for a seamless development experience.

**1. Manual way to create AWS RDS MySQL instance**

1. Search for "RDS" in the AWS Console and click on the RDS result under Services.

![RDS Console](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/49wsuhj48rkp1i11j8q7.png)

2. In the RDS dashboard, click "Subnet Groups" from the left-hand menu.

![Subnet Groups](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/t80ever8t605tcktylzf.png)

3. Create a Security Group for your RDS instance.

![Create Security Group](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/tbk4d242dv5ovm42na6b.png)

4. Create your Database.

![Create Database](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/q0jpt79dycsrxw5zdkgl.png)

5. Go to AWS Systems Manager and click on Session Manager.

![AWS Systems Manager](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ycrs7kel6fongucnutmg.png)

6. Start a Session.

![Session Manager](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/sg27ie9ec3oqci2tyeor.png)

7. Log in to the session and install the MySQL client.

![Install MySQL Client](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/vhvsldvbh67l0xspdb3x.png)

8. Go to your RDS instance and copy the RDS Endpoint.

![RDS Endpoint](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/pxzfxrwsv6zhddlhswxc.png)

9. Log in to MySQL.

```shell
mysql -h <RDS Endpoint> -u <Username> -p <DB Name>
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/sm2wxczsp0q3spjeg52s.png)

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/w4doyywvdwk7ixfr7flv.png)


**2. Automated way to create AWS RDS instance and import datadump .sql file**

