resource :VpceS3, 'AWS::EC2::VPCEndpoint', DependsOn: [:Vpc, :RouteTable] do
  vpc_id Fn::ref(:Vpc)
  route_table_ids [Fn::ref(:RouteTable)]
  service_name Fn::sub('com.amazonaws.${AWS::Region}.s3')
end

output :VpceS3, Fn::ref(:VpceS3), export: Fn::sub('${AWS::StackName}-VpceS3')
