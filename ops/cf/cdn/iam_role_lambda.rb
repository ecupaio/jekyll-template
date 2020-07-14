## service role for lambda to execute
resource :IamRoleLambda, 'AWS::IAM::Role' do
  path '/'
  assume_role_policy_document(
    Version: '2012-10-17',
    Statement: [
      {
        Effect: :Allow,
        Principal: {
          Service: [
            'lambda.amazonaws.com',
            'edgelambda.amazonaws.com',
          ]
        },
        Action: 'sts:AssumeRole'
      }
    ]
  )
  managed_policy_arns(
    [
      'arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole',
    ]
  )
end
