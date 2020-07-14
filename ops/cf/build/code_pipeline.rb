resource :CodePipeline, 'AWS::CodePipeline::Pipeline', DependsOn: [:IamRolePipeline, :S3Bucket, :CodeBuild] do
  role_arn Fn::get_att(:IamRolePipeline, :Arn)
  artifact_store do
    type :S3
    location Fn::ref(:S3Bucket)
  end
  stages [
    {
      Name: :Source,
      Actions: [
        Name: :App,
        ActionTypeId: {
          Category: :Source,
          Owner: :ThirdParty,
          Version: 1,
          Provider: :GitHub,
        },
        Configuration: {
          Owner:      Fn::ref(:ghowner),
          Repo:       Fn::ref(:ghrepo),
          Branch:     Fn::ref(:ghbranch),
          OAuthToken: Fn::ref(:ghtoken),
          PollForSourceChanges: false,
        },
        OutputArtifacts: [
          { Name: :App }
        ],
        RunOrder: 1,
      ]
    },
    {
      Name: :Build,
      Actions: [
        Name: :Build,
        ActionTypeId: {
          Category: :Build,
          Owner: :AWS,
          Version: 1,
          Provider: :CodeBuild,
        },
        Configuration: {
          ProjectName: Fn::ref(:CodeBuild)
        },
        InputArtifacts: [
          Name: :App
        ],
        OutputArtifacts: [
          Name: :Build
        ],
        RunOrder: 1,
      ]
    }
  ]
end
