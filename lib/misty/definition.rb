module Misty
  class Definition
    def initialize(suefile_contents)
      @suefile_contents = suefile_contents
    end
    
    def evaluate
      dsl = Misty::Dsl.new
      dsl.evaluate @suefile_contents
    end
  end
end