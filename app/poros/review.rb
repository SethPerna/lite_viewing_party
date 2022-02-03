class Review
  attr_reader :username, :content
  def initialize(data)
    @username = data[:author_details][:username]
    @content = data[:content]
  end
end
