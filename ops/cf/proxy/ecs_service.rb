resource :EcsService, 'AWS::ECS::Service', DependsOn: [:EcsCluster, :EcsTask, :ListenerHttps] do
  cluster Fn::ref(:EcsCluster)
  desired_count Fn::if(:DesiredCount, Fn::ref(:desired), AWS::no_value)
  launch_type :FARGATE
  network_configuration do
    awsvpc_configuration do
      subnets Fn::split(',', Fn::import_value(Fn::sub('${vpc}-SubnetIds')))
      assign_public_ip :ENABLED
      security_groups [
        Fn::ref(:SgAlb)
      ]
    end
  end
  task_definition Fn::ref(:EcsTask)
  load_balancers [
    {
      ContainerName: :app,
      ContainerPort: 80,
      TargetGroupArn: Fn::ref(:TargetGroup),
    }
  ]
end
