# Using docker cluster CLI

```
[Captains-Bay]🚩 >  docker pull docker/cluster:v0.3.0
v0.3.0: Pulling from docker/cluster
bdf0201b3a05: Pull complete 
227965e0be77: Pull complete 
656c27da0276: Downloading  10.18MB/98.87MB
6bc49ae6e7fa: Download complete 
ddbd7883b3bf: Download complete 
90dd03face76: Download complete 
cb5cae322035: Download complete 
c0c9485136e8: Download complete 
a5ab55def61b: Download complete 
ddbd7b624dc0: Download complete
```

```
[Captains-Bay]🚩 >  docker cluster rm fervent_taussig
Removing fervent_taussig                                                   [OK]
Removing: [==========                                                    ] 17%
```

```
docker tag docker/cluster:v0.3.0 dockereng/cluster:v0.3.0
```

```
[Captains-Bay]🚩 >  docker cluster create -f cluster.yml --log-level debug
Please provide a value for ucp_password
DEBU[0009] Image Ref: sha256:ea8a7a832f839d48f478e37602cb7f67207be6f612c3a00aeafa42ca9f155214 
DEBU[0009] Generating public/private rsa key pair.      
DEBU[0010] Your identification has been saved in /data/keys/ssh/id_rsa. 
DEBU[0010] Your public key has been saved in /data/keys/ssh/id_rsa.pub. 
DEBU[0010] The key fingerprint is:                      
DEBU[0010] SHA256:CnQ4M5/f+2AOXj+azUVReBfjjpqidplBRrAbbtiu+dY cluster@a1f8091cbb6a 
DEBU[0010] The key's randomart image is:                
DEBU[0010] +---[RSA 2048]----+                          
DEBU[0010] |       ..      +o|                          
DEBU[0010] |     .  ..    o.+|                          
DEBU[0010] |    * .o.     .o.|                          
DEBU[0010] |   . *+.oo    o. |                          
DEBU[0010] |    ..o=S    ... |                          
DEBU[0010] |     .oo o  o.   |                          
DEBU[0010] |      ..+.Oo  .  |                          
DEBU[0010] |      o+.E.B..   |                          
DEBU[0010] |     o+oo =o=.   |                          
DEBU[0010] +----[SHA256]-----+                          
DEBU[0010] Planning cluster on aws                      
DEBU[0010] Initializing modules...          
DEBU[0010] - module.cloud                               
DEBU[0010]   Getting source "terraform/modules/aws_cloud" 
DEBU[0010] - module.platform                            
DEBU[0010]   Getting source "terraform/modules/docker/enterprise" 
DEBU[0010] - module.managers                            
DEBU[0010]   Getting source "terraform/modules/aws_instance" 
DEBU[0010] - module.registry                            
DEBU[0010]   Getting source "terraform/modules/aws_instance" 
DEBU[0010] - module.managers.inventory                  
DEBU[0010]   Getting source "../docker/hosts"           
DEBU[0010] - module.registry.inventory                  
DEBU[0010]   Getting source "../docker/hosts"           
DEBU[0010]                                              
DEBU[0010] Initializing provider plugins... 
DEBU[0010] - Checking for available provider plugins on https://releases.hashicorp.com... 
DEBU[0011] - Downloading plugin for provider "local" (1.2.2)... 
DEBU[0011] - Downloading plugin for provider "aws" (1.60.0)... 
DEBU[0011] - Downloading plugin for provider "template" (2.1.2)... 
DEBU[0012]                                              
DEBU[0012] The following providers do not have any version constraints in configuration, 
DEBU[0012] so the latest version was installed.         
DEBU[0012]                                              
DEBU[0012] To prevent automatic upgrades to new major versions that may contain breaking 
DEBU[0012] changes, it is recommended to add version = "..." constraints to the 
DEBU[0012] corresponding provider blocks in configuration, with the constraint strings 
DEBU[0012] suggested below.                             
DEBU[0012]                                              
DEBU[0012] * provider.local: version = "~> 1.2"         
DEBU[0012] * provider.template: version = "~> 2.1"      
DEBU[0012]                                              
DEBU[0012] Terraform has been successfully initialized! 
DEBU[0012]                                     
DEBU[0012] You may now begin working with Terraform. Try running "terraform plan" to see 
DEBU[0012] any changes that are required for your infrastructure. All Terraform commands 
DEBU[0012] should now work.                             
DEBU[0012]                                              
DEBU[0012] If you ever set or change modules or backend configuration for Terraform, 
DEBU[0012] rerun this command to reinitialize your working directory. If you forget, other 
DEBU[0012] commands will detect it and remind you to do so if necessary. 
DEBU[0017] data.template_file.ucp: Refreshing state... 
DEBU[0017] data.template_file.groups: Refreshing state... 
DEBU[0017] data.template_file.registry: Refreshing state... 
DEBU[0017] data.template_file.dtr: Refreshing state... 
DEBU[0017] data.template_file.engine: Refreshing state... 
DEBU[0017] data.template_file.subscription: Refreshing state... 
DEBU[0017] data.template_file.nopasswords: Refreshing state... 
DEBU[0018] data.template_file.nopasswords: Refreshing state... 
DEBU[0018] data.template_file.names: Refreshing state... 
DEBU[0018] data.template_file.names: Refreshing state... 
DEBU[0022] data.aws_availability_zones.available: Refreshing state... 
DEBU[0022] data.aws_region.current: Refreshing state... 
DEBU[0022] data.aws_ami.ami: Refreshing state... 
DEBU[0022] data.aws_availability_zones.available: Refreshing state... 
DEBU[0022] data.aws_ami.ami: Refreshing state... 
DEBU[0022] data.aws_availability_zones.available: Refreshing state... 
DEBU[0022] data.aws_region.current: Refreshing state... 
DEBU[0030] module.platform.local_file.registry_inventory: Creating... 
DEBU[0030]   content:  "" => "# This file has been generated by terraform\n[all:vars]\nregistry_url=https://index.docker.io/v1/\nregistry_username=ajeetraina\nregistry_password=Oracle9ias\n" 
DEBU[0030]   filename: "" => "ansible/inventory/2.platform.registry" 
DEBU[0030] module.platform.local_file.registry_inventory: Creation complete after 0s (ID: e79f52419f3c332d8c75c5053f4ab7434099a8e1) 
DEBU[0030] module.platform.local_file.groups: Creating... 
DEBU[0030]   content:  "" => "# Group declarations to ensure missing groups don't break inventory\n[linux-ucp]\n\n[linux-managers]\n\n[linux-workers]\n\n[linux-dtr]\n\n[windows-workers]\n\n# This file has been generated by terraform\n# UCP.\n#\n# Linux Node Configuration\n#\n[linux-managers:children]\nlinux-ucp\n\n[linux:children]\nlinux-managers\nlinux-workers\nlinux-dtr\n\n[linux:vars]\nansible_become=yes\n\n#\n# Windows Node Configuration\n#\n[windows:children]\nwindows-workers\n\n[windows:vars]\nwindows_enabled=yes\nansible_connection=winrm\nansible_winrm_server_cert_validation=ignore\nansible_become=no\nansible_winrm_operation_timeout_sec=250\nansible_winrm_read_timeout_sec=360\nansible_winrm_message_encryption=never\n\n# Managers.\n[managers:children]\nlinux-ucp\n\n# Workers.\n[workers:children]\nlinux-workers\nlinux-dtr\nwindows-workers\n\n[cluster:children]\nmanagers\nworkers\n" 
DEBU[0030]   filename: "" => "ansible/inventory/3.groups" 
DEBU[0030] module.platform.local_file.subscription_inventory: Creating... 
DEBU[0030]   content:  "" => "# This file has been generated by terraform\n[all:vars]\n#license_path=\n#subscription=\n" 
DEBU[0030]   filename: "" => "ansible/inventory/2.platform.subscription" 
DEBU[0030] module.platform.local_file.engine_inventory: Creating... 
DEBU[0030]   content:  "" => "# This file has been generated by terraform\n[all:vars]\nenable_kubernetes_aws_ebs = False\nenable_kubernetes_aws_efs = False\nenable_kubernetes_aws_load_balancer = False\nenable_kubernetes_azure_disk = False\nenable_kubernetes_azure_file = False\nenable_kubernetes_azure_load_balancer = False\nenable_kubernetes_cloud_provider = False\nenable_kubernetes_nfs_storage = False\nenable_offline_install = False\nprovider = \"aws\"\nengine_version=ee-test-19.03\nengine_repository_url=https://storebits.docker.com/ee/m/sub-a3dd83ed-d9db-440f-a175-e11347fb1037/\n#engine_storage_driver=\n#engine_storage_fstype=\nengine_storage_volume=/dev/xvdb\nengine_enable_fips=\nengine_enable_remote_tcp=False\nengine_ca_file=\nengine_ca_key_file=\n" 
DEBU[0030]   filename: "" => "ansible/inventory/2.platform.engine" 
DEBU[0030] module.platform.local_file.dtr_inventory: Creating... 
DEBU[0030]   content:  "" => "# This file has been generated by terraform\n[all:vars]\n#dtr_ca_file=\n#dtr_cert_file=\ndtr_install_options=\n#dtr_key_file=\ndtr_version=docker/dtr:2.7.0-beta4\n" 
DEBU[0030]   filename: "" => "ansible/inventory/2.platform.dtr" 
DEBU[0030] module.platform.local_file.engine_inventory: Creation complete after 0s (ID: bb299b2b35df228b5cdf8ad9fbe482f4d7add4d2) 
DEBU[0030] module.platform.local_file.dtr_inventory: Creation complete after 0s (ID: 868950680fcdbe781a0e4dc582aacad43386ad2c) 
DEBU[0030] module.platform.local_file.groups: Creation complete after 0s (ID: af5c4e90097ace337d25eea9709bb99d9f69ccfc) 
DEBU[0030] module.platform.local_file.subscription_inventory: Creation complete after 0s (ID: 748c73aaa4a3202764249da3830c41e8055e3a79) 
DEBU[0030] module.platform.local_file.ucp_inventory: Creating... 
DEBU[0030]   content:  "" => "# This file has been generated by terraform\n[all:vars]\ndocker_worker_orchestration=swarm\nucp_version=docker/ucp:3.2.0-beta4\nucp_admin_username=admin\nucp_admin_password=Oracle9ias\n#ucp_ca_file=\n#ucp_cert_file=\n#ucp_key_file=\nucp_storage_driver=\nucp_install_options=\nucp_anonymize_tracking=False\nucp_audit_level=\nucp_auto_refresh=True\nucp_azure_ip_count=\nucp_backend=managed\nucp_calico_mtu=1480\nucp_cloud_provider=\nucp_cluster_label=prod\nucp_cni_installer_url=\nucp_controller_port=443\nucp_custom_header_name=\nucp_custom_header_value=\nucp_custom_kube_api_server_flags=\nucp_custom_kube_controller_manager_flags=\nucp_custom_kube_scheduler_flags=\nucp_custom_kubelet_flags=\nucp_default_new_user_role=restrictedcontrol\nucp_default_node_orchestrator=swarm\nucp_disable_tracking=False\nucp_disable_usageinfo=False\nucp_dns=\nucp_dns_opt=\nucp_dns_search=\nucp_enable_admin_ucp_scheduling=True\nucp_external_service_lb=\nucp_host_address=\nucp_log_host=\nucp_idpMetadataURL=\nucp_image_repository=docker\nucp_install_args=\nucp_ipip_mtu=1480\nucp_kube_apiserver_port=6443\nucp_kv_snapshot_count=20000\nucp_kv_timeout=5000\nucp_lifetime_minutes=60\nucp_local_volume_collection_mapping=False\nucp_log_level=DEBUG\nucp_managedPasswordDisabled=False\nucp_managedPasswordFallbackUser=\nucp_manager_kube_reserved_resources=cpu=1,memory=2Gi,ephemeral-storage=4Gi\nucp_metrics_disk_usage_interval=\nucp_metrics_retention_time=\nucp_metrics_scrape_interval=1m\nucp_nodeport_range=32768-35535\nucp_per_user_limit=10\nucp_pod_cidr=\nucp_profiling_enabled=False\nucp_log_protocol=\nucp_renewal_threshold_minutes=20\nucp_require_content_trust=False\nucp_require_signature_from=\nucp_rethinkdb_cache_size=1GB\nucp_rootCerts=\nucp_samlEnabled=False\nucp_samlLoginText=\nucp_service_id=\nucp_spHost=\nucp_storage_driver=\nucp_support_dump_include_audit_logs=False\nucp_swarm_port=2376\nucp_swarm_strategy=spread\nucp_tlsSkipVerify=False\nucp_unmanaged_cni=False\nucp_worker_kube_reserved_resources=cpu=100m,memory=300Mi,ephemeral-storage=500Mi" 
DEBU[0030]   filename: "" => "ansible/inventory/2.platform.ucp" 
DEBU[0030] module.platform.local_file.ucp_inventory: Creation complete after 0s (ID: 56c86b21c5786151ce23d237d523e3fec754b95f) 
DEBU[0034] module.cloud.aws_key_pair.deployer: Creating... 
DEBU[0034]   fingerprint: "" => "<computed>"            
DEBU[0034]   key_name:    "" => "cluster_67fb8cb05043"  
DEBU[0034]   public_key:  "" => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdfF06bx91+9uXedWz1Q54XYXFIzxwHTVVq3M+nc+CrROCoFvnIq4hhsXJxZCro8XBxA3F3Q2ZyNktSDUrgd6DwXmAmwFc+ZcOAyV+UE1maivrv1AZN/2DB+x2w5y7ssb+6o/GFPLDs/TbNvFWnByM6auO6Oxuqc1qnG+E4BOekyOnDWyJ1yt7amJjPtWuUopO2hsyq2XTReC5zyQttdnrXAaFrwLPI/CkN5bQIGeLZckjQ6VU7/OVuEkpU5rDUeV8nCPr4QO2HkhtXV3lb/AY8WHWd9UKAd4kV5sTd+GM5Vu9tSuX5hu9u0z1YseWX2oBphJ+TNIlIEByf9gtnUZ5 cluster@a1f8091cbb6a" 
DEBU[0034] module.cloud.aws_vpc.docker: Creating... 
DEBU[0034]   arn:                              "" => "<computed>" 
DEBU[0034]   assign_generated_ipv6_cidr_block: "" => "false" 
DEBU[0034]   cidr_block:                       "" => "172.31.0.0/16" 
DEBU[0034]   default_network_acl_id:           "" => "<computed>" 
DEBU[0034]   default_route_table_id:           "" => "<computed>" 
DEBU[0034]   default_security_group_id:        "" => "<computed>" 
DEBU[0034]   dhcp_options_id:                  "" => "<computed>" 
DEBU[0034]   enable_classiclink:               "" => "<computed>" 
DEBU[0034]   enable_classiclink_dns_support:   "" => "<computed>" 
DEBU[0034]   enable_dns_hostnames:             "" => "true" 
DEBU[0034]   enable_dns_support:               "" => "true" 
DEBU[0034]   instance_tenancy:                 "" => "default" 
DEBU[0034]   ipv6_association_id:              "" => "<computed>" 
DEBU[0034]   ipv6_cidr_block:                  "" => "<computed>" 
DEBU[0034]   main_route_table_id:              "" => "<computed>" 
DEBU[0034]   owner_id:                         "" => "<computed>" 
DEBU[0034]   tags.%:                           "" => "7" 
DEBU[0034]   tags.CLUSTER_CREATED:             "" => "2019-05-28T17:25:57Z" 
DEBU[0034]   tags.CLUSTER_ID:                  "" => "67fb8cb05043" 
DEBU[0034]   tags.CLUSTER_NAME:                "" => "fervent_taussig" 
DEBU[0034]   tags.CLUSTER_VERSION:             "" => "v0.3.0" 
DEBU[0034]   tags.Name:                        "" => "67fb8cb05043-vpc" 
DEBU[0034]   tags.pet:                         "" => "true" 
DEBU[0034]   tags.project:                     "" => "CSG-DCI" 
DEBU[0034] module.cloud.aws_iam_role.worker: Creating... 
DEBU[0034]   arn:                   "" => "<computed>"  
DEBU[0034]   assume_role_policy:    "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}\n" 
DEBU[0034]   create_date:           "" => "<computed>"  
DEBU[0034]   force_detach_policies: "" => "false"       
DEBU[0034]   max_session_duration:  "" => "3600"        
DEBU[0034]   name:                  "" => "67fb8cb05043_worker" 
DEBU[0034]   path:                  "" => "/"           
DEBU[0034]   unique_id:             "" => "<computed>" 
DEBU[0036] module.cloud.aws_key_pair.deployer: Creation complete after 3s (ID: cluster_67fb8cb05043) 
DEBU[0037] module.cloud.aws_iam_role.worker: Creation complete after 3s (ID: 67fb8cb05043_worker) 
DEBU[0037] module.cloud.aws_iam_role_policy.worker: Creating... 
DEBU[0037]   name:   "" => "67fb8cb05043_worker"        
DEBU[0037]   policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n        {\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"ec2:CreateTags\",\n\n        \"ec2:CreateSnapshot\",\n        \"ec2:DeleteSnapshot\",\n\n        \"ec2:CreateVolume\",\n        \"ec2:DeleteVolume\",\n\n        \"logs:CreateLogStream\",\n        \"logs:PutLogEvents\",\n        \"cloudwatch:PutMetricData\"\n      ],\n      \"Resource\": \"*\"\n    },\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"s3:*\",\n      \"Resource\": [ \"arn:aws:s3:::kubernetes-*\" ]\n    },\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"ec2:Describe*\",\n      \"Resource\": \"*\"\n    },\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"ec2:AttachVolume\",\n      \"Resource\": \"*\"\n    },\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"ec2:DetachVolume\",\n      \"Resource\": \"*\"\n    },\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": [ \"route53:*\" ],\n      \"Resource\": [ \"*\" ]\n    }\n  ]\n}\n" 
DEBU[0037]   role:   "" => "67fb8cb05043_worker"    
DEBU[0037] module.cloud.aws_iam_instance_profile.worker: Creating... 
DEBU[0037]   arn:         "" => "<computed>"            
DEBU[0037]   create_date: "" => "<computed>"            
DEBU[0037]   name:        "" => "67fb8cb05043_worker"   
DEBU[0037]   path:        "" => "/"                     
DEBU[0037]   role:        "" => "67fb8cb05043_worker"   
DEBU[0037]   roles.#:     "" => "<computed>"            
DEBU[0037]   unique_id:   "" => "<computed>"        
DEBU[0040] module.cloud.aws_iam_role_policy.worker: Creation complete after 4s (ID: 67fb8cb05043_worker:67fb8cb05043_worker) 
DEBU[0040] module.cloud.aws_iam_instance_profile.worker: Creation complete after 4s (ID: 67fb8cb05043_worker) 
DEBU[0044] module.cloud.aws_vpc.docker: Still creating... (10s elapsed) 
DEBU[0054] module.cloud.aws_vpc.docker: Still creating... (20s elapsed) 
DEBU[0054] module.cloud.aws_vpc.docker: Creation complete after 21s (ID: vpc-0532fe34947834a78) 
DEBU[0055] module.cloud.aws_security_group.ssh: Creating... 
DEBU[0055]   arn:                    "" => "<computed>" 
DEBU[0055]   description:            "" => "Security Group for SSH" 
DEBU[0055]   egress.#:               "" => "<computed>" 
DEBU[0055]   ingress.#:              "" => "<computed>" 
DEBU[0055]   name:                   "" => "67fb8cb05043_ssh" 
DEBU[0055]   owner_id:               "" => "<computed>" 
DEBU[0055]   revoke_rules_on_delete: "" => "false"      
DEBU[0055]   tags.%:                 "" => "6"          
DEBU[0055]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0055]   tags.pet:               "" => "true"       
DEBU[0055]   tags.project:           "" => "CSG-DCI"    
DEBU[0055]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_subnet.pubsubnet[4]: Creating... 
DEBU[0055]   arn:                             "" => "<computed>" 
DEBU[0055]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0055]   availability_zone:               "" => "us-east-1e" 
DEBU[0055]   availability_zone_id:            "" => "<computed>" 
DEBU[0055]   cidr_block:                      "" => "172.31.64.0/20" 
DEBU[0055]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0055]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0055]   map_public_ip_on_launch:         "" => "true" 
DEBU[0055]   owner_id:                        "" => "<computed>" 
DEBU[0055]   tags.%:                          "" => "7" 
DEBU[0055]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0055]   tags.Name:                       "" => "67fb8cb05043-Subnet-5" 
DEBU[0055]   tags.pet:                        "" => "true" 
DEBU[0055]   tags.project:                    "" => "CSG-DCI" 
DEBU[0055]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_security_group.kubernetes: Creating... 
DEBU[0055]   arn:                    "" => "<computed>" 
DEBU[0055]   description:            "" => "Security Group for Kubernetes traffic" 
DEBU[0055]   egress.#:               "" => "<computed>" 
DEBU[0055]   ingress.#:              "" => "<computed>" 
DEBU[0055]   name:                   "" => "67fb8cb05043_kubernetes" 
DEBU[0055]   owner_id:               "" => "<computed>" 
DEBU[0055]   revoke_rules_on_delete: "" => "false"      
DEBU[0055]   tags.%:                 "" => "6"          
DEBU[0055]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0055]   tags.pet:               "" => "true"       
DEBU[0055]   tags.project:           "" => "CSG-DCI"    
DEBU[0055]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_security_group.cluster: Creating... 
DEBU[0055]   arn:                    "" => "<computed>" 
DEBU[0055]   description:            "" => "Security Group for Docker" 
DEBU[0055]   egress.#:               "" => "<computed>" 
DEBU[0055]   ingress.#:              "" => "<computed>" 
DEBU[0055]   name:                   "" => "67fb8cb05043_cluster" 
DEBU[0055]   owner_id:               "" => "<computed>" 
DEBU[0055]   revoke_rules_on_delete: "" => "false"      
DEBU[0055]   tags.%:                 "" => "6"          
DEBU[0055]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0055]   tags.pet:               "" => "true"       
DEBU[0055]   tags.project:           "" => "CSG-DCI"    
DEBU[0055]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_security_group.ingress: Creating... 
DEBU[0055]   arn:                    "" => "<computed>" 
DEBU[0055]   description:            "" => "Security Group for Kubernetes Ingress traffic" 
DEBU[0055]   egress.#:               "" => "<computed>" 
DEBU[0055]   ingress.#:              "" => "<computed>" 
DEBU[0055]   name:                   "" => "67fb8cb05043_ingress" 
DEBU[0055]   owner_id:               "" => "<computed>" 
DEBU[0055]   revoke_rules_on_delete: "" => "false"      
DEBU[0055]   tags.%:                 "" => "6"          
DEBU[0055]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0055]   tags.pet:               "" => "true"       
DEBU[0055]   tags.project:           "" => "CSG-DCI"    
DEBU[0055]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_security_group.https: Creating... 
DEBU[0055]   arn:                    "" => "<computed>" 
DEBU[0055]   description:            "" => "Security Group for HTTPS traffic" 
DEBU[0055]   egress.#:               "" => "<computed>" 
DEBU[0055]   ingress.#:              "" => "<computed>" 
DEBU[0055]   name:                   "" => "67fb8cb05043_https" 
DEBU[0055]   owner_id:               "" => "<computed>" 
DEBU[0055]   revoke_rules_on_delete: "" => "false"      
DEBU[0055]   tags.%:                 "" => "6"          
DEBU[0055]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0055]   tags.pet:               "" => "true"       
DEBU[0055]   tags.project:           "" => "CSG-DCI"    
DEBU[0055]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_subnet.pubsubnet[5]: Creating... 
DEBU[0055]   arn:                             "" => "<computed>" 
DEBU[0055]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0055]   availability_zone:               "" => "us-east-1f" 
DEBU[0055]   availability_zone_id:            "" => "<computed>" 
DEBU[0055]   cidr_block:                      "" => "172.31.80.0/20" 
DEBU[0055]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0055]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0055]   map_public_ip_on_launch:         "" => "true" 
DEBU[0055]   owner_id:                        "" => "<computed>" 
DEBU[0055]   tags.%:                          "" => "7" 
DEBU[0055]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0055]   tags.Name:                       "" => "67fb8cb05043-Subnet-6" 
DEBU[0055]   tags.pet:                        "" => "true" 
DEBU[0055]   tags.project:                    "" => "CSG-DCI" 
DEBU[0055]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_internet_gateway.igw: Creating... 
DEBU[0055]   owner_id:             "" => "<computed>"   
DEBU[0055]   tags.%:               "0" => "7"           
DEBU[0055]   tags.CLUSTER_CREATED: "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:      "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:    "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION: "" => "v0.3.0"       
DEBU[0055]   tags.Name:            "" => "InternetGateway" 
DEBU[0055]   tags.pet:             "" => "true"         
DEBU[0055]   tags.project:         "" => "CSG-DCI"      
DEBU[0055]   vpc_id:               "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_subnet.pubsubnet[0]: Creating... 
DEBU[0055]   arn:                             "" => "<computed>" 
DEBU[0055]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0055]   availability_zone:               "" => "us-east-1a" 
DEBU[0055]   availability_zone_id:            "" => "<computed>" 
DEBU[0055]   cidr_block:                      "" => "172.31.0.0/20" 
DEBU[0055]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0055]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0055]   map_public_ip_on_launch:         "" => "true" 
DEBU[0055]   owner_id:                        "" => "<computed>" 
DEBU[0055]   tags.%:                          "" => "7" 
DEBU[0055]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0055]   tags.Name:                       "" => "67fb8cb05043-Subnet-1" 
DEBU[0055]   tags.pet:                        "" => "true" 
DEBU[0055]   tags.project:                    "" => "CSG-DCI" 
DEBU[0055]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0055] module.cloud.aws_subnet.pubsubnet[2]: Creating... 
DEBU[0055]   arn:                             "" => "<computed>" 
DEBU[0055]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0055]   availability_zone:               "" => "us-east-1c" 
DEBU[0055]   availability_zone_id:            "" => "<computed>" 
DEBU[0055]   cidr_block:                      "" => "172.31.32.0/20" 
DEBU[0055]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0055]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0055]   map_public_ip_on_launch:         "" => "true" 
DEBU[0055]   owner_id:                        "" => "<computed>" 
DEBU[0055]   tags.%:                          "" => "7" 
DEBU[0055]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0055]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0055]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0055]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0055]   tags.Name:                       "" => "67fb8cb05043-Subnet-3" 
DEBU[0055]   tags.pet:                        "" => "true" 
DEBU[0055]   tags.project:                    "" => "CSG-DCI" 
DEBU[0055]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0061] module.cloud.aws_subnet.pubsubnet[2]: Creation complete after 7s (ID: subnet-07ac9ceedb115e5cb) 
DEBU[0061] module.cloud.aws_subnet.pubsubnet[1]: Creating... 
DEBU[0061]   arn:                             "" => "<computed>" 
DEBU[0061]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0061]   availability_zone:               "" => "us-east-1b" 
DEBU[0061]   availability_zone_id:            "" => "<computed>" 
DEBU[0061]   cidr_block:                      "" => "172.31.16.0/20" 
DEBU[0061]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0061]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0061]   map_public_ip_on_launch:         "" => "true" 
DEBU[0061]   owner_id:                        "" => "<computed>" 
DEBU[0061]   tags.%:                          "" => "7" 
DEBU[0061]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0061]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0061]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0061]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0061]   tags.Name:                       "" => "67fb8cb05043-Subnet-2" 
DEBU[0061]   tags.pet:                        "" => "true" 
DEBU[0061]   tags.project:                    "" => "CSG-DCI" 
DEBU[0061]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0061] module.cloud.aws_subnet.pubsubnet[5]: Creation complete after 7s (ID: subnet-06d5eb0f0add817ce) 
DEBU[0061] module.cloud.aws_subnet.pubsubnet[3]: Creating... 
DEBU[0061]   arn:                             "" => "<computed>" 
DEBU[0061]   assign_ipv6_address_on_creation: "" => "false" 
DEBU[0061]   availability_zone:               "" => "us-east-1d" 
DEBU[0061]   availability_zone_id:            "" => "<computed>" 
DEBU[0061]   cidr_block:                      "" => "172.31.48.0/20" 
DEBU[0061]   ipv6_cidr_block:                 "" => "<computed>" 
DEBU[0061]   ipv6_cidr_block_association_id:  "" => "<computed>" 
DEBU[0061]   map_public_ip_on_launch:         "" => "true" 
DEBU[0061]   owner_id:                        "" => "<computed>" 
DEBU[0061]   tags.%:                          "" => "7" 
DEBU[0061]   tags.CLUSTER_CREATED:            "" => "2019-05-28T17:25:57Z" 
DEBU[0061]   tags.CLUSTER_ID:                 "" => "67fb8cb05043" 
DEBU[0061]   tags.CLUSTER_NAME:               "" => "fervent_taussig" 
DEBU[0061]   tags.CLUSTER_VERSION:            "" => "v0.3.0" 
DEBU[0061]   tags.Name:                       "" => "67fb8cb05043-Subnet-4" 
DEBU[0061]   tags.pet:                        "" => "true" 
DEBU[0061]   tags.project:                    "" => "CSG-DCI" 
DEBU[0061]   vpc_id:                          "" => "vpc-0532fe34947834a78" 
DEBU[0061] module.cloud.aws_subnet.pubsubnet[4]: Creation complete after 7s (ID: subnet-0fb2f91ed09ce5b53) 
DEBU[0061] module.cloud.aws_security_group.winrm: Creating... 
DEBU[0061]   arn:                    "" => "<computed>" 
DEBU[0061]   description:            "" => "Security Group for winrm connections" 
DEBU[0061]   egress.#:               "" => "<computed>" 
DEBU[0061]   ingress.#:              "" => "<computed>" 
DEBU[0061]   name:                   "" => "67fb8cb05043_winrm" 
DEBU[0061]   owner_id:               "" => "<computed>" 
DEBU[0061]   revoke_rules_on_delete: "" => "false"      
DEBU[0061]   tags.%:                 "" => "6"          
DEBU[0061]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0061]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0061]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0061]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0061]   tags.pet:               "" => "true"       
DEBU[0061]   tags.project:           "" => "CSG-DCI"    
DEBU[0061]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0062] module.cloud.aws_subnet.pubsubnet[0]: Creation complete after 7s (ID: subnet-0203d65c759718494) 
DEBU[0062] module.cloud.aws_security_group.interlock: Creating... 
DEBU[0062]   arn:                    "" => "<computed>" 
DEBU[0062]   description:            "" => "Security Group for Interlock traffic" 
DEBU[0062]   egress.#:               "" => "<computed>" 
DEBU[0062]   ingress.#:              "" => "<computed>" 
DEBU[0062]   name:                   "" => "67fb8cb05043_interlock" 
DEBU[0062]   owner_id:               "" => "<computed>" 
DEBU[0062]   revoke_rules_on_delete: "" => "false"      
DEBU[0062]   tags.%:                 "" => "6"          
DEBU[0062]   tags.CLUSTER_CREATED:   "" => "2019-05-28T17:25:57Z" 
DEBU[0062]   tags.CLUSTER_ID:        "" => "67fb8cb05043" 
DEBU[0062]   tags.CLUSTER_NAME:      "" => "fervent_taussig" 
DEBU[0062]   tags.CLUSTER_VERSION:   "" => "v0.3.0"     
DEBU[0062]   tags.pet:               "" => "true"       
DEBU[0062]   tags.project:           "" => "CSG-DCI"    
DEBU[0062]   vpc_id:                 "" => "vpc-0532fe34947834a78" 
DEBU[0062] module.cloud.aws_internet_gateway.igw: Creation complete after 8s (ID: igw-0836abc8af6bd80fd) 
DEBU[0062] module.cloud.aws_route_table.public_igw: Creating... 
DEBU[0062]   owner_id:                                   "" => "<computed>" 
DEBU[0062]   propagating_vgws.#:                         "" => "<computed>" 
DEBU[0062]   route.#:                                    "" => "1" 
DEBU[0062]   route.4220526484.cidr_block:                "" => "0.0.0.0/0" 
DEBU[0062]   route.4220526484.egress_only_gateway_id:    "" => "" 
DEBU[0062]   route.4220526484.gateway_id:                "" => "igw-0836abc8af6bd80fd" 
DEBU[0062]   route.4220526484.instance_id:               "" => "" 
DEBU[0062]   route.4220526484.ipv6_cidr_block:           "" => "" 
DEBU[0062]   route.4220526484.nat_gateway_id:            "" => "" 
DEBU[0062]   route.4220526484.network_interface_id:      "" => "" 
DEBU[0062]   route.4220526484.transit_gateway_id:        "" => "" 
DEBU[0062]   route.4220526484.vpc_peering_connection_id: "" => "" 
DEBU[0062]   tags.%:                                     "" => "7" 
DEBU[0062]   tags.CLUSTER_CREATED:                       "" => "2019-05-28T17:25:57Z" 
DEBU[0062]   tags.CLUSTER_ID:                            "" => "67fb8cb05043" 
DEBU[0062]   tags.CLUSTER_NAME:                          "" => "fervent_taussig" 
DEBU[0062]   tags.CLUSTER_VERSION:                       "" => "v0.3.0" 
DEBU[0062]   tags.Name:                                  "" => "67fb8cb05043-rt" 
DEBU[0062]   tags.pet:                                   "" => "true" 
DEBU[0062]   tags.project:                               "" => "CSG-DCI" 
DEBU[0062]   vpc_id:                                     "" => "vpc-0532fe34947834a78" 
DEBU[0064] module.cloud.aws_security_group.https: Creation complete after 9s (ID: sg-022f2590a9fb6bad2) 
DEBU[0064] module.cloud.aws_security_group_rule.https: Creating... 
DEBU[0064]   cidr_blocks.#:            "" => "1"        
DEBU[0064]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0064]   from_port:                "" => "443"      
DEBU[0064]   protocol:                 "" => "tcp"      
DEBU[0064]   security_group_id:        "" => "sg-022f2590a9fb6bad2" 
DEBU[0064]   self:                     "" => "false"    
DEBU[0064]   source_security_group_id: "" => "<computed>" 
DEBU[0064]   to_port:                  "" => "443"      
DEBU[0064]   type:                     "" => "ingress" 
DEBU[0064] module.cloud.aws_security_group.ssh: Creation complete after 9s (ID: sg-0b8bbd0cd6e3b1d73) 
DEBU[0064] module.cloud.aws_security_group_rule.ssh: Creating... 
DEBU[0064]   cidr_blocks.#:            "" => "1"        
DEBU[0064]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0064]   from_port:                "" => "22"       
DEBU[0064]   protocol:                 "" => "tcp"      
DEBU[0064]   security_group_id:        "" => "sg-0b8bbd0cd6e3b1d73" 
DEBU[0064]   self:                     "" => "false"    
DEBU[0064]   source_security_group_id: "" => "<computed>" 
DEBU[0064]   to_port:                  "" => "22"       
DEBU[0064]   type:                     "" => "ingress" 
DEBU[0064] module.cloud.aws_security_group.cluster: Creation complete after 10s (ID: sg-0adbb2979b6921116) 
DEBU[0064] module.cloud.aws_security_group_rule.allow_all_egress: Creating... 
DEBU[0064]   cidr_blocks.#:            "" => "1"        
DEBU[0064]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0064]   from_port:                "" => "0"        
DEBU[0064]   protocol:                 "" => "-1"       
DEBU[0064]   security_group_id:        "" => "sg-0adbb2979b6921116" 
DEBU[0064]   self:                     "" => "false"    
DEBU[0064]   source_security_group_id: "" => "<computed>" 
DEBU[0064]   to_port:                  "" => "0"        
DEBU[0064]   type:                     "" => "egress" 
DEBU[0064] module.cloud.aws_security_group.kubernetes: Creation complete after 10s (ID: sg-017c826222c74bf16) 
DEBU[0064] module.cloud.aws_security_group.ingress: Creation complete after 10s (ID: sg-0419cbbf5746a52fb) 
DEBU[0064] module.cloud.aws_security_group_rule.allow_all_self: Creating... 
DEBU[0064]   from_port:                "" => "0"        
DEBU[0064]   protocol:                 "" => "-1"       
DEBU[0064]   security_group_id:        "" => "sg-0adbb2979b6921116" 
DEBU[0064]   self:                     "" => "true"     
DEBU[0064]   source_security_group_id: "" => "<computed>" 
DEBU[0064]   to_port:                  "" => "0"        
DEBU[0064]   type:                     "" => "ingress" 
DEBU[0064] module.cloud.aws_security_group_rule.kubernetes: Creating... 
DEBU[0064]   cidr_blocks.#:            "" => "1"        
DEBU[0064]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0064]   from_port:                "" => "6443"     
DEBU[0064]   protocol:                 "" => "tcp"      
DEBU[0064]   security_group_id:        "" => "sg-017c826222c74bf16" 
DEBU[0064]   self:                     "" => "false"    
DEBU[0064]   source_security_group_id: "" => "<computed>" 
DEBU[0064]   to_port:                  "" => "6443"     
DEBU[0064]   type:                     "" => "ingress" 
DEBU[0067] module.cloud.aws_security_group_rule.https: Creation complete after 4s (ID: sgrule-1545955024) 
DEBU[0067] module.cloud.aws_security_group_rule.ssh: Creation complete after 4s (ID: sgrule-1524674719) 
DEBU[0068] module.cloud.aws_security_group_rule.ingress_https: Creating... 
DEBU[0068]   cidr_blocks.#:            "" => "1"        
DEBU[0068]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0068]   from_port:                "" => "35443"    
DEBU[0068]   protocol:                 "" => "tcp"      
DEBU[0068]   security_group_id:        "" => "sg-0419cbbf5746a52fb" 
DEBU[0068]   self:                     "" => "false"    
DEBU[0068]   source_security_group_id: "" => "<computed>" 
DEBU[0068]   to_port:                  "" => "35443"    
DEBU[0068]   type:                     "" => "ingress" 
DEBU[0068] module.cloud.aws_security_group_rule.ingress_http: Creating... 
DEBU[0068]   cidr_blocks.#:            "" => "1"        
DEBU[0068]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0068]   from_port:                "" => "35080"    
DEBU[0068]   protocol:                 "" => "tcp"      
DEBU[0068]   security_group_id:        "" => "sg-0419cbbf5746a52fb" 
DEBU[0068]   self:                     "" => "false"    
DEBU[0068]   source_security_group_id: "" => "<computed>" 
DEBU[0068]   to_port:                  "" => "35080"    
DEBU[0068]   type:                     "" => "ingress" 
DEBU[0068] module.cloud.aws_subnet.pubsubnet[3]: Creation complete after 6s (ID: subnet-072454096e4a04d17) 
DEBU[0068] module.cloud.aws_subnet.pubsubnet[1]: Creation complete after 7s (ID: subnet-0c799bdeab29cf51a) 
DEBU[0068] module.cloud.aws_security_group_rule.kubernetes: Creation complete after 4s (ID: sgrule-451066732) 
DEBU[0068] module.cloud.aws_security_group_rule.allow_all_egress: Creation complete after 4s (ID: sgrule-912263351) 
DEBU[0069] module.cloud.aws_route_table.public_igw: Creation complete after 6s (ID: rtb-0e6b6d1bbfd76aaa0) 
DEBU[0069] module.cloud.aws_route.internet_access: Creating... 
DEBU[0069]   destination_cidr_block:     "" => "0.0.0.0/0" 
DEBU[0069]   destination_prefix_list_id: "" => "<computed>" 
DEBU[0069]   egress_only_gateway_id:     "" => "<computed>" 
DEBU[0069]   gateway_id:                 "" => "igw-0836abc8af6bd80fd" 
DEBU[0069]   instance_id:                "" => "<computed>" 
DEBU[0069]   instance_owner_id:          "" => "<computed>" 
DEBU[0069]   nat_gateway_id:             "" => "<computed>" 
DEBU[0069]   network_interface_id:       "" => "<computed>" 
DEBU[0069]   origin:                     "" => "<computed>" 
DEBU[0069]   route_table_id:             "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0069]   state:                      "" => "<computed>" 
DEBU[0069] module.cloud.aws_route_table_association.public[0]: Creating... 
DEBU[0069]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0069]   subnet_id:      "" => "subnet-0203d65c759718494" 
DEBU[0069] module.cloud.aws_route_table_association.public[4]: Creating... 
DEBU[0069]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0069]   subnet_id:      "" => "subnet-0fb2f91ed09ce5b53" 
DEBU[0069] module.cloud.aws_route_table_association.public[3]: Creating... 
DEBU[0069]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0069]   subnet_id:      "" => "subnet-072454096e4a04d17" 
DEBU[0069] module.cloud.aws_route_table_association.public[5]: Creating... 
DEBU[0069]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0069]   subnet_id:      "" => "subnet-06d5eb0f0add817ce" 
DEBU[0070] module.cloud.aws_route_table_association.public[3]: Creation complete after 2s (ID: rtbassoc-0d52d328b465e1b5a) 
DEBU[0070] module.cloud.aws_route_table_association.public[5]: Creation complete after 2s (ID: rtbassoc-0fa6a0e008864f054) 
DEBU[0070] module.cloud.aws_route_table_association.public[1]: Creating... 
DEBU[0070]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0070]   subnet_id:      "" => "subnet-0c799bdeab29cf51a" 
DEBU[0070] module.cloud.aws_route_table_association.public[2]: Creating... 
DEBU[0070]   route_table_id: "" => "rtb-0e6b6d1bbfd76aaa0" 
DEBU[0070]   subnet_id:      "" => "subnet-07ac9ceedb115e5cb" 
DEBU[0070] module.cloud.aws_route_table_association.public[4]: Creation complete after 2s (ID: rtbassoc-0d158ec911d005731) 
DEBU[0070] module.cloud.aws_route_table_association.public[0]: Creation complete after 2s (ID: rtbassoc-0d48234404a440984) 
DEBU[0071] module.cloud.aws_security_group.winrm: Creation complete after 9s (ID: sg-0d0e06953ac3863d4) 
DEBU[0071] module.cloud.aws_security_group_rule.winrm: Creating... 
DEBU[0071]   cidr_blocks.#:            "" => "1"        
DEBU[0071]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0071]   from_port:                "" => "5985"     
DEBU[0071]   protocol:                 "" => "tcp"      
DEBU[0071]   security_group_id:        "" => "sg-0d0e06953ac3863d4" 
DEBU[0071]   self:                     "" => "false"    
DEBU[0071]   source_security_group_id: "" => "<computed>" 
DEBU[0071]   to_port:                  "" => "5986"     
DEBU[0071]   type:                     "" => "ingress" 
DEBU[0071] module.cloud.aws_security_group.interlock: Creation complete after 9s (ID: sg-04b65cfc034b690fc) 
DEBU[0071] module.cloud.aws_security_group_rule.interlock_https: Creating... 
DEBU[0071]   cidr_blocks.#:            "" => "1"        
DEBU[0071]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0071]   from_port:                "" => "8443"     
DEBU[0071]   protocol:                 "" => "tcp"      
DEBU[0071]   security_group_id:        "" => "sg-04b65cfc034b690fc" 
DEBU[0071]   self:                     "" => "false"    
DEBU[0071]   source_security_group_id: "" => "<computed>" 
DEBU[0071]   to_port:                  "" => "8443"     
DEBU[0071]   type:                     "" => "ingress" 
DEBU[0071] module.cloud.aws_security_group_rule.interlock_http: Creating... 
DEBU[0071]   cidr_blocks.#:            "" => "1"        
DEBU[0071]   cidr_blocks.0:            "" => "0.0.0.0/0" 
DEBU[0071]   from_port:                "" => "8080"     
DEBU[0071]   protocol:                 "" => "tcp"      
DEBU[0071]   security_group_id:        "" => "sg-04b65cfc034b690fc" 
DEBU[0071]   self:                     "" => "false"    
DEBU[0071]   source_security_group_id: "" => "<computed>" 
DEBU[0071]   to_port:                  "" => "8080"     
DEBU[0071]   type:                     "" => "ingress" 
DEBU[0071] module.registry.aws_instance.linux: Creating... 
DEBU[0071]   ami:                                               "" => "ami-07b4156579ea1d7ba" 
DEBU[0071]   arn:                                               "" => "<computed>" 
DEBU[0071]   associate_public_ip_address:                       "" => "<computed>" 
DEBU[0071]   availability_zone:                                 "" => "<computed>" 
DEBU[0071]   cpu_core_count:                                    "" => "<computed>" 
DEBU[0071]   cpu_threads_per_core:                              "" => "<computed>" 
DEBU[0071]   ebs_block_device.#:                                "" => "1" 
DEBU[0071]   ebs_block_device.3905984573.delete_on_termination: "" => "true" 
DEBU[0071]   ebs_block_device.3905984573.device_name:           "" => "/dev/xvdb" 
DEBU[0071]   ebs_block_device.3905984573.encrypted:             "" => "true" 
DEBU[0071]   ebs_block_device.3905984573.snapshot_id:           "" => "<computed>" 
DEBU[0071]   ebs_block_device.3905984573.volume_id:             "" => "<computed>" 
DEBU[0071]   ebs_block_device.3905984573.volume_size:           "" => "100" 
DEBU[0071]   ebs_block_device.3905984573.volume_type:           "" => "gp2" 
DEBU[0071]   ephemeral_block_device.#:                          "" => "<computed>" 
DEBU[0071]   get_password_data:                                 "" => "false" 
DEBU[0071]   host_id:                                           "" => "<computed>" 
DEBU[0071]   iam_instance_profile:                              "" => "67fb8cb05043_worker" 
DEBU[0071]   instance_state:                                    "" => "<computed>" 
DEBU[0071]   instance_type:                                     "" => "t2.xlarge" 
DEBU[0071]   ipv6_address_count:                                "" => "<computed>" 
DEBU[0071]   ipv6_addresses.#:                                  "" => "<computed>" 
DEBU[0071]   key_name:                                          "" => "cluster_67fb8cb05043" 
DEBU[0071]   network_interface.#:                               "" => "<computed>" 
DEBU[0071]   network_interface_id:                              "" => "<computed>" 
DEBU[0071]   password_data:                                     "" => "<computed>" 
DEBU[0071]   placement_group:                                   "" => "<computed>" 
DEBU[0071]   primary_network_interface_id:                      "" => "<computed>" 
DEBU[0071]   private_dns:                                       "" => "<computed>" 
DEBU[0071]   private_ip:                                        "" => "<computed>" 
DEBU[0071]   public_dns:                                        "" => "<computed>" 
DEBU[0071]   public_ip:                                         "" => "<computed>" 
DEBU[0071]   root_block_device.#:                               "" => "1" 
DEBU[0071]   root_block_device.0.delete_on_termination:         "" => "true" 
DEBU[0071]   root_block_device.0.volume_id:                     "" => "<computed>" 
DEBU[0071]   root_block_device.0.volume_size:                   "" => "<computed>" 
DEBU[0071]   root_block_device.0.volume_type:                   "" => "<computed>" 
DEBU[0071]   security_groups.#:                                 "" => "<computed>" 
DEBU[0071]   source_dest_check:                                 "" => "true" 
DEBU[0071]   subnet_id:                                         "" => "subnet-0203d65c759718494" 
DEBU[0071]   tags.%:                                            "" => "7" 
DEBU[0071]   tags.CLUSTER_CREATED:                              "" => "2019-05-28T17:25:57Z" 
DEBU[0071]   tags.CLUSTER_ID:                                   "" => "67fb8cb05043" 
DEBU[0071]   tags.CLUSTER_NAME:                                 "" => "fervent_taussig" 
DEBU[0071]   tags.CLUSTER_VERSION:                              "" => "v0.3.0" 
DEBU[0071]   tags.Name:                                         "" => "67fb8cb05043-registry-1" 
DEBU[0071]   tags.pet:                                          "" => "true" 
DEBU[0071]   tags.project:                                      "" => "CSG-DCI" 
DEBU[0071]   tenancy:                                           "" => "<computed>" 
DEBU[0071]   user_data:                                         "" => "e68c2a421842ed7ecf74681263c5bfbadb38fef7" 
DEBU[0071]   volume_tags.%:                                     "" => "7" 
DEBU[0071]   volume_tags.CLUSTER_CREATED:                       "" => "2019-05-28T17:25:57Z" 
DEBU[0071]   volume_tags.CLUSTER_ID:                            "" => "67fb8cb05043" 
DEBU[0071]   volume_tags.CLUSTER_NAME:                          "" => "fervent_taussig" 
DEBU[0071]   volume_tags.CLUSTER_VERSION:                       "" => "v0.3.0" 
DEBU[0071]   volume_tags.Name:                                  "" => "67fb8cb05043-registry-1" 
DEBU[0071]   volume_tags.pet:                                   "" => "true" 
DEBU[0071]   volume_tags.project:                               "" => "CSG-DCI" 
DEBU[0071]   vpc_security_group_ids.#:                          "" => "5" 
DEBU[0071]   vpc_security_group_ids.2349827915:                 "" => "sg-0b8bbd0cd6e3b1d73" 
DEBU[0071]   vpc_security_group_ids.2651162361:                 "" => "sg-0419cbbf5746a52fb" 
DEBU[0071]   vpc_security_group_ids.3740002702:                 "" => "sg-04b65cfc034b690fc" 
DEBU[0071]   vpc_security_group_ids.3822871292:                 "" => "sg-0adbb2979b6921116" 
DEBU[0071]   vpc_security_group_ids.741555327:                  "" => "sg-022f2590a9fb6bad2" 
DEBU[0071] module.cloud.aws_route_table_association.public[1]: Creation complete after 1s (ID: rtbassoc-01980516984f817dc) 
DEBU[0071] module.cloud.aws_route_table_association.public[2]: Creation complete after 1s (ID: rtbassoc-03bb04db3503caee7) 
DEBU[0071] module.cloud.aws_route.internet_access: Creation complete after 3s (ID: r-rtb-0e6b6d1bbfd76aaa01080289494) 
DEBU[0071] module.managers.aws_instance.linux: Creating... 
DEBU[0071]   ami:                                               "" => "ami-07b4156579ea1d7ba" 
DEBU[0071]   arn:                                               "" => "<computed>" 
DEBU[0071]   associate_public_ip_address:                       "" => "<computed>" 
DEBU[0071]   availability_zone:                                 "" => "<computed>" 
DEBU[0071]   cpu_core_count:                                    "" => "<computed>" 
DEBU[0071]   cpu_threads_per_core:                              "" => "<computed>" 
DEBU[0071]   ebs_block_device.#:                                "" => "1" 
DEBU[0071]   ebs_block_device.3905984573.delete_on_termination: "" => "true" 
DEBU[0071]   ebs_block_device.3905984573.device_name:           "" => "/dev/xvdb" 
DEBU[0071]   ebs_block_device.3905984573.encrypted:             "" => "true" 
DEBU[0071]   ebs_block_device.3905984573.snapshot_id:           "" => "<computed>" 
DEBU[0071]   ebs_block_device.3905984573.volume_id:             "" => "<computed>" 
DEBU[0071]   ebs_block_device.3905984573.volume_size:           "" => "100" 
DEBU[0071]   ebs_block_device.3905984573.volume_type:           "" => "gp2" 
DEBU[0071]   ephemeral_block_device.#:                          "" => "<computed>" 
DEBU[0071]   get_password_data:                                 "" => "false" 
DEBU[0071]   host_id:                                           "" => "<computed>" 
DEBU[0071]   iam_instance_profile:                              "" => "67fb8cb05043_worker" 
DEBU[0071]   instance_state:                                    "" => "<computed>" 
DEBU[0071]   instance_type:                                     "" => "t2.xlarge" 
DEBU[0071]   ipv6_address_count:                                "" => "<computed>" 
DEBU[0071]   ipv6_addresses.#:                                  "" => "<computed>" 
DEBU[0071]   key_name:                                          "" => "cluster_67fb8cb05043" 
DEBU[0071]   network_interface.#:                               "" => "<computed>" 
DEBU[0071]   network_interface_id:                              "" => "<computed>" 
DEBU[0071]   password_data:                                     "" => "<computed>" 
DEBU[0071]   placement_group:                                   "" => "<computed>" 
DEBU[0071]   primary_network_interface_id:                      "" => "<computed>" 
DEBU[0071]   private_dns:                                       "" => "<computed>" 
DEBU[0071]   private_ip:                                        "" => "<computed>" 
DEBU[0071]   public_dns:                                        "" => "<computed>" 
DEBU[0071]   public_ip:                                         "" => "<computed>" 
DEBU[0071]   root_block_device.#:                               "" => "1" 
DEBU[0071]   root_block_device.0.delete_on_termination:         "" => "true" 
DEBU[0071]   root_block_device.0.volume_id:                     "" => "<computed>" 
DEBU[0071]   root_block_device.0.volume_size:                   "" => "<computed>" 
DEBU[0071]   root_block_device.0.volume_type:                   "" => "<computed>" 
DEBU[0071]   security_groups.#:                                 "" => "<computed>" 
DEBU[0071]   source_dest_check:                                 "" => "true" 
DEBU[0071]   subnet_id:                                         "" => "subnet-0203d65c759718494" 
DEBU[0071]   tags.%:                                            "" => "7" 
DEBU[0071]   tags.CLUSTER_CREATED:                              "" => "2019-05-28T17:25:57Z" 
DEBU[0071]   tags.CLUSTER_ID:                                   "" => "67fb8cb05043" 
DEBU[0071]   tags.CLUSTER_NAME:                                 "" => "fervent_taussig" 
DEBU[0071]   tags.CLUSTER_VERSION:                              "" => "v0.3.0" 
DEBU[0071]   tags.Name:                                         "" => "67fb8cb05043-managers-1" 
DEBU[0071]   tags.pet:                                          "" => "true" 
DEBU[0071]   tags.project:                                      "" => "CSG-DCI" 
DEBU[0071]   tenancy:                                           "" => "<computed>" 
DEBU[0071]   user_data:                                         "" => "e68c2a421842ed7ecf74681263c5bfbadb38fef7" 
DEBU[0071]   volume_tags.%:                                     "" => "7" 
DEBU[0071]   volume_tags.CLUSTER_CREATED:                       "" => "2019-05-28T17:25:57Z" 
DEBU[0071]   volume_tags.CLUSTER_ID:                            "" => "67fb8cb05043" 
DEBU[0071]   volume_tags.CLUSTER_NAME:                          "" => "fervent_taussig" 
DEBU[0071]   volume_tags.CLUSTER_VERSION:                       "" => "v0.3.0" 
DEBU[0071]   volume_tags.Name:                                  "" => "67fb8cb05043-managers-1" 
DEBU[0071]   volume_tags.pet:                                   "" => "true" 
DEBU[0071]   volume_tags.project:                               "" => "CSG-DCI" 
DEBU[0071]   vpc_security_group_ids.#:                          "" => "4" 
DEBU[0071]   vpc_security_group_ids.2349827915:                 "" => "sg-0b8bbd0cd6e3b1d73" 
DEBU[0071]   vpc_security_group_ids.3438611666:                 "" => "sg-017c826222c74bf16" 
DEBU[0071]   vpc_security_group_ids.3822871292:                 "" => "sg-0adbb2979b6921116" 
DEBU[0071]   vpc_security_group_ids.741555327:                  "" => "sg-022f2590a9fb6bad2" 
DEBU[0072] module.cloud.aws_security_group_rule.ingress_https: Creation complete after 4s (ID: sgrule-1163677774) 
DEBU[0072] module.cloud.aws_security_group_rule.allow_all_self: Creation complete after 8s (ID: sgrule-712642982) 
DEBU[0074] module.cloud.aws_security_group_rule.winrm: Creation complete after 4s (ID: sgrule-1354356969) 
DEBU[0074] module.cloud.aws_security_group_rule.interlock_https: Creation complete after 4s (ID: sgrule-3812138357) 
DEBU[0075] module.cloud.aws_security_group_rule.ingress_http: Creation complete after 8s (ID: sgrule-2582342666) 
DEBU[0079] module.cloud.aws_security_group_rule.interlock_http: Creation complete after 9s (ID: sgrule-291905990) 
DEBU[0081] module.registry.aws_instance.linux: Still creating... (10s elapsed) 
DEBU[0081] module.managers.aws_instance.linux: Still creating... (10s elapsed) 
DEBU[0091] module.registry.aws_instance.linux: Still creating... (20s elapsed) 
DEBU[0091] module.managers.aws_instance.linux: Still creating... (20s elapsed) 
DEBU[0101] module.registry.aws_instance.linux: Still creating... (30s elapsed) 
DEBU[0101] module.managers.aws_instance.linux: Still creating... (30s elapsed) 
DEBU[0101] module.registry.aws_instance.linux: Provisioning with 'remote-exec'... 
DEBU[0101] module.registry.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   Host: 18.208.208.51 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   Password: false 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0101] module.registry.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0102] module.managers.aws_instance.linux: Provisioning with 'remote-exec'... 
DEBU[0102] module.managers.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   Host: 35.170.33.58 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   Password: false 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0102] module.managers.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0110] module.registry.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   Host: 18.208.208.51 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   Password: false 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0110] module.registry.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0110] module.managers.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   Host: 35.170.33.58 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   Password: false 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0110] module.managers.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0111] module.registry.aws_instance.linux: Still creating... (40s elapsed) 
DEBU[0111] module.managers.aws_instance.linux: Still creating... (40s elapsed) 
DEBU[0112] module.registry.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   Host: 18.208.208.51 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   Password: false 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0112] module.registry.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0112] module.managers.aws_instance.linux (remote-exec): Connecting to remote host via SSH... 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   Host: 35.170.33.58 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   User: ubuntu 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   Password: false 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   Private key: true 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   SSH Agent: false 
DEBU[0112] module.managers.aws_instance.linux (remote-exec):   Checking Host Key: false 
DEBU[0115] module.registry.aws_instance.linux (remote-exec): Connected! 
DEBU[0115] module.managers.aws_instance.linux (remote-exec): Connected! 
DEBU[0119] module.registry.aws_instance.linux (remote-exec): waiting ... 
DEBU[0120] module.managers.aws_instance.linux (remote-exec): waiting ... 
DEBU[0121] module.registry.aws_instance.linux: Still creating... (50s elapsed) 
DEBU[0121] module.managers.aws_instance.linux: Still creating... (50s elapsed) 
DEBU[0129] module.registry.aws_instance.linux (remote-exec):   File: '/var/lib/cloud/instance/boot-finished' 
DEBU[0129] module.registry.aws_instance.linux (remote-exec):   Size: 80        	Blocks: 8          IO Block: 4096   regular file 
DEBU[0129] module.registry.aws_instance.linux (remote-exec): Device: ca01h/51713d	Inode: 256187      Links: 1 
DEBU[0129] module.registry.aws_instance.linux (remote-exec): Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root) 
DEBU[0129] module.registry.aws_instance.linux (remote-exec): Access: 2019-05-28 17:27:36.040000000 +0000 
DEBU[0129] module.registry.aws_instance.linux (remote-exec): Modify: 2019-05-28 17:27:36.040000000 +0000 
DEBU[0129] module.registry.aws_instance.linux (remote-exec): Change: 2019-05-28 17:27:36.040000000 +0000 
DEBU[0129] module.registry.aws_instance.linux (remote-exec):  Birth: - 
DEBU[0130] module.managers.aws_instance.linux (remote-exec):   File: '/var/lib/cloud/instance/boot-finished' 
DEBU[0130] module.managers.aws_instance.linux (remote-exec):   Size: 80        	Blocks: 8          IO Block: 4096   regular file 
DEBU[0130] module.managers.aws_instance.linux (remote-exec): Device: ca01h/51713d	Inode: 256187      Links: 1 
DEBU[0130] module.managers.aws_instance.linux (remote-exec): Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root) 
DEBU[0130] module.managers.aws_instance.linux (remote-exec): Access: 2019-05-28 17:27:34.740000000 +0000 
DEBU[0130] module.managers.aws_instance.linux (remote-exec): Modify: 2019-05-28 17:27:34.740000000 +0000 
DEBU[0130] module.managers.aws_instance.linux (remote-exec): Change: 2019-05-28 17:27:34.740000000 +0000 
DEBU[0130] module.managers.aws_instance.linux (remote-exec):  Birth: - 
DEBU[0130] module.registry.aws_instance.linux: Creation complete after 59s (ID: i-016770ea989a55a0a) 
DEBU[0130] module.registry.module.inventory.data.template_file.linux: Refreshing state... 
DEBU[0130] module.registry.module.inventory.local_file.linux_inventory: Creating... 
DEBU[0130]   content:  "" => "# This hosts file has been generated by terraform\n\n[linux-dtr]\n67fb8cb05043-registry-1 ansible_user=ubuntu ansible_host=18.208.208.51 ansible_ssh_private_key_file='/data/keys/ssh/id_rsa' swarm_labels='{}'\n\n\n" 
DEBU[0130]   filename: "" => "ansible/inventory/1.registry" 
DEBU[0130] module.registry.module.inventory.local_file.linux_inventory: Creation complete after 0s (ID: d66237a068fa2368e0747180ad637cd15a351b1a) 
DEBU[0131] module.managers.aws_instance.linux: Still creating... (1m0s elapsed) 
DEBU[0131] module.managers.aws_instance.linux: Creation complete after 1m0s (ID: i-088036137bdf5564a) 
DEBU[0132] module.managers.module.inventory.data.template_file.linux: Refreshing state... 
DEBU[0132] module.managers.module.inventory.local_file.linux_inventory: Creating... 
DEBU[0132]   content:  "" => "# This hosts file has been generated by terraform\n\n[linux-ucp]\n67fb8cb05043-managers-1 ansible_user=ubuntu ansible_host=35.170.33.58 ansible_ssh_private_key_file='/data/keys/ssh/id_rsa' swarm_labels='{}'\n\n\n" 
DEBU[0132]   filename: "" => "ansible/inventory/1.managers" 
DEBU[0132] module.managers.module.inventory.local_file.linux_inventory: Creation complete after 0s (ID: 6020ea071ac8d51e5be93fe2dd761cae86de889e) 
DEBU[0132]                                 
DEBU[0132] Apply complete! Resources: 47 added, 0 changed, 0 destroyed. 
DEBU[0132]                                 
DEBU[0132] Outputs:                                     
DEBU[0132]                                              
DEBU[0132] managers_ids = [                             
DEBU[0132]     i-088036137bdf5564a                      
DEBU[0132] ]                                            
DEBU[0132] managers_ips = [                             
DEBU[0132]     35.170.33.58                             
DEBU[0132] ]                                            
DEBU[0132] registry_ids = [                             
DEBU[0132]     i-016770ea989a55a0a                      
DEBU[0132] ]                                            
DEBU[0132] registry_ips = [                             
DEBU[0132]     18.208.208.51                            
DEBU[0132] ]                                        
DEBU[0132] :Begin Outputs:                              
DEBU[0132] {                                            
DEBU[0132]     "managers_ids": {                        
DEBU[0132]         "sensitive": false,                  
DEBU[0132]         "type": "list",                      
DEBU[0132]         "value": [                           
DEBU[0132]             "i-088036137bdf5564a"            
DEBU[0132]         ]                                    
DEBU[0132]     },                                       
DEBU[0132]     "managers_ips": {                        
DEBU[0132]         "sensitive": false,                  
DEBU[0132]         "type": "list",                      
DEBU[0132]         "value": [                           
DEBU[0132]             "35.170.33.58"                   
DEBU[0132]         ]                                    
DEBU[0132]     },                                       
DEBU[0132]     "registry_ids": {                        
DEBU[0132]         "sensitive": false,                  
DEBU[0132]         "type": "list",                      
DEBU[0132]         "value": [                           
DEBU[0132]             "i-016770ea989a55a0a"            
DEBU[0132]         ]                                    
DEBU[0132]     },                                       
DEBU[0132]     "registry_ips": {                        
DEBU[0132]         "sensitive": false,                  
DEBU[0132]         "type": "list",                      
DEBU[0132]         "value": [                           
DEBU[0132]             "18.208.208.51"                  
DEBU[0132]         ]                                    
DEBU[0132]     }                                        
DEBU[0132] }                                            
DEBU[0132] :End Outputs:                                
DEBU[0132] Installing Docker Enterprise Platform Requirements 
DEBU[0134]                                              
DEBU[0134] PLAY [Parsing version for Docker Trusted Registry] ***************************** 
DEBU[0134]                                              
DEBU[0134] TASK [Set default dtr repository and version] ********************************** 
DEBU[0134] ok: [localhost]                   
DEBU[0134] ok: [67fb8cb05043-managers-1]     
DEBU[0135] ok: [67fb8cb05043-registry-1]     
DEBU[0135]                                              
DEBU[0135] TASK [Is this a valid [organization]/dtr:[version] string?] ******************** 
DEBU[0135] ok: [67fb8cb05043-managers-1]     
DEBU[0135] ok: [localhost]                   
DEBU[0135] ok: [67fb8cb05043-registry-1]     
DEBU[0135]                                              
DEBU[0135] TASK [Tokenize the dtr version] ************************************************ 
DEBU[0135] ok: [localhost]                   
DEBU[0135] ok: [67fb8cb05043-managers-1]     
DEBU[0135] ok: [67fb8cb05043-registry-1]     
DEBU[0135]                                              
DEBU[0135] TASK [Convert dtr_version to a list] ******************************************* 
DEBU[0135] ok: [67fb8cb05043-managers-1]     
DEBU[0135] ok: [localhost]                   
DEBU[0135] ok: [67fb8cb05043-registry-1]     
DEBU[0135]                                              
DEBU[0135] TASK [Determine the organization] ********************************************** 
DEBU[0135] ok: [localhost]                   
DEBU[0135] ok: [67fb8cb05043-managers-1]     
DEBU[0136] ok: [67fb8cb05043-registry-1]     
DEBU[0136]                                              
DEBU[0136] TASK [Determine the version] *************************************************** 
DEBU[0136] ok: [67fb8cb05043-registry-1]     
DEBU[0136] ok: [localhost]                   
DEBU[0136] ok: [67fb8cb05043-managers-1]     
DEBU[0136]                                              
DEBU[0136] TASK [Login to a registry if the images are not public] ************************ 
DEBU[0136] skipping: [67fb8cb05043-managers-1] 
DEBU[0136] skipping: [67fb8cb05043-registry-1] 
DEBU[0136] skipping: [localhost]             
DEBU[0136]                                              
DEBU[0136] PLAY [Validating version for Docker Trusted Registry] ************************** 
DEBU[0136]                                              
DEBU[0136] TASK [Gathering Facts] ********************************************************* 
DEBU[0137] ok: [localhost]                   
DEBU[0137]                                              
DEBU[0137] TASK [validate-dtr : set_fact] ************************************************* 
DEBU[0137] ok: [localhost]                   
DEBU[0137]                                              
DEBU[0137] TASK [validate-dtr : assert] *************************************************** 
DEBU[0137] ok: [localhost] => changed=false  
DEBU[0137]   msg: All assertions passed      
DEBU[0137]                                              
DEBU[0137] PLAY [Parsing version for Docker Universal Control Plane (UCP)] **************** 
DEBU[0137]                                              
DEBU[0137] TASK [Set default ucp repository and version] ********************************** 
DEBU[0137] ok: [67fb8cb05043-managers-1]     
DEBU[0137] ok: [localhost]                   
DEBU[0137] ok: [67fb8cb05043-registry-1]     
DEBU[0137]                                              
DEBU[0137] TASK [Is this a valid [organization]/ucp:[version] string?] ******************** 
DEBU[0137] ok: [localhost]                   
DEBU[0137] ok: [67fb8cb05043-managers-1]     
DEBU[0137] ok: [67fb8cb05043-registry-1]     
DEBU[0137]                                              
DEBU[0137] TASK [Tokenize the ucp version] ************************************************ 
DEBU[0138] ok: [localhost]                   
DEBU[0138] ok: [67fb8cb05043-managers-1]     
DEBU[0138] ok: [67fb8cb05043-registry-1]     
DEBU[0138]                                              
DEBU[0138] TASK [Convert ucp_version to a list] ******************************************* 
DEBU[0138] ok: [localhost]                   
DEBU[0138] ok: [67fb8cb05043-managers-1]     
DEBU[0138] ok: [67fb8cb05043-registry-1]     
DEBU[0138]                                              
DEBU[0138] TASK [Determine the organization] ********************************************** 
DEBU[0138] ok: [localhost]                   
DEBU[0138] ok: [67fb8cb05043-managers-1]     
DEBU[0138] ok: [67fb8cb05043-registry-1]     
DEBU[0138]                                              
DEBU[0138] TASK [Determine the version] *************************************************** 
DEBU[0138] ok: [localhost]                   
DEBU[0139] ok: [67fb8cb05043-managers-1]     
DEBU[0139] ok: [67fb8cb05043-registry-1]     
DEBU[0139]                                              
DEBU[0139] TASK [Login to a registry if the images are not public] ************************ 
DEBU[0139] skipping: [67fb8cb05043-managers-1] 
DEBU[0139] skipping: [67fb8cb05043-registry-1] 
DEBU[0139] skipping: [localhost]             
DEBU[0139]                                              
DEBU[0139] PLAY [Validating version for Docker Universal Control Plane (UCP)] ************* 
DEBU[0139]                                              
DEBU[0139] TASK [Gathering Facts] ********************************************************* 
DEBU[0139] ok: [localhost]                   
DEBU[0139]                                              
DEBU[0139] TASK [validate-ucp : set_fact] ************************************************* 
DEBU[0139] ok: [localhost]                   
DEBU[0139]                                              
DEBU[0139] TASK [validate-ucp : assert] *************************************************** 
DEBU[0140] ok: [localhost] => changed=false  
DEBU[0140]   msg: All assertions passed      
DEBU[0140]                                              
DEBU[0140] TASK [validate-ucp : assert] *************************************************** 
DEBU[0140] ok: [localhost] => changed=false  
DEBU[0140]   msg: All assertions passed      
DEBU[0140]                                              
DEBU[0140] TASK [validate-ucp : assert] *************************************************** 
DEBU[0140] ok: [localhost] => changed=false  
DEBU[0140]   msg: All assertions passed      
DEBU[0140]                                              
DEBU[0140] PLAY [Parsing engine version] ************************************************** 
DEBU[0140]                                              
DEBU[0140] TASK [Set default product.channel.version] ************************************* 
DEBU[0140] ok: [67fb8cb05043-managers-1]     
DEBU[0140] ok: [localhost]                   
DEBU[0140] ok: [67fb8cb05043-registry-1]     
DEBU[0140]                                              
DEBU[0140] TASK [Is this a valid product-channel-version string?] ************************* 
DEBU[0140] ok: [localhost]                   
DEBU[0140] ok: [67fb8cb05043-managers-1]     
DEBU[0140] ok: [67fb8cb05043-registry-1]     
DEBU[0140]                                              
DEBU[0140] TASK [Extract product.channel.version ee-test-19.03] *************************** 
DEBU[0140] skipping: [67fb8cb05043-managers-1] 
DEBU[0140] skipping: [67fb8cb05043-registry-1] 
DEBU[0140] skipping: [localhost]             
DEBU[0140]                                              
DEBU[0140] TASK [Tokenize the engine version] ********************************************* 
DEBU[0141] ok: [localhost]                   
DEBU[0141] ok: [67fb8cb05043-managers-1]     
DEBU[0141] ok: [67fb8cb05043-registry-1]     
DEBU[0141]                                              
DEBU[0141] TASK [Convert the engine version to a list] ************************************ 
DEBU[0141] ok: [67fb8cb05043-managers-1]     
DEBU[0141] ok: [localhost]                   
DEBU[0141] ok: [67fb8cb05043-registry-1]     
DEBU[0141]                                              
DEBU[0141] TASK [Determine the production edition] **************************************** 
DEBU[0141] ok: [67fb8cb05043-managers-1]     
DEBU[0141] ok: [localhost]                   
DEBU[0141] ok: [67fb8cb05043-registry-1]     
DEBU[0141]                                              
DEBU[0141] TASK [Prefer channel with XX.YY for enterprise] ******************************** 
DEBU[0141] ok: [67fb8cb05043-managers-1]     
DEBU[0141] ok: [localhost]                   
DEBU[0141] ok: [67fb8cb05043-registry-1]     
DEBU[0141]                                              
DEBU[0141] TASK [Prefer name only channel for community] ********************************** 
DEBU[0141] skipping: [67fb8cb05043-managers-1] 
DEBU[0141] skipping: [67fb8cb05043-registry-1] 
DEBU[0142] skipping: [localhost]             
DEBU[0142]                                              
DEBU[0142] TASK [Set the version to install] ********************************************** 
DEBU[0142] ok: [67fb8cb05043-managers-1]     
DEBU[0142] ok: [localhost]                   
DEBU[0142] ok: [67fb8cb05043-registry-1]     
DEBU[0142]                                              
DEBU[0142] TASK [set_fact] **************************************************************** 
DEBU[0142] ok: [localhost]                   
DEBU[0142] ok: [67fb8cb05043-managers-1]     
DEBU[0142] ok: [67fb8cb05043-registry-1]     
DEBU[0142]                                              
DEBU[0142] TASK [set_fact] **************************************************************** 
DEBU[0142] skipping: [67fb8cb05043-managers-1] 
DEBU[0142] skipping: [67fb8cb05043-registry-1] 
DEBU[0142] skipping: [localhost]             
DEBU[0142]                                              
DEBU[0142] PLAY [Install Ansible requirements (Python)] *********************************** 
DEBU[0142]  [WARNING]: Using any_errors_fatal with the free strategy is not supported, as 
DEBU[0142] tasks are executed independently on each host 
DEBU[0142]                                   
DEBU[0147]                                              
DEBU[0147] TASK [ansible-requirements : Check if python and pip are present] ************** 
DEBU[0147] changed: [67fb8cb05043-registry-1] 
DEBU[0147] changed: [67fb8cb05043-managers-1] 
DEBU[0148]                                              
DEBU[0148] TASK [ansible-requirements : Check if apt-get is installed.] ******************* 
DEBU[0148] changed: [67fb8cb05043-registry-1] 
DEBU[0148] changed: [67fb8cb05043-managers-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Install python2 [apt-get].] *********************** 
DEBU[0175] changed: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Check if dnf is installed.] *********************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Clean dnf] **************************************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Install python-pip [dnf].] ************************ 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Check if yum is installed.] *********************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Azure updates for RHUI] *************************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Clean yum] **************************************** 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0175]                                              
DEBU[0175] TASK [ansible-requirements : Install yum-utils.] ******************************* 
DEBU[0175] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install epel-release.] **************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Enable developer EPEL (pip).] ********************* 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install python2 [yum].] *************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install python2 [apt-get].] *********************** 
DEBU[0176] changed: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Check if dnf is installed.] *********************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Check if zypper is installed.] ******************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Clean dnf] **************************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Installing python] ******************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install python-pip [dnf].] ************************ 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Installing python-xml] **************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Check if yum is installed.] *********************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Upgrade pip setuptools] *************************** 
DEBU[0176] skipping: [67fb8cb05043-registry-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Azure updates for RHUI] *************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Clean yum] **************************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install yum-utils.] ******************************* 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install epel-release.] **************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Enable developer EPEL (pip).] ********************* 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Install python2 [yum].] *************************** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0176]                                              
DEBU[0176] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0176] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Check if zypper is installed.] ******************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Installing python] ******************************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Installing python-xml] **************************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Ensure pip has been installed properly.] ********** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Install pip manually] ***************************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] TASK [ansible-requirements : Upgrade pip setuptools] *************************** 
DEBU[0177] skipping: [67fb8cb05043-managers-1] 
DEBU[0177]                                              
DEBU[0177] PLAY [Make sure windows hosts can be contacted] ******************************** 
DEBU[0177] skipping: no hosts matched        
DEBU[0177]                                              
DEBU[0177] PLAY [Add DCI to Support Dump information] ************************************* 
DEBU[0177]                                              
DEBU[0177] TASK [Gathering Facts] ********************************************************* 
DEBU[0183] ok: [67fb8cb05043-managers-1]     
DEBU[0184] ok: [67fb8cb05043-registry-1]     
DEBU[0184]                                              
DEBU[0184] TASK [dsinfo : Get stack version.] ********************************************* 
DEBU[0185] changed: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0185] changed: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0185]                                              
DEBU[0185] TASK [dsinfo : Get stack revision.] ******************************************** 
DEBU[0185] changed: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0185] changed: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0185]                                              
DEBU[0185] TASK [dsinfo : set_fact] ******************************************************* 
DEBU[0185] ok: [67fb8cb05043-managers-1]     
DEBU[0185] ok: [67fb8cb05043-registry-1]     
DEBU[0185]                                              
DEBU[0185] TASK [dsinfo : Create the DCI deployment info file.] *************************** 
DEBU[0197] changed: [67fb8cb05043-registry-1] 
DEBU[0197] changed: [67fb8cb05043-managers-1] 
DEBU[0197]                                              
DEBU[0197] TASK [dsinfo : Ensure that C:\ProgramData\docker directory is present] ********* 
DEBU[0197] skipping: [67fb8cb05043-managers-1] 
DEBU[0197] skipping: [67fb8cb05043-registry-1] 
DEBU[0197]                                              
DEBU[0197] TASK [dsinfo : Create the DCI deployment info file.] *************************** 
DEBU[0197] skipping: [67fb8cb05043-managers-1] 
DEBU[0197] skipping: [67fb8cb05043-registry-1] 
DEBU[0197]                                              
DEBU[0197] PLAY [Discovering engine architecture] ***************************************** 
DEBU[0197]                                              
DEBU[0197] TASK [Gathering Facts] ********************************************************* 
DEBU[0198] ok: [localhost]                   
DEBU[0203] ok: [67fb8cb05043-registry-1]     
DEBU[0203] ok: [67fb8cb05043-managers-1]     
DEBU[0203]                                              
DEBU[0203] TASK [set_fact] **************************************************************** 
DEBU[0203] ok: [localhost]                   
DEBU[0203] ok: [67fb8cb05043-managers-1]     
DEBU[0203] ok: [67fb8cb05043-registry-1]     
DEBU[0203]                                              
DEBU[0203] TASK [set_fact] **************************************************************** 
DEBU[0203] skipping: [67fb8cb05043-managers-1] 
DEBU[0203] skipping: [67fb8cb05043-registry-1] 
DEBU[0203] skipping: [localhost]             
DEBU[0203]                                              
DEBU[0203] TASK [set_fact] **************************************************************** 
DEBU[0203] skipping: [localhost]             
DEBU[0203] ok: [67fb8cb05043-managers-1]     
DEBU[0203] ok: [67fb8cb05043-registry-1]     
DEBU[0203]  [WARNING]: Could not match supplied host pattern, ignoring: load-balancers 
DEBU[0203]                                   
DEBU[0203]                                              
DEBU[0203] PLAY [Checking if FIPS is enabled] ********************************************* 
DEBU[0203]                                              
DEBU[0203] TASK [docker-fips : Installation (Debian).] ************************************ 
DEBU[0204] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0204] skipping: [67fb8cb05043-managers-1] => (item=Windows)  
DEBU[0204] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0204] skipping: [67fb8cb05043-registry-1] => (item=Windows)  
DEBU[0204]                                              
DEBU[0204] PLAY [Collecting Docker subscription information] ****************************** 
DEBU[0204]                                              
DEBU[0204] TASK [diver-store : Login to Docker Store] ************************************* 
DEBU[0207] changed: [localhost]              
DEBU[0207]                                              
DEBU[0207] TASK [diver-store : Lookup Subscriptions Information] ************************** 
DEBU[0208] included: /cluster/ansible/roles/diver-store/tasks/lookup/main.yml for localhost => (item=ubuntu) 
DEBU[0208] included: /cluster/ansible/roles/diver-store/tasks/lookup/main.yml for localhost => (item=centos) 
DEBU[0208] included: /cluster/ansible/roles/diver-store/tasks/lookup/main.yml for localhost => (item=oracle) 
DEBU[0208] included: /cluster/ansible/roles/diver-store/tasks/lookup/main.yml for localhost => (item=rhel) 
DEBU[0208] included: /cluster/ansible/roles/diver-store/tasks/lookup/main.yml for localhost => (item=sles) 
DEBU[0208]                                              
DEBU[0208] TASK [diver-store : Querying Subscription ID for ubuntu] *********************** 
DEBU[0212] changed: [localhost]              
DEBU[0212]                                              
DEBU[0212] TASK [diver-store : Storing information] *************************************** 
DEBU[0212] skipping: [localhost]             
DEBU[0212]                                              
DEBU[0212] TASK [diver-store : Fetching License File for ubuntu] ************************** 
DEBU[0212] skipping: [localhost]             
DEBU[0212]                                              
DEBU[0212] TASK [diver-store : Writing License File for ubuntu] *************************** 
DEBU[0212] skipping: [localhost]             
DEBU[0212]                                              
DEBU[0212] TASK [diver-store : Querying Subscription ID for centos] *********************** 
DEBU[0215] changed: [localhost]              
DEBU[0215]                                              
DEBU[0215] TASK [diver-store : Storing information] *************************************** 
DEBU[0215] skipping: [localhost]             
DEBU[0215]                                              
DEBU[0215] TASK [diver-store : Fetching License File for centos] ************************** 
DEBU[0215] skipping: [localhost]             
DEBU[0215]                                              
DEBU[0215] TASK [diver-store : Writing License File for centos] *************************** 
DEBU[0215] skipping: [localhost]             
DEBU[0215]                                              
DEBU[0215] TASK [diver-store : Querying Subscription ID for oracle] *********************** 
DEBU[0218] changed: [localhost]              
DEBU[0218]                                              
DEBU[0218] TASK [diver-store : Storing information] *************************************** 
DEBU[0218] skipping: [localhost]             
DEBU[0218]                                              
DEBU[0218] TASK [diver-store : Fetching License File for oracle] ************************** 
DEBU[0218] skipping: [localhost]             
DEBU[0218]                                              
DEBU[0218] TASK [diver-store : Writing License File for oracle] *************************** 
DEBU[0218] skipping: [localhost]             
DEBU[0218]                                              
DEBU[0218] TASK [diver-store : Querying Subscription ID for rhel] ************************* 
DEBU[0222] changed: [localhost]              
DEBU[0222]                                              
DEBU[0222] TASK [diver-store : Storing information] *************************************** 
DEBU[0222] skipping: [localhost]             
DEBU[0222]                                              
DEBU[0222] TASK [diver-store : Fetching License File for rhel] **************************** 
DEBU[0222] skipping: [localhost]             
DEBU[0222]                                              
DEBU[0222] TASK [diver-store : Writing License File for rhel] ***************************** 
DEBU[0222] skipping: [localhost]             
DEBU[0222]                                              
DEBU[0222] TASK [diver-store : Querying Subscription ID for sles] ************************* 
DEBU[0225] changed: [localhost]              
DEBU[0225]                                              
DEBU[0225] TASK [diver-store : Storing information] *************************************** 
DEBU[0225] skipping: [localhost]             
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Fetching License File for sles] **************************** 
DEBU[0226] skipping: [localhost]             
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Writing License File for sles] ***************************** 
DEBU[0226] skipping: [localhost]             
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Assign Subscriptions.] ************************************* 
DEBU[0226] skipping: [localhost]             
DEBU[0226]                                              
DEBU[0226] PLAY [Setting Docker subscription information] ********************************* 
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Login to Docker Store] ************************************* 
DEBU[0226] skipping: [67fb8cb05043-managers-1] 
DEBU[0226] skipping: [67fb8cb05043-registry-1] 
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Lookup Subscriptions Information] ************************** 
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=ubuntu)  
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=centos)  
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=oracle)  
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=rhel)  
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=sles)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=ubuntu)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=centos)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=oracle)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=rhel)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=sles)  
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Assign Subscriptions.] ************************************* 
DEBU[0226] included: /cluster/ansible/roles/diver-store/tasks/assign/main.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0226]                                              
DEBU[0226] TASK [diver-store : Installation (Debian).] ************************************ 
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0226] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0226] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0227] included: /cluster/ansible/roles/diver-store/tasks/assign/Debian.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0227]                                              
DEBU[0227] TASK [diver-store : include_tasks] ********************************************* 
DEBU[0227] included: /cluster/ansible/roles/diver-store/tasks/assign/Debian/Ubuntu.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0227]                                              
DEBU[0227] TASK [diver-store : set_fact] ************************************************** 
DEBU[0227] skipping: [67fb8cb05043-managers-1] 
DEBU[0227] skipping: [67fb8cb05043-registry-1] 
DEBU[0227]                                              
DEBU[0227] PLAY [Formatting storage] ****************************************************** 
DEBU[0227]                                              
DEBU[0227] TASK [docker-storage : (AWS Only) Discover device name for NVMe EBS disks] ***** 
DEBU[0227] included: /cluster/ansible/roles/docker-storage/tasks/aws.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0227]                                              
DEBU[0227] TASK [docker-storage : Is /dev/xvdb a block device?] *************************** 
DEBU[0229] ok: [67fb8cb05043-managers-1]     
DEBU[0229] ok: [67fb8cb05043-registry-1]     
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : Scan NVMe devices] ************************************** 
DEBU[0230] skipping: [67fb8cb05043-managers-1] 
DEBU[0230] skipping: [67fb8cb05043-registry-1] 
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : Installation ( Debian ).] ******************************* 
DEBU[0230] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0230] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0230] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0230] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0230] included: /cluster/ansible/roles/docker-storage/tasks/Debian.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : shell] ************************************************** 
DEBU[0230] skipping: [67fb8cb05043-managers-1] 
DEBU[0230] skipping: [67fb8cb05043-registry-1] 
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : Install linux-image-extra-{{ uname_out.stdout }}.] ****** 
DEBU[0230] skipping: [67fb8cb05043-managers-1] 
DEBU[0230] skipping: [67fb8cb05043-registry-1] 
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : Install linux-image-extra-virtual.] ********************* 
DEBU[0230] skipping: [67fb8cb05043-managers-1] 
DEBU[0230] skipping: [67fb8cb05043-registry-1] 
DEBU[0230]                                              
DEBU[0230] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0230] skipping: [67fb8cb05043-managers-1] 
DEBU[0230] skipping: [67fb8cb05043-registry-1] 
DEBU[0231]                                              
DEBU[0231] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0231] ok: [67fb8cb05043-managers-1]     
DEBU[0231] ok: [67fb8cb05043-registry-1]     
DEBU[0231]                                              
DEBU[0231] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0231] ok: [67fb8cb05043-managers-1]     
DEBU[0231] ok: [67fb8cb05043-registry-1]     
DEBU[0231]                                              
DEBU[0231] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0231] skipping: [67fb8cb05043-managers-1] 
DEBU[0231] skipping: [67fb8cb05043-registry-1] 
DEBU[0231]                                              
DEBU[0231] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0231] skipping: [67fb8cb05043-managers-1] 
DEBU[0231] skipping: [67fb8cb05043-registry-1] 
DEBU[0231]                                              
DEBU[0231] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0231] ok: [67fb8cb05043-managers-1]     
DEBU[0232] ok: [67fb8cb05043-registry-1]     
DEBU[0232]                                              
DEBU[0232] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0232] ok: [67fb8cb05043-managers-1]     
DEBU[0232] ok: [67fb8cb05043-registry-1]     
DEBU[0232]                                              
DEBU[0232] TASK [docker-storage : mkfs opts] ********************************************** 
DEBU[0232] skipping: [67fb8cb05043-managers-1] 
DEBU[0232] skipping: [67fb8cb05043-registry-1] 
DEBU[0232]                                              
DEBU[0232] TASK [docker-storage : Partition /dev/xvdb] ************************************ 
DEBU[0234] changed: [67fb8cb05043-managers-1] 
DEBU[0235] changed: [67fb8cb05043-registry-1] 
DEBU[0235]                                              
DEBU[0235] TASK [docker-storage : mkfs.ext4] ********************************************** 
DEBU[0238] changed: [67fb8cb05043-registry-1] 
DEBU[0240] changed: [67fb8cb05043-managers-1] 
DEBU[0240]                                              
DEBU[0240] TASK [docker-storage : Mount /var/lib/docker] ********************************** 
DEBU[0243] changed: [67fb8cb05043-managers-1] 
DEBU[0243] changed: [67fb8cb05043-registry-1] 
DEBU[0243]                                              
DEBU[0243] TASK [docker-storage : set_fact] *********************************************** 
DEBU[0244] ok: [67fb8cb05043-managers-1]     
DEBU[0244] ok: [67fb8cb05043-registry-1]     
DEBU[0244]                                              
DEBU[0244] TASK [docker-storage : Add storage-driver=overlay2 to engine_daemon_options.] *** 
DEBU[0244] ok: [67fb8cb05043-managers-1]     
DEBU[0244] ok: [67fb8cb05043-registry-1]     
DEBU[0244]  [WARNING]: Could not match supplied host pattern, ignoring: domain-controllers 
DEBU[0244]                                   
DEBU[0244]                                              
DEBU[0244] PLAY [Start Domain Controller] ************************************************* 
DEBU[0244] skipping: no hosts matched        
DEBU[0244]                                              
DEBU[0244] PLAY [Join Domain Controller] ************************************************** 
DEBU[0244] skipping: no hosts matched        
DEBU[0244]                                              
DEBU[0244] PLAY [Installing Docker Enterprise Engine] ************************************* 
DEBU[0244] included: /cluster/ansible/roles/docker-ee/tasks/install/main.yml for 67fb8cb05043-managers-1 
DEBU[0244] included: /cluster/ansible/roles/docker-ee/tasks/install/main.yml for 67fb8cb05043-registry-1 
DEBU[0244]                                              
DEBU[0244] TASK [docker-ee : Installation (Debian).] ************************************** 
DEBU[0244] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0244] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0244] skipping: [67fb8cb05043-managers-1] => (item=Windows)  
DEBU[0244] included: /cluster/ansible/roles/docker-ee/tasks/install/Debian.yml for 67fb8cb05043-managers-1 
DEBU[0245]                                              
DEBU[0245] TASK [docker-ee : Installation (Debian).] ************************************** 
DEBU[0245] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0245] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0245] skipping: [67fb8cb05043-registry-1] => (item=Windows)  
DEBU[0245] included: /cluster/ansible/roles/docker-ee/tasks/install/Debian.yml for 67fb8cb05043-registry-1 
DEBU[0245] included: /cluster/ansible/roles/docker-ee/tasks/install/.unix.pre.yml for 67fb8cb05043-managers-1 
DEBU[0245] included: /cluster/ansible/roles/docker-ee/tasks/install/.unix.pre.yml for 67fb8cb05043-registry-1 
DEBU[0250]                                              
DEBU[0250] TASK [docker-ee : Ensure old versions of Docker are not installed.] ************ 
DEBU[0250] ok: [67fb8cb05043-managers-1]     
DEBU[0250]                                              
DEBU[0250] TASK [docker-ee : Ensure old versions of Docker are not installed.] ************ 
DEBU[0250] ok: [67fb8cb05043-registry-1]     
DEBU[0250] included: /cluster/ansible/roles/docker-ee/tasks/install/Debian/Ubuntu.yml for 67fb8cb05043-managers-1 
DEBU[0250] included: /cluster/ansible/roles/docker-ee/tasks/install/Debian/Ubuntu.yml for 67fb8cb05043-registry-1 
DEBU[0250]                                              
DEBU[0250] TASK [docker-ee : include_tasks] *********************************************** 
DEBU[0250] skipping: [67fb8cb05043-managers-1] => (item=14.04)  
DEBU[0250] skipping: [67fb8cb05043-managers-1] => (item=18.04)  
DEBU[0251]                                              
DEBU[0251] TASK [docker-ee : include_tasks] *********************************************** 
DEBU[0251] skipping: [67fb8cb05043-registry-1] => (item=14.04)  
DEBU[0251] skipping: [67fb8cb05043-registry-1] => (item=18.04)  
DEBU[0251]                                              
DEBU[0251] TASK [docker-ee : Determine NTP package] *************************************** 
DEBU[0251] ok: [67fb8cb05043-managers-1]     
DEBU[0251]                                              
DEBU[0251] TASK [docker-ee : Determine NTP package] *************************************** 
DEBU[0251] ok: [67fb8cb05043-registry-1]     
DEBU[0260]                                              
DEBU[0260] TASK [docker-ee : Install dependencies.] *************************************** 
DEBU[0260] changed: [67fb8cb05043-registry-1] 
DEBU[0261]                                              
DEBU[0261] TASK [docker-ee : Install dependencies.] *************************************** 
DEBU[0261] changed: [67fb8cb05043-managers-1] 
DEBU[0262]                                              
DEBU[0262] TASK [docker-ee : Configure chrony on AWS] ************************************* 
DEBU[0262] changed: [67fb8cb05043-registry-1] 
DEBU[0263]                                              
DEBU[0263] TASK [docker-ee : Configure chrony on AWS] ************************************* 
DEBU[0263] changed: [67fb8cb05043-managers-1] 
DEBU[0264]                                              
DEBU[0264] TASK [docker-ee : Remove existing pool config on AWS] ************************** 
DEBU[0264] changed: [67fb8cb05043-registry-1] 
DEBU[0264]                                              
DEBU[0264] TASK [docker-ee : Remove existing pool config on AWS] ************************** 
DEBU[0264] changed: [67fb8cb05043-managers-1] 
DEBU[0267]                                              
DEBU[0267] TASK [docker-ee : Enable chrony service on AWS] ******************************** 
DEBU[0267] changed: [67fb8cb05043-registry-1] 
DEBU[0268]                                              
DEBU[0268] TASK [docker-ee : Enable chrony service on AWS] ******************************** 
DEBU[0268] changed: [67fb8cb05043-managers-1] 
DEBU[0269]                                              
DEBU[0269] TASK [docker-ee : Check for ufw] *********************************************** 
DEBU[0269] changed: [67fb8cb05043-registry-1] 
DEBU[0269]                                              
DEBU[0269] TASK [docker-ee : Setting facts based on ufw status] *************************** 
DEBU[0269] ok: [67fb8cb05043-registry-1]     
DEBU[0269]                                              
DEBU[0269] TASK [docker-ee : ufw] ********************************************************* 
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for SSH', 'port': 22, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the UCP web UI and API', 'port': 80, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for BGP', 'port': 179, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the UCP web UI and API', 'port': 443, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the Docker Swarm manager. Used for backwards compatibility', 'port': 2376, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for communication between swarm nodes', 'port': 2377, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for overlay networking (udp)', 'port': 4789, 'protocol': 'udp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for overlay networking (tcp)', 'port': 4789, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for KubeAPIServer', 'port': 6443, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for KubeReverseProxy', 'port': 6444, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for gossip-based clustering (tcp)', 'port': 7946, 'protocol': 'tcp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for gossip-based clustering (udp)', 'port': 7946, 'protocol': 'udp'})  
DEBU[0269] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for kubelet', 'port': 10250, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for a TLS proxy that provides access to UCP, Docker Engine, and Docker Swarm', 'port': 12376, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for EtcdReverseProxy', 'port': 12378, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for internal node configuration, cluster configuration, and HA', 'port': 12379, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for internal node configuration, cluster configuration, and HA', 'port': 12380, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the certificate authority', 'port': 12381, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the UCP certificate authority', 'port': 12382, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the authentication storage backend', 'port': 12383, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the authentication storage backend for replication across managers', 'port': 12384, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the authentication service API', 'port': 12385, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the authentication worker', 'port': 12386, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'port for the metrics service', 'port': 12387, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'Port for the Kubernetes API Server', 'port': 12388, 'protocol': 'tcp'})  
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : Check for ufw] *********************************************** 
DEBU[0270] changed: [67fb8cb05043-managers-1] 
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : ufw] ********************************************************* 
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': '111/tcp in ufw', 'port': 111, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': '111/udp in ufw', 'port': 111, 'protocol': 'udp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': '2049/tcp in ufw', 'port': 2049, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': '2049/udp in ufw', 'port': 2049, 'protocol': 'udp'})  
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : Allow other IP protocols in ufw.] **************************** 
DEBU[0270] skipping: [67fb8cb05043-registry-1] => (item={'name': 'Encapsulating Security Payload (ESP) protocol', 'proto': 'esp'})  
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : Setting facts based on ufw status] *************************** 
DEBU[0270] ok: [67fb8cb05043-managers-1]     
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : Reload ufw] ************************************************** 
DEBU[0270] skipping: [67fb8cb05043-registry-1] 
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : ufw] ********************************************************* 
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for SSH', 'port': 22, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the UCP web UI and API', 'port': 80, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for BGP', 'port': 179, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the UCP web UI and API', 'port': 443, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the Docker Swarm manager. Used for backwards compatibility', 'port': 2376, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for communication between swarm nodes', 'port': 2377, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for overlay networking (udp)', 'port': 4789, 'protocol': 'udp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for overlay networking (tcp)', 'port': 4789, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for KubeAPIServer', 'port': 6443, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for KubeReverseProxy', 'port': 6444, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for gossip-based clustering (tcp)', 'port': 7946, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for gossip-based clustering (udp)', 'port': 7946, 'protocol': 'udp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for kubelet', 'port': 10250, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for a TLS proxy that provides access to UCP, Docker Engine, and Docker Swarm', 'port': 12376, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for EtcdReverseProxy', 'port': 12378, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for internal node configuration, cluster configuration, and HA', 'port': 12379, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for internal node configuration, cluster configuration, and HA', 'port': 12380, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the certificate authority', 'port': 12381, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the UCP certificate authority', 'port': 12382, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the authentication storage backend', 'port': 12383, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the authentication storage backend for replication across managers', 'port': 12384, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the authentication service API', 'port': 12385, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the authentication worker', 'port': 12386, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'port for the metrics service', 'port': 12387, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'Port for the Kubernetes API Server', 'port': 12388, 'protocol': 'tcp'})  
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : set_fact] **************************************************** 
DEBU[0270] ok: [67fb8cb05043-registry-1]     
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : ufw] ********************************************************* 
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': '111/tcp in ufw', 'port': 111, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': '111/udp in ufw', 'port': 111, 'protocol': 'udp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': '2049/tcp in ufw', 'port': 2049, 'protocol': 'tcp'})  
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': '2049/udp in ufw', 'port': 2049, 'protocol': 'udp'})  
DEBU[0270]                                              
DEBU[0270] TASK [docker-ee : Allow other IP protocols in ufw.] **************************** 
DEBU[0270] skipping: [67fb8cb05043-managers-1] => (item={'name': 'Encapsulating Security Payload (ESP) protocol', 'proto': 'esp'})  
DEBU[0271]                                              
DEBU[0271] TASK [docker-ee : Reload ufw] ************************************************** 
DEBU[0271] skipping: [67fb8cb05043-managers-1] 
DEBU[0271]                                              
DEBU[0271] TASK [docker-ee : set_fact] **************************************************** 
DEBU[0271] ok: [67fb8cb05043-managers-1]     
DEBU[0276]                                              
DEBU[0276] TASK [docker-ee : Add GPG key.] ************************************************ 
DEBU[0276]  [WARNING]: Module remote_tmp /root/.ansible/tmp did not exist and was created 
DEBU[0276] with a mode of 0700, this may cause issues when running as another user. To 
DEBU[0276] avoid this, create the remote_tmp dir with the correct permissions manually 
DEBU[0276]                                   
DEBU[0276] changed: [67fb8cb05043-registry-1] 
DEBU[0276]                                              
DEBU[0276] TASK [docker-ee : Ensure curl is present (on older systems without SNI).] ****** 
DEBU[0276] skipping: [67fb8cb05043-registry-1] 
DEBU[0276]                                              
DEBU[0276] TASK [docker-ee : Add Docker apt key (SNI).] *********************************** 
DEBU[0276] skipping: [67fb8cb05043-registry-1] 
DEBU[0276]                                              
DEBU[0276] TASK [docker-ee : Add GPG key.] ************************************************ 
DEBU[0276] changed: [67fb8cb05043-managers-1] 
DEBU[0276]                                              
DEBU[0276] TASK [docker-ee : Ensure curl is present (on older systems without SNI).] ****** 
DEBU[0276] skipping: [67fb8cb05043-managers-1] 
DEBU[0277]                                              
DEBU[0277] TASK [docker-ee : Add Docker apt key (SNI).] *********************************** 
DEBU[0277] skipping: [67fb8cb05043-managers-1] 
DEBU[0282]                                              
DEBU[0282] TASK [docker-ee : Add docker EE repository (test-19.03).] ********************** 
DEBU[0282] changed: [67fb8cb05043-registry-1] 
DEBU[0282]                                              
DEBU[0282] TASK [docker-ee : Translate the version to the package specific version] ******* 
DEBU[0282] ok: [67fb8cb05043-registry-1]     
DEBU[0283]                                              
DEBU[0283] TASK [docker-ee : Add docker EE repository (test-19.03).] ********************** 
DEBU[0283] changed: [67fb8cb05043-managers-1] 
DEBU[0283]                                              
DEBU[0283] TASK [docker-ee : Search the apt-cache for the package] ************************ 
DEBU[0283] changed: [67fb8cb05043-registry-1] 
DEBU[0283]                                              
DEBU[0283] TASK [docker-ee : Translate the version to the package specific version] ******* 
DEBU[0283] ok: [67fb8cb05043-managers-1]     
DEBU[0283]                                              
DEBU[0283] TASK [docker-ee : Pinning the version down] ************************************ 
DEBU[0283] ok: [67fb8cb05043-registry-1]     
DEBU[0285]                                              
DEBU[0285] TASK [docker-ee : Search the apt-cache for the package] ************************ 
DEBU[0285] changed: [67fb8cb05043-managers-1] 
DEBU[0285]                                              
DEBU[0285] TASK [docker-ee : Pinning the version down] ************************************ 
DEBU[0285] ok: [67fb8cb05043-managers-1]     
DEBU[0309]                                              
DEBU[0309] TASK [docker-ee : Install Docker EE.] ****************************************** 
DEBU[0309] changed: [67fb8cb05043-registry-1] 
DEBU[0309]                                              
DEBU[0309] TASK [docker-ee : Copy package.] *********************************************** 
DEBU[0309] skipping: [67fb8cb05043-registry-1] 
DEBU[0309]                                              
DEBU[0309] TASK [docker-ee : Install package.] ******************************************** 
DEBU[0309] skipping: [67fb8cb05043-registry-1] 
DEBU[0309]                                              
DEBU[0309] TASK [docker-ee : Reconfigure.] ************************************************ 
DEBU[0309] skipping: [67fb8cb05043-registry-1] 
DEBU[0309] included: /cluster/ansible/roles/docker-ee/tasks/install/.unix.post.yml for 67fb8cb05043-registry-1 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Ensure /etc/docker dir exists.] ****************************** 
DEBU[0312] changed: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Install pyOpenSSL] ******************************************* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Copy engine CA certs] **************************************** 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Copy engine CA key] ****************************************** 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Generate private key for docker engine] ********************** 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : shell] ******************************************************* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : shell] ******************************************************* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : shell] ******************************************************* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : shell] ******************************************************* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : set_fact] **************************************************** 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0312]                                              
DEBU[0312] TASK [docker-ee : Ensure /etc/systemd/system/docker.service.d exists.] ********* 
DEBU[0312] skipping: [67fb8cb05043-registry-1] 
DEBU[0313]                                              
DEBU[0313] TASK [docker-ee : Add drop-in file for dockerd.service] ************************ 
DEBU[0313] skipping: [67fb8cb05043-registry-1] 
DEBU[0313]                                              
DEBU[0313] TASK [docker-ee : Add certificate settings to daemon options] ****************** 
DEBU[0313] skipping: [67fb8cb05043-registry-1] 
DEBU[0313]                                              
DEBU[0313] TASK [docker-ee : Reload systemd] ********************************************** 
DEBU[0313] skipping: [67fb8cb05043-registry-1] 
DEBU[0315]                                              
DEBU[0315] TASK [docker-ee : Install Docker EE.] ****************************************** 
DEBU[0315] changed: [67fb8cb05043-managers-1] 
DEBU[0315]                                              
DEBU[0315] TASK [docker-ee : Copy package.] *********************************************** 
DEBU[0315] skipping: [67fb8cb05043-managers-1] 
DEBU[0315]                                              
DEBU[0315] TASK [docker-ee : Install package.] ******************************************** 
DEBU[0315] skipping: [67fb8cb05043-managers-1] 
DEBU[0315]                                              
DEBU[0315] TASK [docker-ee : Reconfigure.] ************************************************ 
DEBU[0315] skipping: [67fb8cb05043-managers-1] 
DEBU[0315] included: /cluster/ansible/roles/docker-ee/tasks/install/.unix.post.yml for 67fb8cb05043-managers-1 
DEBU[0317]                                              
DEBU[0317] TASK [docker-ee : Ensure /etc/docker dir exists.] ****************************** 
DEBU[0317] changed: [67fb8cb05043-managers-1] 
DEBU[0317]                                              
DEBU[0317] TASK [docker-ee : Install pyOpenSSL] ******************************************* 
DEBU[0317] skipping: [67fb8cb05043-managers-1] 
DEBU[0317]                                              
DEBU[0317] TASK [docker-ee : Copy engine CA certs] **************************************** 
DEBU[0317] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Copy engine CA key] ****************************************** 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Generate private key for docker engine] ********************** 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : shell] ******************************************************* 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : shell] ******************************************************* 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : shell] ******************************************************* 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : shell] ******************************************************* 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : set_fact] **************************************************** 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Ensure /etc/systemd/system/docker.service.d exists.] ********* 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Add drop-in file for dockerd.service] ************************ 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Add certificate settings to daemon options] ****************** 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0318]                                              
DEBU[0318] TASK [docker-ee : Reload systemd] ********************************************** 
DEBU[0318] skipping: [67fb8cb05043-managers-1] 
DEBU[0324]                                              
DEBU[0324] TASK [docker-ee : Configure additional engine options] ************************* 
DEBU[0324] changed: [67fb8cb05043-registry-1] 
DEBU[0324]                                              
DEBU[0324] TASK [docker-ee : Remove daemon config when empty] ***************************** 
DEBU[0324] skipping: [67fb8cb05043-registry-1] 
DEBU[0324]                                              
DEBU[0324] TASK [docker-ee : Get current user name (no sudo).] **************************** 
DEBU[0324] ok: [67fb8cb05043-registry-1]     
DEBU[0326]                                              
DEBU[0326] TASK [docker-ee : Adding existing user ubuntu to group docker.] **************** 
DEBU[0326] changed: [67fb8cb05043-registry-1] 
DEBU[0327]                                              
DEBU[0327] TASK [docker-ee : Check if Docker is running] ********************************** 
DEBU[0327] changed: [67fb8cb05043-registry-1] 
DEBU[0329]                                              
DEBU[0329] TASK [docker-ee : Configure additional engine options] ************************* 
DEBU[0329] changed: [67fb8cb05043-managers-1] 
DEBU[0329]                                              
DEBU[0329] TASK [docker-ee : Remove daemon config when empty] ***************************** 
DEBU[0329] skipping: [67fb8cb05043-managers-1] 
DEBU[0329]                                              
DEBU[0329] TASK [docker-ee : Get current user name (no sudo).] **************************** 
DEBU[0329] ok: [67fb8cb05043-managers-1]     
DEBU[0330]                                              
DEBU[0330] TASK [docker-ee : Restarting Docker] ******************************************* 
DEBU[0330] changed: [67fb8cb05043-registry-1] 
DEBU[0331]                                              
DEBU[0331] TASK [docker-ee : Ensure Docker is running after restart] ********************** 
DEBU[0331] changed: [67fb8cb05043-registry-1] 
DEBU[0332]                                              
DEBU[0332] TASK [docker-ee : Adding existing user ubuntu to group docker.] **************** 
DEBU[0332] changed: [67fb8cb05043-managers-1] 
DEBU[0333]                                              
DEBU[0333] TASK [docker-ee : Check if Docker is running] ********************************** 
DEBU[0333] changed: [67fb8cb05043-managers-1] 
DEBU[0334]                                              
DEBU[0334] TASK [docker-ee : Always enable Docker as a system service] ******************** 
DEBU[0334] ok: [67fb8cb05043-registry-1]     
DEBU[0334]                                              
DEBU[0334] TASK [docker-ee : Uninstall.] ************************************************** 
DEBU[0334] skipping: [67fb8cb05043-registry-1] 
DEBU[0334]                                              
DEBU[0334] TASK [docker-ee : Upgrade.] **************************************************** 
DEBU[0334] skipping: [67fb8cb05043-registry-1] 
DEBU[0334]                                              
DEBU[0334] TASK [docker-ee : Logs.] ******************************************************* 
DEBU[0334] skipping: [67fb8cb05043-registry-1] 
DEBU[0338]                                              
DEBU[0338] TASK [docker-ee : Restarting Docker] ******************************************* 
DEBU[0338] changed: [67fb8cb05043-managers-1] 
DEBU[0340]                                              
DEBU[0340] TASK [docker-ee : Ensure Docker is running after restart] ********************** 
DEBU[0340] changed: [67fb8cb05043-managers-1] 
DEBU[0343]                                              
DEBU[0343] TASK [docker-ee : Always enable Docker as a system service] ******************** 
DEBU[0343] ok: [67fb8cb05043-managers-1]     
DEBU[0343]                                              
DEBU[0343] TASK [docker-ee : Uninstall.] ************************************************** 
DEBU[0343] skipping: [67fb8cb05043-managers-1] 
DEBU[0343]                                              
DEBU[0343] TASK [docker-ee : Upgrade.] **************************************************** 
DEBU[0343] skipping: [67fb8cb05043-managers-1] 
DEBU[0343]                                              
DEBU[0343] TASK [docker-ee : Logs.] ******************************************************* 
DEBU[0343] skipping: [67fb8cb05043-managers-1] 
DEBU[0343]                                              
DEBU[0343] PLAY [Initializing Swarm] ****************************************************** 
DEBU[0343]                                              
DEBU[0343] TASK [docker-swarm : Initialize.] ********************************************** 
DEBU[0343] included: /cluster/ansible/roles/docker-swarm/tasks/init/main.yml for 67fb8cb05043-managers-1 
DEBU[0343]                                              
DEBU[0343] TASK [docker-swarm : Check if already active] ********************************** 
DEBU[0346] changed: [67fb8cb05043-managers-1] 
DEBU[0346]                                              
DEBU[0346] TASK [docker-swarm : Get advertise IP for swarm.] ****************************** 
DEBU[0348] changed: [67fb8cb05043-managers-1] 
DEBU[0348]                                              
DEBU[0348] TASK [docker-swarm : Show the IP we found] ************************************* 
DEBU[0348] ok: [67fb8cb05043-managers-1] =>  
DEBU[0348]   eth0_ip:                        
DEBU[0348]     changed: true                 
DEBU[0348]     cmd: ip route get 1.1.1.1 | sed -rn 's|.*src *([^ ]*).*|\1|p' 
DEBU[0348]     delta: '0:00:00.003972'       
DEBU[0348]     end: '2019-05-28 17:31:15.253385' 
DEBU[0348]     failed: false                 
DEBU[0348]     rc: 0                         
DEBU[0348]     start: '2019-05-28 17:31:15.249413' 
DEBU[0348]     stderr: ''                    
DEBU[0348]     stderr_lines: []              
DEBU[0348]     stdout: 172.31.9.19           
DEBU[0348]     stdout_lines:                 
DEBU[0348]     - 172.31.9.19                 
DEBU[0348]                                              
DEBU[0348] TASK [docker-swarm : Advertise the eth0 to be used] **************************** 
DEBU[0348] ok: [67fb8cb05043-managers-1] =>  
DEBU[0348]   msg: 'Advertised IP is: 172.31.9.19' 
DEBU[0348]                                              
DEBU[0348] TASK [docker-swarm : Initialize swarm.] **************************************** 
DEBU[0351] changed: [67fb8cb05043-managers-1] 
DEBU[0351]                                              
DEBU[0351] TASK [docker-swarm : Export manager token.] ************************************ 
DEBU[0353] changed: [67fb8cb05043-managers-1] 
DEBU[0353]                                              
DEBU[0353] TASK [docker-swarm : Export worker token.] ************************************* 
DEBU[0356] changed: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] TASK [docker-swarm : Join.] **************************************************** 
DEBU[0356] skipping: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] TASK [docker-swarm : Validate.] ************************************************ 
DEBU[0356] skipping: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] TASK [docker-swarm : Leave.] *************************************************** 
DEBU[0356] skipping: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] TASK [docker-swarm : Backup.] ************************************************** 
DEBU[0356] skipping: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] TASK [docker-swarm : Labels.] ************************************************** 
DEBU[0356] skipping: [67fb8cb05043-managers-1] 
DEBU[0356]                                              
DEBU[0356] PLAY [Docker login] ************************************************************ 
DEBU[0356]                                              
DEBU[0356] TASK [docker login] ************************************************************ 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357] skipping: [67fb8cb05043-registry-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Query for other required dev images] ************************************* 
DEBU[0357]                                              
DEBU[0357] TASK [ucp pull] **************************************************************** 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357]                                              
DEBU[0357] TASK [ucp images] ************************************************************** 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Extract precise version of ucp] ****************************************** 
DEBU[0357]                                              
DEBU[0357] TASK [set_fact] **************************************************************** 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Fixing ucp version] ****************************************************** 
DEBU[0357]                                              
DEBU[0357] TASK [set_fact] **************************************************************** 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357] skipping: [67fb8cb05043-registry-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Pull required UCP dev images.] ******************************************* 
DEBU[0357]                                              
DEBU[0357] TASK [docker pull] ************************************************************* 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357] skipping: [67fb8cb05043-registry-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Query for required Windows images] *************************************** 
DEBU[0357]                                              
DEBU[0357] TASK [Query for required Windows images] *************************************** 
DEBU[0357] skipping: [67fb8cb05043-managers-1] 
DEBU[0357]                                              
DEBU[0357] PLAY [Configure Windows workers] *********************************************** 
DEBU[0357] skipping: no hosts matched        
DEBU[0357]                                              
DEBU[0357] PLAY [Joining managers to Swarm] *********************************************** 
DEBU[0357] skipping: no hosts matched        
DEBU[0357]                                              
DEBU[0357] PLAY [Joining workers to Swarm] ************************************************ 
DEBU[0357]                                              
DEBU[0357] TASK [docker-swarm : Initialize.] ********************************************** 
DEBU[0357] skipping: [67fb8cb05043-registry-1] 
DEBU[0357] included: /cluster/ansible/roles/docker-swarm/tasks/join/main.yml for 67fb8cb05043-registry-1 
DEBU[0358]                                              
DEBU[0358] TASK [docker-swarm : Joining (Debian).] **************************************** 
DEBU[0358] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0358] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0358] skipping: [67fb8cb05043-registry-1] => (item=Windows)  
DEBU[0358] included: /cluster/ansible/roles/docker-swarm/tasks/join/Debian.yml for 67fb8cb05043-registry-1 
DEBU[0361]                                              
DEBU[0361] TASK [docker-swarm : Check if already active.] ********************************* 
DEBU[0361] changed: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Join Docker Swarm.] *************************************** 
DEBU[0364] changed: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Validate.] ************************************************ 
DEBU[0364] skipping: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Leave.] *************************************************** 
DEBU[0364] skipping: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Backup.] ************************************************** 
DEBU[0364] skipping: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Labels.] ************************************************** 
DEBU[0364] skipping: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] PLAY [Apply Labels] ************************************************************ 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Initialize.] ********************************************** 
DEBU[0364] skipping: [67fb8cb05043-managers-1] 
DEBU[0364] skipping: [67fb8cb05043-registry-1] 
DEBU[0364]                                              
DEBU[0364] TASK [docker-swarm : Join.] **************************************************** 
DEBU[0364] skipping: [67fb8cb05043-managers-1] 
DEBU[0365] skipping: [67fb8cb05043-registry-1] 
DEBU[0365]                                              
DEBU[0365] TASK [docker-swarm : Validate.] ************************************************ 
DEBU[0365] skipping: [67fb8cb05043-managers-1] 
DEBU[0365] skipping: [67fb8cb05043-registry-1] 
DEBU[0365]                                              
DEBU[0365] TASK [docker-swarm : Leave.] *************************************************** 
DEBU[0365] skipping: [67fb8cb05043-managers-1] 
DEBU[0365] skipping: [67fb8cb05043-registry-1] 
DEBU[0365]                                              
DEBU[0365] TASK [docker-swarm : Backup.] ************************************************** 
DEBU[0365] skipping: [67fb8cb05043-managers-1] 
DEBU[0365] skipping: [67fb8cb05043-registry-1] 
DEBU[0365] included: /cluster/ansible/roles/docker-swarm/tasks/labels/main.yml for 67fb8cb05043-managers-1 
DEBU[0365] included: /cluster/ansible/roles/docker-swarm/tasks/labels/main.yml for 67fb8cb05043-registry-1 
DEBU[0365]                                              
DEBU[0365] TASK [docker-swarm : Joining (Debian).] **************************************** 
DEBU[0365] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0365] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0365] skipping: [67fb8cb05043-managers-1] => (item=Windows)  
DEBU[0365] included: /cluster/ansible/roles/docker-swarm/tasks/labels/Debian.yml for 67fb8cb05043-managers-1 
DEBU[0365]                                              
DEBU[0365] TASK [docker-swarm : Joining (Debian).] **************************************** 
DEBU[0365] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0365] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0365] skipping: [67fb8cb05043-registry-1] => (item=Windows)  
DEBU[0365] included: /cluster/ansible/roles/docker-swarm/tasks/labels/Debian.yml for 67fb8cb05043-registry-1 
DEBU[0367]                                              
DEBU[0367] TASK [docker-swarm : Look up the node's ID] ************************************ 
DEBU[0367] changed: [67fb8cb05043-managers-1] 
DEBU[0367]                                              
DEBU[0367] TASK [docker-swarm : Look up the node's ID] ************************************ 
DEBU[0367] changed: [67fb8cb05043-registry-1] 
DEBU[0367]                                              
DEBU[0367] TASK [docker-swarm : Creating a fact for node id] ****************************** 
DEBU[0367] ok: [67fb8cb05043-managers-1]     
DEBU[0367]                                              
DEBU[0367] TASK [docker-swarm : Add labels to this node] ********************************** 
DEBU[0367]                                              
DEBU[0367] TASK [docker-swarm : Creating a fact for node id] ****************************** 
DEBU[0367] ok: [67fb8cb05043-registry-1]     
DEBU[0367]                                              
DEBU[0368] TASK [docker-swarm : Add labels to this node] ********************************** 
DEBU[0368]                                              
DEBU[0368] PLAY [Adding load balancer to SANs] ******************************************** 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Install.] ********************************************************** 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Validate managers.] ************************************************ 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Validate workers.] ************************************************* 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Uninstall UCP.] **************************************************** 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Upgrade UCP.] ****************************************************** 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Logs.] ************************************************************* 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Auth] ************************************************************** 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Pull Config] ******************************************************* 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Push Config] ******************************************************* 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Backup.] *********************************************************** 
DEBU[0368] skipping: [67fb8cb05043-managers-1] 
DEBU[0368]                                              
DEBU[0368] TASK [ucp : Restore.] ********************************************************** 
DEBU[0369] skipping: [67fb8cb05043-managers-1] 
DEBU[0369]                                              
DEBU[0369] TASK [ucp : Add LB to SANs] **************************************************** 
DEBU[0369] included: /cluster/ansible/roles/ucp/tasks/add-lb-to-sans/main.yml for 67fb8cb05043-managers-1 
DEBU[0369]                                              
DEBU[0369] TASK [ucp : Look up the node's ID] ********************************************* 
DEBU[0373] changed: [67fb8cb05043-managers-1] 
DEBU[0373]                                              
DEBU[0373] TASK [ucp : Creating a fact for node id] *************************************** 
DEBU[0373] ok: [67fb8cb05043-managers-1]     
DEBU[0373]                                              
DEBU[0373] TASK [ucp : Creating a fact for labels] **************************************** 
DEBU[0373] ok: [67fb8cb05043-managers-1]     
DEBU[0373]                                              
DEBU[0373] TASK [ucp : Make a copy] ******************************************************* 
DEBU[0373] ok: [67fb8cb05043-managers-1]     
DEBU[0373]                                              
DEBU[0373] TASK [ucp : Add the load balancer to the labels] ******************************* 
DEBU[0373] ok: [67fb8cb05043-managers-1]     
DEBU[0374]                                              
DEBU[0374] TASK [ucp : Add the nodes public IP to the labels] ***************************** 
DEBU[0374] ok: [67fb8cb05043-managers-1]     
DEBU[0374]                                              
DEBU[0374] TASK [ucp : Commit the updated labels] ***************************************** 
DEBU[0376] changed: [67fb8cb05043-managers-1] 
DEBU[0376]                                              
DEBU[0376] PLAY [Installing Kubernetes storage support] *********************************** 
DEBU[0376]                                              
DEBU[0376] TASK [Gathering Facts] ********************************************************* 
DEBU[0379] ok: [67fb8cb05043-managers-1]     
DEBU[0381] ok: [67fb8cb05043-registry-1]     
DEBU[0381]                                              
DEBU[0381] TASK [kubernetes-nfs-storage : Installation ( Debian ).] *********************** 
DEBU[0381] skipping: [67fb8cb05043-managers-1] => (item=Debian)  
DEBU[0381] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0381] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0381] skipping: [67fb8cb05043-registry-1] => (item=Debian)  
DEBU[0381] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0381] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0381]                                              
DEBU[0381] PLAY [Installing kubectl] ****************************************************** 
DEBU[0381]                                              
DEBU[0381] TASK [kubectl : Extract Major.Minor.Patch from 3.2.0-beta4] ******************** 
DEBU[0381] ok: [67fb8cb05043-managers-1]     
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Produce a few variations] ************************************** 
DEBU[0382] ok: [67fb8cb05043-managers-1]     
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Determine kubectl] ********************************************* 
DEBU[0382] ok: [67fb8cb05043-managers-1]     
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Lookup latest stable] ****************************************** 
DEBU[0382] skipping: [67fb8cb05043-managers-1] 
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Read stable version file] ************************************** 
DEBU[0382] skipping: [67fb8cb05043-managers-1] 
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Put version in a variable] ************************************* 
DEBU[0382] skipping: [67fb8cb05043-managers-1] 
DEBU[0382]                                              
DEBU[0382] TASK [kubectl : Check for kubectl] ********************************************* 
DEBU[0384] ok: [67fb8cb05043-managers-1]     
DEBU[0384]                                              
DEBU[0384] TASK [kubectl : Check for kubectl] ********************************************* 
DEBU[0388] ok: [67fb8cb05043-managers-1]     
DEBU[0388]                                              
DEBU[0388] TASK [kubectl : Install Kubectl] *********************************************** 
DEBU[0392] changed: [67fb8cb05043-managers-1] 
DEBU[0392]                                              
DEBU[0392] TASK [kubectl : Symlink up the latest kubectl] ********************************* 
DEBU[0394] changed: [67fb8cb05043-managers-1] 
DEBU[0394]                                              
DEBU[0394] PLAY [Preparing Kubernetes Cloud Provider] ************************************* 
DEBU[0394]                                              
DEBU[0394] TASK [kubernetes-cloud-provider : include_tasks] ******************************* 
DEBU[0394] skipping: [67fb8cb05043-managers-1] => (item=azure)  
DEBU[0394] skipping: [67fb8cb05043-managers-1] => (item=vmware)  
DEBU[0394] skipping: [67fb8cb05043-registry-1] => (item=azure)  
DEBU[0394] skipping: [67fb8cb05043-registry-1] => (item=vmware)  
DEBU[0394]  [WARNING]: Could not match supplied host pattern, ignoring: ucp-load-balancer 
DEBU[0394]                                   
DEBU[0394]                                              
DEBU[0394] PLAY [Configuring a software load balancer for UCP] **************************** 
DEBU[0394] skipping: no hosts matched        
DEBU[0394]                                              
DEBU[0394] PLAY [Installing Docker Universal Control Plane] ******************************* 
DEBU[0394]                                              
DEBU[0394] TASK [ucp : Install.] ********************************************************** 
DEBU[0395] included: /cluster/ansible/roles/ucp/tasks/install/main.yml for 67fb8cb05043-managers-1 
DEBU[0395]                                              
DEBU[0395] TASK [ucp : Check if UCP is running.] ****************************************** 
DEBU[0397] changed: [67fb8cb05043-managers-1] 
DEBU[0397]                                              
DEBU[0397] TASK [ucp : Set ucp_already_running fact.] ************************************* 
DEBU[0397] ok: [67fb8cb05043-managers-1]     
DEBU[0397]                                              
DEBU[0397] TASK [ucp : Write config to ucp_config.toml] *********************************** 
DEBU[0407] changed: [67fb8cb05043-managers-1] 
DEBU[0407]                                              
DEBU[0407] TASK [ucp : Create com.docker.ucp.config] ************************************** 
DEBU[0409] changed: [67fb8cb05043-managers-1] 
DEBU[0409]                                              
DEBU[0409] TASK [ucp : Pull UCP (version: 3.2.0-beta4).] ********************************** 
DEBU[0413] changed: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Copy tarball.] ***************************************************** 
DEBU[0413] skipping: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Load tarball.] ***************************************************** 
DEBU[0413] skipping: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Create temp directory.] ******************************************** 
DEBU[0413] skipping: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Copy tarball.] ***************************************************** 
DEBU[0413] skipping: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Load tarball.] ***************************************************** 
DEBU[0413] skipping: [67fb8cb05043-managers-1] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Check for certificate file (at '').] ******************************* 
DEBU[0413] ok: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0413]                                              
DEBU[0413] TASK [ucp : Check for key file (at '').] *************************************** 
DEBU[0414] ok: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Check for CA certificate file (at '').] **************************** 
DEBU[0414] ok: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : sanity check] ****************************************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : sanity check] ****************************************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Create volume for certificates.] *********************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Get volume path.] ************************************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Copy certificate file.] ******************************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Copy CA certificate file.] ***************************************** 
DEBU[0414] skipping: [67fb8cb05043-managers-1] 
DEBU[0414]                                              
DEBU[0414] TASK [ucp : Copy key file.] **************************************************** 
DEBU[0415] skipping: [67fb8cb05043-managers-1] 
DEBU[0415]                                              
DEBU[0415] TASK [ucp : Check for license file (at /cluster/ansible/docker_subscription.lic).] *** 
DEBU[0415] ok: [67fb8cb05043-managers-1 -> localhost] 
DEBU[0415]                                              
DEBU[0415] TASK [ucp : set_fact] ********************************************************** 
DEBU[0415] ok: [67fb8cb05043-managers-1]     
DEBU[0415]                                              
DEBU[0415] TASK [ucp : Copy subscription.] ************************************************ 
DEBU[0415] skipping: [67fb8cb05043-managers-1] 
DEBU[0415]                                              
DEBU[0415] TASK [ucp : Install UCP (version: 3.2.0-beta4).] ******************************* 
DEBU[0573] changed: [67fb8cb05043-managers-1] 
DEBU[0573]                                              
DEBU[0573] TASK [ucp : Remove config] ***************************************************** 
DEBU[0576] changed: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Validate managers.] ************************************************ 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Validate workers.] ************************************************* 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Uninstall UCP.] **************************************************** 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Upgrade UCP.] ****************************************************** 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Logs.] ************************************************************* 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Auth] ************************************************************** 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0576]                                              
DEBU[0576] TASK [ucp : Pull Config] ******************************************************* 
DEBU[0576] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [ucp : Push Config] ******************************************************* 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [ucp : Backup.] *********************************************************** 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [ucp : Restore.] ********************************************************** 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [ucp : Add LB to SANs] **************************************************** 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] PLAY [Verifying Swarm] ********************************************************* 
DEBU[0577]                                              
DEBU[0577] TASK [docker-swarm : Initialize.] ********************************************** 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [docker-swarm : Join.] **************************************************** 
DEBU[0577] skipping: [67fb8cb05043-managers-1] 
DEBU[0577]                                              
DEBU[0577] TASK [docker-swarm : Validate.] ************************************************ 
DEBU[0577] included: /cluster/ansible/roles/docker-swarm/tasks/validate/main.yml for 67fb8cb05043-managers-1 
DEBU[0577]                                              
DEBU[0577] TASK [docker-swarm : include_tasks] ******************************************** 
DEBU[0577] included: /cluster/ansible/roles/docker-swarm/tasks/cleanup/main.yml for 67fb8cb05043-managers-1 
DEBU[0577]                                              
DEBU[0577] TASK [docker-swarm : Clean up down nodes, if any.] ***************************** 
DEBU[0579] changed: [67fb8cb05043-managers-1] 
DEBU[0579]                                              
DEBU[0579] TASK [docker-swarm : Get number of Docker Swarm nodes.] ************************ 
DEBU[0581] changed: [67fb8cb05043-managers-1] 
DEBU[0581]                                              
DEBU[0581] TASK [docker-swarm : Get number of Docker Swarm managers.] ********************* 
DEBU[0584] changed: [67fb8cb05043-managers-1] 
DEBU[0584]                                              
DEBU[0584] TASK [docker-swarm : set_fact] ************************************************* 
DEBU[0584] ok: [67fb8cb05043-managers-1]     
DEBU[0584]                                              
DEBU[0584] TASK [docker-swarm : set_fact] ************************************************* 
DEBU[0585] ok: [67fb8cb05043-managers-1]     
DEBU[0585]                                              
DEBU[0585] TASK [docker-swarm : assert] *************************************************** 
DEBU[0585] ok: [67fb8cb05043-managers-1] => changed=false  
DEBU[0585]   msg: All assertions passed      
DEBU[0585]                                              
DEBU[0585] TASK [docker-swarm : Leave.] *************************************************** 
DEBU[0585] skipping: [67fb8cb05043-managers-1] 
DEBU[0585]                                              
DEBU[0585] TASK [docker-swarm : Backup.] ************************************************** 
DEBU[0585] skipping: [67fb8cb05043-managers-1] 
DEBU[0585]                                              
DEBU[0585] TASK [docker-swarm : Labels.] ************************************************** 
DEBU[0585] skipping: [67fb8cb05043-managers-1] 
DEBU[0585]                                              
DEBU[0585] PLAY [Installing UCP client bundle] ******************************************** 
DEBU[0585]                                              
DEBU[0585] TASK [ucp-bundle : Login to UCP] *********************************************** 
DEBU[0589] changed: [localhost]              
DEBU[0589]                                              
DEBU[0589] TASK [ucp-bundle : Fetch client bundle] **************************************** 
DEBU[0591] changed: [localhost]              
DEBU[0591]                                              
DEBU[0591] TASK [ucp-bundle : Set client bundle fact] ************************************* 
DEBU[0591] ok: [localhost]                   
DEBU[0591]                                              
DEBU[0591] TASK [ucp-bundle : Copy the bundle to the managers] **************************** 
DEBU[0594] changed: [localhost -> 35.170.33.58] => (item=67fb8cb05043-managers-1) 
DEBU[0594]                                              
DEBU[0594] TASK [ucp-bundle : Copy the bundle to the managers] **************************** 

DEBU[0665] changed: [localhost -> 35.170.33.58] => (item=67fb8cb05043-managers-1) 
DEBU[0665]                                              
DEBU[0665] PLAY [Installing Cloudstor] **************************************************** 
DEBU[0665]                                              
DEBU[0665] TASK [cloudstor-install : Check if plugin is already registered.] ************** 
DEBU[0665] skipping: [67fb8cb05043-managers-1] 
DEBU[0665] skipping: [67fb8cb05043-registry-1] 
DEBU[0665]                                              
DEBU[0665] TASK [cloudstor-install : include_tasks] *************************************** 
DEBU[0665] skipping: [67fb8cb05043-managers-1] => (item=RedHat)  
DEBU[0665] skipping: [67fb8cb05043-managers-1] => (item=Suse)  
DEBU[0665] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0665] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0665] included: /cluster/ansible/roles/cloudstor-install/tasks/Debian.yml for 67fb8cb05043-managers-1, 67fb8cb05043-registry-1 
DEBU[0665]                                              
DEBU[0665] TASK [cloudstor-install : Install NFS support] ********************************* 
DEBU[0665] skipping: [67fb8cb05043-managers-1] 
DEBU[0666] skipping: [67fb8cb05043-registry-1] 
DEBU[0666]                                              
DEBU[0666] TASK [cloudstor-install : Install Cloudstor plugin] **************************** 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666] skipping: [67fb8cb05043-registry-1] 
DEBU[0666]                                              
DEBU[0666] PLAY [Configuring Kubernetes for AWS] ****************************************** 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-aws : Copy to account definition to remote] ******************* 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-aws : Build the account] ************************************** 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-aws : Configure EFS Provisioner Role.] ************************ 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-aws : Create EFS provisioner] ********************************* 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] PLAY [Configuring Kubernetes for Azure] **************************************** 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-azure : Copy the template to a manager] *********************** 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] TASK [kubernetes-azure : Apply the configuration] ****************************** 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] PLAY [Verifying UCP install on managers] *************************************** 
DEBU[0666]                                              
DEBU[0666] TASK [ucp : Install.] ********************************************************** 
DEBU[0666] skipping: [67fb8cb05043-managers-1] 
DEBU[0666]                                              
DEBU[0666] TASK [ucp : Validate managers.] ************************************************ 
DEBU[0666] included: /cluster/ansible/roles/ucp/tasks/validate-managers/main.yml for 67fb8cb05043-managers-1 
DEBU[0667]                                              
DEBU[0667] TASK [ucp : Wait for Docker UCP to be accessible on 443.] ********************** 
DEBU[0669] ok: [67fb8cb05043-managers-1]     
DEBU[0669]                                              
DEBU[0669] TASK [ucp : Sleep (30 seconds).] *********************************************** 
DEBU[0700] ok: [67fb8cb05043-managers-1]     
DEBU[0701]                                              
DEBU[0701] TASK [ucp : Wait for Docker UCP to be accessible via 35.170.33.58.] ************ 
DEBU[0704] ok: [67fb8cb05043-managers-1]     
DEBU[0704]                                              
DEBU[0704] TASK [ucp : Validate workers.] ************************************************* 
DEBU[0704] skipping: [67fb8cb05043-managers-1] 
DEBU[0704]                                              
DEBU[0704] TASK [ucp : Uninstall UCP.] **************************************************** 
DEBU[0704] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Upgrade UCP.] ****************************************************** 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Logs.] ************************************************************* 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Auth] ************************************************************** 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Pull Config] ******************************************************* 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Push Config] ******************************************************* 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Backup.] *********************************************************** 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Restore.] ********************************************************** 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Add LB to SANs] **************************************************** 
DEBU[0705] skipping: [67fb8cb05043-managers-1] 
DEBU[0705]                                              
DEBU[0705] PLAY [Verifying UCP install on workers] **************************************** 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Install.] ********************************************************** 
DEBU[0705] skipping: [67fb8cb05043-registry-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Validate managers.] ************************************************ 
DEBU[0705] skipping: [67fb8cb05043-registry-1] 
DEBU[0705]                                              
DEBU[0705] TASK [ucp : Validate workers.] ************************************************* 
DEBU[0705] included: /cluster/ansible/roles/ucp/tasks/validate-workers/main.yml for 67fb8cb05043-registry-1 
DEBU[0706]                                              
DEBU[0706] TASK [ucp : include_tasks] ***************************************************** 
DEBU[0706] skipping: [67fb8cb05043-registry-1] => (item=RedHat)  
DEBU[0706] skipping: [67fb8cb05043-registry-1] => (item=Suse)  
DEBU[0706] skipping: [67fb8cb05043-registry-1] => (item=Windows)  
DEBU[0706] included: /cluster/ansible/roles/ucp/tasks/validate-workers/Debian.yml for 67fb8cb05043-registry-1 
DEBU[0706]                                              
DEBU[0706] TASK [ucp : Check for ucp-proxy container.] ************************************ 
DEBU[0709] changed: [67fb8cb05043-registry-1] 
DEBU[0709]                                              
DEBU[0709] TASK [ucp : Uninstall UCP.] **************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Upgrade UCP.] ****************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Logs.] ************************************************************* 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Auth] ************************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Pull Config] ******************************************************* 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Push Config] ******************************************************* 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Backup.] *********************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Restore.] ********************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] TASK [ucp : Add LB to SANs] **************************************************** 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]  [WARNING]: Could not match supplied host pattern, ignoring: dtr-load-balancer 
DEBU[0710]                                   
DEBU[0710]                                              
DEBU[0710] PLAY [Setting up load balancer] ************************************************ 
DEBU[0710] skipping: no hosts matched        
DEBU[0710]                                              
DEBU[0710] PLAY [Docker login] ************************************************************ 
DEBU[0710]                                              
DEBU[0710] TASK [docker login] ************************************************************ 
DEBU[0710] skipping: [67fb8cb05043-managers-1] 
DEBU[0710] skipping: [67fb8cb05043-registry-1] 
DEBU[0710]                                              
DEBU[0710] PLAY [Query DTR images.] ******************************************************* 
DEBU[0711]                                              
DEBU[0711] TASK [Pull DTR first] ********************************************************** 
DEBU[0711] skipping: [67fb8cb05043-registry-1] 
DEBU[0711]                                              
DEBU[0711] TASK [Query for required DTR images] ******************************************* 
DEBU[0711] skipping: [67fb8cb05043-registry-1] 
DEBU[0711]                                              
DEBU[0711] PLAY [Pull DTR images] ********************************************************* 
DEBU[0711]                                              
DEBU[0711] TASK [Pull DTR images] ********************************************************* 
DEBU[0711] skipping: [67fb8cb05043-registry-1] 
DEBU[0711]                                              
DEBU[0711] PLAY [Installing Docker Trusted Registry] ************************************** 
DEBU[0711]                                              
DEBU[0711] TASK [dtr : Install.] ********************************************************** 
DEBU[0711] included: /cluster/ansible/roles/dtr/tasks/install/main.yml for 67fb8cb05043-registry-1 
DEBU[0711]                                              
DEBU[0711] TASK [dtr : Check if DTR is already running.] ********************************** 
DEBU[0714] changed: [67fb8cb05043-registry-1] 
DEBU[0714]                                              
DEBU[0714] TASK [dtr : Set is_already_running fact.] ************************************** 
DEBU[0714] ok: [67fb8cb05043-registry-1]     
DEBU[0714]                                              
DEBU[0714] TASK [dtr : Pull DTR (version: 2.7.0-beta4).] ********************************** 
DEBU[0717] changed: [67fb8cb05043-registry-1] 
DEBU[0717]                                              
DEBU[0717] TASK [dtr : Copy tarball.] ***************************************************** 
DEBU[0717] skipping: [67fb8cb05043-registry-1] 
DEBU[0717]                                              
DEBU[0717] TASK [dtr : Load tarball.] ***************************************************** 
DEBU[0717] skipping: [67fb8cb05043-registry-1] 
DEBU[0717]                                              
DEBU[0717] TASK [dtr : Check for certificate file (at '').] ******************************* 
DEBU[0718] ok: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0718]                                              
DEBU[0718] TASK [dtr : Check for key file (at '').] *************************************** 
DEBU[0718] ok: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0718]                                              
DEBU[0718] TASK [dtr : Check for CA certificate file (at '').] **************************** 
DEBU[0718] ok: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0718]                                              
DEBU[0718] TASK [dtr : Check for UCP CA certificate file (at '').] ************************ 
DEBU[0719] ok: [67fb8cb05043-registry-1 -> localhost] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : sanity check] ****************************************************** 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : sanity check] ****************************************************** 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : Copy certificate file.] ******************************************** 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : Copy CA certificate file.] ***************************************** 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : Copy UCP CA certificate file.] ************************************* 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : Copy key file.] **************************************************** 
DEBU[0719] skipping: [67fb8cb05043-registry-1] 
DEBU[0719]                                              
DEBU[0719] TASK [dtr : Pull DTR container] ************************************************ 
DEBU[0721] changed: [67fb8cb05043-registry-1] 
DEBU[0721]                                              
DEBU[0721] TASK [dtr : Start installing DTR] ********************************************** 
DEBU[0723] changed: [67fb8cb05043-registry-1]
```

```
[Captains-Bay]🚩 >  docker cluster inspect fervent_taussig
name: fervent_taussig
shortid: 67fb8cb05043
variable:
  region: us-east-1
  subscription_url: https://storebits.docker.com/ee/m/sub-a3dd83ed-d9db-440f-a175-e11347fb1037/
  ucp_password: Oracle9ias
provider:
  aws:
    region: us-east-1
    tags:
      pet: "true"
      project: CSG-DCI
    version: ~> 1.0
cluster:
  dtr:
    version: docker/dtr:2.7.0-beta4
  engine:
    storage_volume: /dev/xvdb
    url: https://storebits.docker.com/ee/m/sub-a3dd83ed-d9db-440f-a175-e11347fb1037/
    version: ee-test-19.03
  registry:
    url: https://index.docker.io/v1/
    username: ajeetraina
  ucp:
    username: admin
    version: docker/ucp:3.2.0-beta4
resource:
  aws_instance:
    managers:
      _running:
        managers_ids:
        - i-088036137bdf5564a
        managers_ips:
        - 35.170.33.58
      instance_type: t2.xlarge
      os: Ubuntu 16.04
      quantity: 1
      role: manager
    registry:
      _running:
        registry_ids:
        - i-016770ea989a55a0a
        registry_ips:
        - 18.208.208.51
      instance_type: t2.xlarge
      os: Ubuntu 16.04
      quantity: 1
      role: dtr

```

```
[Captains-Bay]🚩 >  docker context ls
NAME                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                ORCHESTRATOR
default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://localhost:6443 (default)   swarm
fervent_taussig     fervent_taussig                           tcp://35.170.33.58:443                                           
[Captains-Bay]🚩 >  docker context use fervent_taussig
fervent_taussig
Current context is now "fervent_taussig"
[Captains-Bay]🚩 >  docker node ls
ID                            HOSTNAME                       STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
fbe5k12hyoit5qcdtatamz907 *   ip-172-31-9-19.ec2.internal    Ready               Active              Leader              19.03.0-beta4
hs8jz9vnuwqjjjukzh9s2rejc     ip-172-31-10-73.ec2.internal   Ready               Active                                  19.03.0-beta4
[Captains-Bay]🚩 >
```

```
[Captains-Bay]🚩 >  docker version
Client: Docker Engine - Community
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 19:05:38 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Enterprise 3.0
 Engine:
  Version:          19.03.0-beta4
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.11.5
  Git commit:       d9934ea
  Built:            Tue May 14 06:43:37 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
 Universal Control Plane:
  Version:          3.2.0-beta4
  ApiVersion:       1.40
  Arch:             amd64
  BuildTime:        Thu May 16 00:23:28 UTC 2019 
  GitCommit:        93be304
  GoVersion:        go1.12.3
  MinApiVersion:    1.20
  Os:               linux
 Kubernetes:
  Version:          1.14+
  buildDate:        2019-04-09T04:40:58Z
  compiler:         gc
  gitCommit:        0afac0d5083db76807439791b0ea7244d199a274
  gitTreeState:     clean
  gitVersion:       v1.14.1-docker-1
  goVersion:        go1.12.1
  major:            1
  minor:            14+
  platform:         linux/amd64
 Calico:
  Version:          v3.5.4
  cni:              v3.5.4
  kube-controllers: v3.5.4
  node:             v3.5.4
[Captains-Bay]🚩 >  
```
