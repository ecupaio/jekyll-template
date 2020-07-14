module Stax
  class Build < Stack
    include S3, Logs, Codebuild, Codepipeline

    no_commands do
      def cfn_parameters
        super.merge(
          branch:   branch_name,
          ghbranch: Git.branch,
          ssmenv:   ssm_environment,
          cfid:     cloudfront_distribution_id,
        )
      end

      def cloudfront_distribution_id
        if stack(:cdn).exists?
          stack(:cdn).stack_output(:Distribution)
        else
          ''
        end
      end
    end
  end
end
