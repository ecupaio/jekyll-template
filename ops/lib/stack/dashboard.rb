module Stax
  class Dashboard < Stack

    no_commands do
      def cfn_parameters
        super.merge(
          branch: branch_name
        )
      end
    end

  end
end
