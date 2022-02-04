class MovieDetail
  attr_reader :title,
              :vote_avg,
              :runtime,
              :genre,
              :summary,
              :id
  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_avg = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genres]
    @summary = data[:overview]
  end
end
