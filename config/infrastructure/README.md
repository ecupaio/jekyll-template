# Setting up deployment configs

## Ansible

Update the `ansible/group_vars/all` file with your values:
```
app_name: "" # Unique name for the app (no spaces)
repo_name: "" # This repo name (can be the same as app_name)
app_hostname: "" # The destination domain for this site (do not include www)
app_admin_hostname: "" # The full url to where the admin should end up (i.e. admin.mysite.com or app-admin.mysite.com)
s3_bucket: "" # Generally "<app_name>-production"
cloudfront_distribution: "" # Leave this blank. Might not even need to be here.

# These should probably be left alone
nginx_user: "nginx"
app_environment: "production"
app_deployment_path: "/home/ec2-user"
```

## Terraform

Update the `terraform/production.tfvars` file with your values:
```
## Update these values 
app_name = "" # This should match app_name in ansible
site_domain = "" # This should match app_hostname in ansible
jekyll_ip = "" # Find one on this doc and update with info - https://docs.google.com/a/dnc.org/spreadsheets/d/1r9DNXeYog5gYsU9UFPJdfRL0UnU2w7SicscHAtTBKUE/edit?usp=sharing

## Ask systems for values here
cf_cert = "" # If you know another app that has already been deployed and has the same domain (i.e. *.democrats.org), this value will be the same as it is in that app.
iam_instance_profile_name = ""
```

Also, if your app does not need to redirect www to non-www, remove the `www_redirect` module block from `terraform/override.tf` and remove the `modules/www_redirect` directory.
