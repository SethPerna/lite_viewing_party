class MovieFacade
  def self.service
    MovieService.new
  end

  def self.cast(movie_id)
    service.get_cast(movie_id).map { |cast_mem| CastMember.new(cast_mem) }
  end
end
