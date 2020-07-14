description ''

parameter :bucket, type: :String
parameter :branch, type: :String

## SSL cert
parameter :cert, type: 'AWS::SSM::Parameter::Value<String>', default: "/certs/master/peacock/Cert"

## needed to add proxy to s3 policy
parameter :VpceS3, type: :String
condition :HasVpceS3, Fn.not(Fn.equals(Fn.ref(:VpceS3), ''))

## for setting special CDN aliases
condition :IsProduction, Fn::equals(Fn::ref(:branch), 'master')

mappings(
  Account: {
    '': { domain: '' }
  },
)

include_template(
  'cdn/iam_role_lambda.rb',
  'cdn/lambda_origin_request.rb',
  'cdn/lambda_viewer_response.rb',
  'cdn/lambda_version_origin_request.rb',
  'cdn/lambda_version_viewer_response.rb',
  'cdn/origin_access_identity.rb',
  'cdn/s3_policy.rb',
  'cdn/distribution.rb',
  'cdn/route53.rb',
)
