module "iam_role_policies" {
    source = "./modules/iam_role_policies"

    iam_role_default_name = "${module.iam_roles.default_role_name}"
    s3_bucket = "${var.app_name}-production"
    cloudfront_id = "${module.cloudfront.cf_id}"
}

module "security_group_rules" {
    source = "./modules/security_group_rules"

    host_sg_id = "${module.security_groups.host_sg_id}"
}

# Only use this module if you need to redirect www -> non-www
# i.e. www.collegedems.com -> collegedems.com
#module "www_redirect" {
#    source = "./modules/www_redirect"
#    
#    bucket_name = "${var.app_name}-production-www-redirect"
#    site_domain = "${var.site_domain}"
#    cf_cert = "${var.cf_cert}"
#}
