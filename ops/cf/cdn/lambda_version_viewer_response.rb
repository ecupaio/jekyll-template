resource @lambda_version_viewer, 'AWS::Lambda::Version', DependsOn: :LambdaViewerResponse do
  function_name Fn::ref(:LambdaViewerResponse)
end
