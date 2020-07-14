resource :EcsCluster, 'AWS::ECS::Cluster' do
  cluster_name Fn::ref('AWS::StackName')
end
