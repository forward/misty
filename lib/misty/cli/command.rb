module Misty
  module CLI
    class Command
      include Misty::Config
  
      def initialize(project)
        @project = project
      end
  
    end
  end
end