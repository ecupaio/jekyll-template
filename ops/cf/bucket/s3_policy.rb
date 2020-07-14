## Make the bucket public, so that it can be accessed in the fedev account without a CDN
## Important: this policy will be overridden on the bucket by one or both of the cdn and proxy stacks,
## which will disable public access and enable access just from the cdn and/or proxy.
resource :S3BucketPolicy, 'AWS::S3::BucketPolicy', DependsOn: :S3Bucket do
  bucket Fn::ref(:S3Bucket)
  policy_document(
    {
      Version: '2012-10-17',
      Statement: [
        {
          Effect: :Allow,
          Principal: Fn.if(:IsFedevAccount, '*', { "AWS": Fn.sub('${AWS::AccountId}') }),
          Action: 's3:GetObject',
          Resource: [
            Fn::sub('arn:aws:s3:::${S3Bucket}/*'),
          ]
        }
      ]
    }
  )
end
