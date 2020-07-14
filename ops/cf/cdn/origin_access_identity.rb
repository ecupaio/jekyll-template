resource :OriginAccessIdentity, 'AWS::CloudFront::CloudFrontOriginAccessIdentity' do
  cloud_front_origin_access_identity_config do
    comment Fn::ref('AWS::StackName')
  end
end

output :CanonicalUserId, Fn::get_att(:OriginAccessIdentity, :S3CanonicalUserId), export: Fn::sub('${AWS::StackName}-CanonicalUserId')
