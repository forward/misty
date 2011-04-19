module Misty
  module CLI::Commands    
    class Help < Misty::CLI::Command      
      def run(args)
        puts "Commands: -"
        
        Misty::CLI::Commands.constants.each do |const|
          clazz = Misty::CLI::Commands.const_get(const)
          # puts "yeay"
          # if (clazz.kind_of?(Misty::CLI::Command))
            puts "\t#{command_name(clazz)} - #{clazz.description}"
          # end
        end
        
      end
      
      def command_name(clazz)
        clazz.name.gsub(/Misty::CLI::Commands::/, '').downcase
      end
      
      def self.description
        "Usage 'misty help'"
      end
      
    end
  end
end