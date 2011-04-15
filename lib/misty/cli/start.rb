module Misty
  module Command    
    class Start
      include Config
            
      def run(args)
        profile, name = args
        p "start"
        p @config
        instances_for_env(profile, name)
      end
    end
  end
end