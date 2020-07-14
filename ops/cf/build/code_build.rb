ENVIRONMENT = {
  BRANCH: Fn::ref(:branch),
  S3_BUCKET_DEPLOY: Fn::import_value(Fn::sub('${bucket}-S3Bucket')),
  CLOUDFRONT_DISTRIBUTION: Fn::ref(:cfid),
  BUILD_ENV: Fn::ref(:ssmenv)
}

resource :CodeBuild, 'AWS::CodeBuild::Project', DependsOn: :IamRoleBuild do
  name Fn::ref('AWS::StackName')
  service_role Fn::get_att(:IamRoleBuild, :Arn)
  source do
    type :CODEPIPELINE
    git_clone_depth 1
  end
  environment do
    compute_type :BUILD_GENERAL1_MEDIUM
    environment_variables ENVIRONMENT.map { |k, v|
      { Name: k, Value: v }
    }
    image 'aws/codebuild/ruby:2.3.1'
    privileged_mode true
    type :LINUX_CONTAINER
  end
  artifacts do
    type :CODEPIPELINE
  end
end

output :CodeBuild, Fn::ref(:CodeBuild), export: Fn::sub('${AWS::StackName}-CodeBuild')
