## create an arbitrary secret for github HMAC to use
resource :Secret, 'AWS::SecretsManager::Secret' do
  description Fn::ref('AWS::StackName')
  generate_secret_string {}
end
