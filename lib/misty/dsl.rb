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
      def initialize
        @formations = {}
      end
      
      def project(name)
        @name = name
      end

      def region(name)
        @region = name
      end

      def key_pair(name)
        @key_pair = name
      end
      
      def formation(name, &block)
        f = Formation.new(name)
        f.instance_eval(&block)
        @formations[name] = f
      end

    end
    
    class Formation
      def initialize(name)
        @name = name
        @server_groups = {}
      end
      
      def server_group(name, &block)
        server_group = ServerGroup.new(name)
        server_group.instance_eval(&block)
        @server_groups[name] = server_group
      end
    end
    
    class ServerGroup
      def initialize(name)
        @name = name
        @instances = 1
        @size = "t1.micro"
      end
      
      def size(size)
        @size = size
      end
      
      def ami(ami)
        @ami = ami
      end
      
      def security_groups(*groups)
        @security_groups = groups
      end
      
      def instances(num)
        @instances = num
      end
    end
  end
  
  # class DslError
  #   
  # end
end