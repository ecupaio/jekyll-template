## this adds a deployment bucket policy allowing access from cloudfront
resource :S3BucketPolicy, 'AWS::S3::BucketPolicy', DependsOn: :OriginAccessIdentity do
  bucket Fn.import_value(Fn.sub('${bucket}-S3Bucket'))
  policy_document(
    {
      Version: '2012-10-17',
      Statement: [
        {
          Effect: :Allow,
          Principal: {
            CanonicalUser: Fn::get_att(:OriginAccessIdentity, :S3CanonicalUserId)
          },
          Action: 's3:GetObject',
          Resource: Fn::join('/', Fn.import_value(Fn.sub('${bucket}-S3BucketArn')), '*'),
        },
        ## allow proxy access via vpc endpoint
        Fn::if(
          :HasVpceS3,
          {
            Effect: :Allow,
            Principal: '*',
            Action: 's3:GetObject',
            Resource: Fn::join('/', Fn.import_value(Fn.sub('${bucket}-S3BucketArn')), '*'),
            Condition: {
              StringEquals: {
                'aws:sourceVpce': Fn::ref(:VpceS3)
              }
            }
          },
          Fn::ref('AWS::NoValue')
        )
      ]
    }
  )
end
