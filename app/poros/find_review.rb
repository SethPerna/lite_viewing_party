class FindReview
  def service
    MovieService.new
  end

  def search(movie_id)
    service.get_reviews(movie_id).map { |data| Review.new(data) }
  end
end
