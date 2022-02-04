class SearchMovie
  def service
    MovieService.new
  end

  def search(movie)
    service.search_movie(movie).map { |data| Movie.new(data) }
  end
end
