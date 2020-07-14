resource :LogGroup, 'AWS::Logs::LogGroup' do
  log_group_name Fn::sub('/peacock/${AWS::StackName}')
  retention_in_days 30
end
