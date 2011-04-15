module Misty
  class Dsl

    def initialize
      @project = Project.new
    end

    def evaluate(str)
      @project.instance_eval str
      @project
    end

    class Project
      def project(name)
        @name = name
      end

      def region(name)
        @region = name
      end

      def key_pair(name)
        @key_pair = name
      end
    end
    
    # class Formation
    #   def server_group(&block)
    #   end
    # end
    # 
    # class ServerGroup
    #   def size(size)
    #     
    #   end
    # end
  end
  
  class DslError
    
  end
end