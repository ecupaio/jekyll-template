require 'digest'

code = File.read(File.join(File.dirname(__FILE__), 'lambda_viewer_response.js'))

## create lambda version resource logical id that is unique based on code changes
code_md5 = Digest::MD5.hexdigest(code)
@lambda_version_viewer = "LambdaVersion#{code_md5}"

resource :LambdaViewerResponse, 'AWS::Lambda::Function', DependsOn: :IamRoleLambda do
  role Fn::get_att(:IamRoleLambda, :Arn)
  code do
    zip_file code
  end
  handler 'index.handler'
  runtime 'nodejs10.x'
  memory_size 128
end
