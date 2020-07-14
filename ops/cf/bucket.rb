description ''

condition :IsFedevAccount, Fn.equals(Fn.ref('AWS::AccountId'), '')

include_template(
  'bucket/s3_bucket.rb',
  'bucket/s3_policy.rb',
)
