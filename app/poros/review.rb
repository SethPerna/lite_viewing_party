class Review
  attr_reader :name, :content
  def initialize(data)
    require "pry"; binding.pry
    @name = data[:name]
    @content = data[:content]
  end
end
