class MovieDetail
  attr_reader :title,
              :vote_avg,
              :runtime,
              :genre,
              :summary,
              :id,
              :poster

  def initialize(data)
    @poster = data[:poster_path]
    @id = data[:id]
    @title = data[:title]
    @vote_avg = data[:vote_average]
    @runtime = data[:runtime]
    @genre = data[:genres]
    @summary = data[:overview]
  end
end
