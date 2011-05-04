module Misty
  module CLI
    class Command
      include Misty::Config
  
      def initialize(project)
        @project = project
      end
      
      def check_formation(formation)
        raise Misty::CLI::Error.new("Formation '#{formation}' not known. Valid formations are [#{@project.formations.map{|k,v| k}.join(', ')}]") unless @project.formations.has_key? formation
      end
  
    end
  end
end