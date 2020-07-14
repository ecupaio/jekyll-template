NGINX_CFG = <<~EOF
  server {
    listen 80;
    location / {
      proxy_pass ${s3url};
      proxy_intercept_errors on;
      error_page 403 404 =301 $scheme://$host;
    }
    location /health {
      return 200 'ok';
    }
  }
EOF

ENVIRONMENT = {
  CFG: Fn::sub(NGINX_CFG, s3url: Fn::import_value(Fn::sub('${bucket}-S3BucketWebsiteURL')))
}

resource :EcsTask, 'AWS::ECS::TaskDefinition', DependsOn: [:LogGroup, :IamRoleExec, :IamRoleTask] do
  cpu 256
  memory 512
  family Fn::ref('AWS::StackName')
  requires_compatibilities [:FARGATE]
  execution_role_arn Fn::ref(:IamRoleExec)
  task_role_arn Fn::ref(:IamRoleTask)
  network_mode :awsvpc
  container_definitions [
    {
      Name: :app,
      Image: 'nginx:alpine',
      MemoryReservation: 512,
      Environment: ENVIRONMENT.map { |k, v|
        { Name: k, Value: v }
      },
      PortMappings: [
        { ContainerPort: 80 }
      ],
      Command: [
        '/bin/sh', '-c', 'echo $CFG > /etc/nginx/conf.d/default.conf && exec nginx -g "daemon off;"'
      ],
      LogConfiguration: {
        LogDriver: :awslogs,
        Options: {
          'awslogs-group'         => Fn::ref(:LogGroup),
          'awslogs-region'        => Fn::ref('AWS::Region'),
          'awslogs-stream-prefix' => :app,
        }
      }
    }
  ]
end
