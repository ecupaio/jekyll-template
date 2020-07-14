## this creates a webhook in github for this repo
resource :Webhook, 'AWS::CodePipeline::Webhook', DependsOn: [:Secret, :CodePipeline] do
  authentication :GITHUB_HMAC
  authentication_configuration do
    secret_token Fn::sub('{{resolve:secretsmanager:${Secret}}}')
  end
  filters [
    {
      JsonPath: '$.ref',
      MatchEquals: 'refs/heads/{Branch}',
    }
  ]
  target_pipeline Fn::ref(:CodePipeline)
  target_pipeline_version Fn::get_att(:CodePipeline, :Version)
  target_action :App
  register_with_third_party true
end
