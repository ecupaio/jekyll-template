description ''

parameter :branch, type: :String

## bucket stack to import
parameter :bucket, type: :String

## optional cloudfront distribution ID to invalidate
parameter :cfid, type: :String, default: ''

parameter :ssmenv, type: :String

parameter :ghowner,  type: :String, default: ''
parameter :ghrepo,   type: :String, default: ''
parameter :ghbranch, type: :String
parameter :ghtoken,  type: 'AWS::SSM::Parameter::Value<String>', default: '/github/arcadia-access/codepipeline'

include_template(
  'build/s3_bucket.rb',
  'build/iam_role_build.rb',
  'build/code_build.rb',
  'build/iam_role_pipeline.rb',
  'build/code_pipeline.rb',
  'build/secret.rb',
  'build/webhook.rb'
)
