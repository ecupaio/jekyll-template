resource :S3Bucket, 'AWS::S3::Bucket', DeletionPolicy: :Retain do
  website_configuration(
    IndexDocument: 'index.html',
    ErrorDocument: 'index.html'
  )
  tag 'ap:delete', :DELETE_ORPHAN
  access_control 'LogDeliveryWrite'
  logging_configuration(
    DestinationBucketName: Fn::sub('s3log-${AWS::AccountId}'),
    LogFilePrefix: Fn::sub('${AWS::StackName}/')
  )
  public_access_block_configuration(
    BlockPublicAcls: Fn.if(:IsFedevAccount, false, true),
    BlockPublicPolicy: Fn.if(:IsFedevAccount, false, true),
    IgnorePublicAcls: Fn.if(:IsFedevAccount, false, true),
    RestrictPublicBuckets: Fn.if(:IsFedevAccount, false, true)
  )
end

output :S3Bucket,           Fn::ref(:S3Bucket),                  export: Fn::sub('${AWS::StackName}-S3Bucket')
output :S3BucketArn,        Fn::get_att(:S3Bucket, :Arn),        export: Fn::sub('${AWS::StackName}-S3BucketArn')
output :S3BucketDomainName, Fn::get_att(:S3Bucket, :DomainName), export: Fn::sub('${AWS::StackName}-S3BucketDomainName')
output :S3BucketWebsiteURL, Fn::get_att(:S3Bucket, :WebsiteURL), export: Fn::sub('${AWS::StackName}-S3BucketWebsiteURL')
