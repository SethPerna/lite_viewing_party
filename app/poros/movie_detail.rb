class MovieDetail
  attr_reader :title,
              :vote_avg,
              :runtime,
              :genre,
              :summary
  def initialize(data)
    @title = data[:title]
    @vote_avg = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genres]
    @summary = data[:overview]
  end
end
