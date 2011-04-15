module Misty
  class Definition
    def initialize(file_contents)
      @file_contents = file_contents
    end
    
    def evaluate
      dsl = Misty::Dsl.new
      dsl.evaluate @file_contents
    end
  end
end