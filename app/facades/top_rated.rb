class TopRated
  def service
    MovieService.new
  end 

  def movies
    service.top_rated.map { |data| Movie.new(data) }
  end
end
