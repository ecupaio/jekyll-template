## Override the bucket policy (which was public from bucket stack creation) so that it is only
## accessible from:
##   - vpc endpoint for this proxy to have access
##   - cloudfront distribution if the cdn stack exists
resource :S3BucketPolicy, 'AWS::S3::BucketPolicy' do
  bucket Fn.import_value(Fn.sub('${bucket}-S3Bucket'))
  policy_document(
    {
      Version: '2012-10-17',
      Statement: [
        ## allow CDN access
        Fn::if(
          :HasCanonicalUser,
          {
            Effect: :Allow,
            Principal: {
              CanonicalUser: Fn::ref(:CanonicalUser)
            },
            Action: 's3:GetObject',
            Resource: Fn::join('/', Fn.import_value(Fn.sub('${bucket}-S3BucketArn')), '*'),
          },
          Fn::ref('AWS::NoValue')
        ),
        ## allow proxy access via vpc endpoint
        {
          Effect: :Allow,
          Principal: '*',
          Action: 's3:GetObject',
          Resource: Fn::join('/', Fn.import_value(Fn.sub('${bucket}-S3BucketArn')), '*'),
          Condition: {
            StringEquals: {
              'aws:sourceVpce': Fn::import_value(Fn::sub('${vpc}-VpceS3'))
            }
          }
        }
      ]
    }
  )
end
