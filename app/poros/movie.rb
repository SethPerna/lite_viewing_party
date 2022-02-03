class Movie
  attr_reader :title, :vote_avg, :id

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_avg = data[:vote_average]
  end
end
