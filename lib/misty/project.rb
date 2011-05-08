module Misty
  
  class Project
    attr_accessor :name, :region, :key_pair, :formations
        
    def initialize
      @formations = {}
    end    
    
    def stack_name(formation)
      @formations[formation.to_sym].stack_name
    end
    
    def stack_names
      @formations.map{|k,v| v.stack_name }
    end
    
  end
  
  class Formation
    attr_reader :name
    attr_accessor :server_groups
    
    def initialize(name, project)
      @name, @project = name, project
      @server_groups = {}
    end
    
    def stack_name
      "#{@project.name}-#{@name}-stack"
    end
  end
  
  class ServerGroup
    attr_accessor :instances, :size, :ami, :security_groups, :roles
    attr_reader :name
    
    def initialize(name, formation)
      @name, @formation = name, formation
      @instances = 1
      @size = "t1.micro"
    end
    
    def roles
      return @roles if @roles
      
      return [@name]
    end
  end
  
end