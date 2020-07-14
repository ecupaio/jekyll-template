resource @lambda_version_origin, 'AWS::Lambda::Version', DependsOn: :LambdaOriginRequest do
  function_name Fn::ref(:LambdaOriginRequest)
end
