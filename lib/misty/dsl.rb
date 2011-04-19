module Misty
  class Dsl

    def initialize
      @dsl = ProjectDsl.new
    end

    def evaluate(str)
      @dsl.instance_eval str
      @dsl.instance_variable_get(:@project)
    end

    class ProjectDsl      
      def initialize
        @project = Project.new
      end
      
      def project(name)
        @project.name = name
      end

      def region(name)
        @project.region = name
      end

      def key_pair(name)
        @project.key_pair = name
      end
      
      def formation(name, &block)
        dsl = FormationDsl.new(name, @project)
        dsl.instance_eval(&block)
        @project.formations[name] = dsl.instance_variable_get(:@formation)
      end

    end
    
    class FormationDsl      
      def initialize(name, project)
        @formation = Formation.new(name, project)
      end
      
      def server_group(name, &block)
        dsl = ServerGroupDsl.new(name, @formation)
        dsl.instance_eval(&block)
        @formation.server_groups[name] = dsl.instance_variable_get(:@server_group)
      end
    end
    
    class ServerGroupDsl
      def initialize(name, formation)
        @server_group = ServerGroup.new(name, formation)
      end
      
      def size(size)
        @server_group.size = size
      end
      
      def ami(ami)
        @server_group.ami = ami
      end
      
      def security_groups(*groups)
        @server_group.security_groups = groups
      end
      
      def instances(num)
        @server_group.instances = num
      end
    end
  end
  
end