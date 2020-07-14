resource :Route53, 'AWS::Route53::RecordSet', DependsOn: :Alb do
  type :A
  name(
    Fn::sub(
      '${AWS::StackName}.${domain}',
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
    DNSName Fn::get_att(:Alb, :DNSName)
    hosted_zone_id Fn::find_in_map(:AlbHostedZone, Fn::ref('AWS::Region'), :id)
  end
end

output :Route53, Fn::ref(:Route53)
