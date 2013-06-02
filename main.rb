=begin
nav:
- home
- movies
- stocks
- images

homepage
- brief para introducing user to site

movies
- form to enter movie name
- when submitted, use movies gem to find information
- show title, rating, director, some other info.
- use images gem to get a random image for the movie and show it also.
- Make sure if no movie found site works alright.

stocks
- form to enter stock symbol
- when submitted, display stock price (a.k.a. last-traded price) and other basic info
- Handle exception if invalid stock symbol entered

images
- form to enter keyword for image search
- when submitted, display the image.
- have a button on the page to automatically resubmit the same search
- have a button on the page to do a search for a random word (Make a list of 20+ words to choose the random search from)
=end

require "sinatra"
require "sinatra/reloader"
require "movies"
require "stock_quote"
require "image_suckr"

# homepage
get "/" do
  erb :index
end

# movies page
get "/movies" do
  if params["input_title"].nil?
    erb :movies
  else
    @results = Movies.find_by_title(params[:input_title])
    erb :movies
  end
end

# stocks page
get "/stocks" do
  if params["input_stock"].nil?
    erb :stocks
  else
     @stock = StockQuote::Stock.quote(params[:input_stock])
    erb :stocks
  end
end


# images page
get "/images" do
  if params["input_image"].nil?
    erb :images
  else
    begin
    suckr = ImageSuckr::GoogleSuckr.new
    @image = suckr.get_image_url({"q" => params[:input_image]})
    rescue "This is an error"
      erb :images
    end

  end
end






