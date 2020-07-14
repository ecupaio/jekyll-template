dependencies = [
  :OriginAccessIdentity,
  @lambda_version_origin,
  @lambda_version_viewer,
]

resource :Distribution, 'AWS::CloudFront::Distribution', DependsOn: dependencies do
  distribution_config do
    aliases [
      ## per-account delegated subdomain
      Fn::sub('peacock-${branch}.${domain}', domain: Fn::find_in_map(:Account, Fn::ref('AWS::AccountId'), :domain)),
      ## user-facing domain name
      Fn::if(:IsProduction, 'arcadia.com',     Fn::ref('AWS::NoValue')),
      Fn::if(:IsProduction, 'www.arcadia.com', Fn::ref('AWS::NoValue')),
      Fn::if(:IsProduction, 'www.arcadia.com', Fn::ref('AWS::NoValue')),
      ## new bird-name domain
      Fn::if(:IsProduction, 'peacock.arcadia.com', Fn::sub('${branch}.peacock.arcadia.com')),
    ]
    viewer_certificate do
      acm_certificate_arn Fn.ref(:cert)
      ssl_support_method 'sni-only'
      minimum_protocol_version 'TLSv1.1_2016'
    end
    comment Fn::ref('AWS::StackName')
    custom_error_responses [
      {
        ErrorCode: '403',
        ErrorCachingMinTTL: 300,
        ResponseCode: '200',
        ResponsePagePath: '/index.html',
      },
      {
        ErrorCode: '404',
        ErrorCachingMinTTL: 300,
        ResponseCode: '200',
        ResponsePagePath: '/index.html',
      },
    ]
    default_cache_behavior do
      forwarded_values do
        query_string :false
      end
      lambda_function_associations [
        {
          EventType: 'origin-request',
          LambdaFunctionARN: Fn::ref(@lambda_version_origin),
        },
        {
          EventType: 'viewer-response',
          LambdaFunctionARN: Fn::ref(@lambda_version_viewer),
        }
      ]
      target_origin_id Fn.sub('${AWS::StackName}-origin')
      viewer_protocol_policy 'redirect-to-https'
    end
    default_root_object 'index.html'
    enabled true
    origins [
      {
        Id: Fn.sub('${AWS::StackName}-origin'),
        DomainName: Fn.import_value(Fn.sub('${bucket}-S3BucketDomainName')),
        S3OriginConfig: {
          OriginAccessIdentity: Fn.sub('origin-access-identity/cloudfront/${OriginAccessIdentity}')
        }
      }
    ]
    price_class :PriceClass_100 # US and Europe only
  end
  ap_tags
end

output :Distribution,       Fn::ref(:Distribution),                  export: Fn::sub('${AWS::StackName}-Distribution')
output :DistributionDomain, Fn::get_att(:Distribution, :DomainName), export: Fn::sub('${AWS::StackName}-DistributionDomain')
