resource :Route53, 'AWS::Route53::RecordSet', DependsOn: :Distribution do
  type :A
  name(
    Fn::sub(
      'peacock-${branch}.${domain}',
      domain: Fn::find_in_map(:Account, Fn::ref('AWS::AccountId'), :domain)
    )
  )
  hosted_zone_name(
    Fn::sub(
      '${domain}.',
      domain: Fn::find_in_map(:Account, Fn::ref('AWS::AccountId'), :domain)
    )
  )
  alias_target do
    DNSName Fn::get_att(:Distribution, :DomainName)
    hosted_zone_id 'Z2FDTNDATAQYW2' # magic value for cloudfront
  end
end

output :Route53, Fn::ref(:Route53)
