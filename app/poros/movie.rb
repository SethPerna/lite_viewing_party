class Movie
  attr_reader :title, :vote_avg

  def initialize(data)
    @title = data[:title]
    @vote_avg = data[:vote_average]
  end
end
