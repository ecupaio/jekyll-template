require 'digest'

## read file containing lambda code
code = File.read(File.join(File.dirname(__FILE__), 'lambda_origin_request.js'))

## create lambda version resource logical id that is unique based on code changes
code_md5 = Digest::MD5.hexdigest(code)
@lambda_version_origin = "LambdaVersion#{code_md5}"

resource :LambdaOriginRequest, 'AWS::Lambda::Function', DependsOn: :IamRoleLambda do
  role Fn::get_att(:IamRoleLambda, :Arn)
  code do
    zip_file code
  end
  handler 'index.handler'
  runtime 'nodejs10.x'
  memory_size 128
end
