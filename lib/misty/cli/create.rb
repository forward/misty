module Misty
  module CLI    
    class Create
      def run(args)
        mistfile = File.read(File.join(Dir.pwd, "Mistfile"))
        
        definition = Misty::Definition.new(mistfile)
        project = definition.evaluate
        template = Misty::Template.new project
        
        p template.generate(args[0].to_sym).to_json
      end
    end
  end
end