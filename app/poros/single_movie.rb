class SingleMovie
  def service
    MovieService.new
  end

  def search(movie_id)
    MovieDetail.new(service.movie_details(movie_id))
  end
end
