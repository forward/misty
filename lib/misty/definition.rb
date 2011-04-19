module Misty
  class Definition
    def self.load_project(dir = Dir.pwd)
      project_file = File.join(dir, "Mistfile")
      return nil unless (File.exists?(project_file))

      mistfile = File.read(project_file)
      Misty::Definition.new(mistfile).evaluate
    end
    
    def initialize(file_contents)
      @file_contents = file_contents
    end
    
    def evaluate
      dsl = Misty::Dsl.new
      dsl.evaluate @file_contents
    end
  end
end