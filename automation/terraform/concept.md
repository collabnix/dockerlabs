## Defining terms

I’ll be using a lot of terms throughout the series that have a specific meaning in Terraform, so I’ll try to define them here first.

Variable – Similar to any programming language, variables hold values. They can be strings, lists, or maps. Terraform has interpolation capabilities for combining variables and processing them with built in functions.

Provider – A provider is the configuration for a specific service provider, such as AWS.

State – When Terraform performs work, it saves the current state of your infrastructure in a file with a .tfstate extension. The file is formatted in JSON and typically you should never need to edit it. It is recommended that this be stored in a central location with a locking mechanism for team collaboration. It may contain secrets in plain text and should be kept safe. It is not recommended to use a VCS service for this, as the manual pull/push process is ripe for human error.

Backend – Terraform stores the state of your environment in a JSON file. By default, this file is stored in the same directory as where you run the command, but it can be configured to store remotely, such as on AWS S3. Some backends support locking so two people cannot operate on it at the same time. Terraform can use AWS DynamoDB as a simple key/value store to facilitate locking.

Resource – A resource is a piece of infrastructure, such as an EC2 instance, a DNS entry, a database, etc. A resource provides all the logic for creating, updating, reading, and deleting itself. Resources are provider specific.

Data Resource – While Resources create or change things, Data Resources retrieve or generate data. Data Resources are used to look up information, render templates, retrieve remote Terraform states, etc.

Module – Any folder with .tf files in it is technically a module. You can bundle configurations into modules to simplify common sets of infrastructure for easy reuse.

Output – When running Terraform, you can use outputs to display specific values. Outputs are also used to export information from a module or a remote Terraform environment. You can think of outputs as public properties of a class.

Environment – In Terraform, an environment is represented by a state file. You can break your infrastructure down into multiple environments to reduce the blast radius should you make a mistake or something go wrong in the process of applying changes. Terraform has the ability to access the outputs of another environment so that you can reference values from one environment in another.
