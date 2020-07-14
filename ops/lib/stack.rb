## Monkey-patches you may make to change stack behavior.
## Changing these here will affect all stacks.
## You may also define these per-stack in the sub-class for each stack in lib/stacks/.

module Stax
  class Stack < Base

    no_commands do
      def cfn_tags
        {
          'ap:app': :peacock,
          'ap:branch': branch_name,
          'ap:repo': :website,
          'ap:branch:base64': Base64.strict_encode64(Git.branch),
        }
      end

      def ssm_environment
        if Git.branch == 'master'
          @_ssm_environment ||= 'production'
        elsif Git.branch == 'staging'
          @_ssm_environment ||= 'staging'
        else
          @_ssm_environment ||= 'dev'
        end
      end
    end

  end
end
