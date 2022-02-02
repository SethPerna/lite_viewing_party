class MovieService
  def get_url(url, param = nil)
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params[:api_key] = ENV['movie_api_key']
      faraday.params[:query] = param unless param.nil?
    end

    response = conn.get(url)

    data = JSON.parse(response.body, symbolize_names: true)
  end 

  def top_rated
    get_url('3/movie/top_rated')[:results]
  end

  def search_movie(movie)
    get_url('3/search/movie', movie)[:results]
  end
end
