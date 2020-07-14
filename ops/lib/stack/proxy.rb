module Stax
  class Proxy < Stack
    include Alb, Ecs, Logs

    no_commands do
      def cfn_parameters
        super.merge(
          desired: @desired || '',
          CanonicalUser: canonical_user_id || '',
        )
      end

      ## for s3 policy: get from cdn if that stack exists
      def canonical_user_id
        stack(:cdn).exists? && stack(:cdn).stack_output(:CanonicalUserId)
      end
    end

    ## creation requires desired_count, update can and should skip it
    desc 'create', 'create stack'
    def create
      @desired = '1'
      super
    end

  end
end
