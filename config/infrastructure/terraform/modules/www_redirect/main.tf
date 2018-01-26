# Terraform module for creating an S3 bucket.

# See https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
resource "aws_s3_bucket" "redirect_bucket" {
    bucket = "${var.bucket_name}"

    website {
        redirect_all_requests_to = "https://${var.site_domain}"
    }
    
    tags {
        Name = "${var.bucket_name}"
    }
}

resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = "${aws_s3_bucket.redirect_bucket.id}.s3-website-us-east-1.amazonaws.com"
    origin_id = "S3ORIGIN-${aws_s3_bucket.redirect_bucket.id}"
    
    custom_origin_config = {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [ "SSLv3" ]
    }
  }
  
  enabled = true
    
  default_root_object = ""
  price_class = "PriceClass_All"
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    
  aliases = ["www.${var.site_domain}"]
  
  default_cache_behavior {
    allowed_methods  = ["GET", "DELETE", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3ORIGIN-${aws_s3_bucket.redirect_bucket.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  
  viewer_certificate {
    acm_certificate_arn = "${var.cf_cert}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_ident" {
  comment = "S3 Origin"
}
