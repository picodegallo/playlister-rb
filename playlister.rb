require 'erb'
require_relative "lib/models/init_artist"
require_relative "lib/models/artist"
require_relative "lib/models/song"
require_relative "lib/models/genre"
require_relative "lib/models/parse"

class Playlister

  Artist.reset_artists
  Genre.reset_genres
  Song.reset_songs

  def initialize
    Parse.new.parse
  end

  def get_binding
    binding
  end

end


playlist = Playlister.new

####### INDEX PAGE ##########

template = ERB.new(File.read("lib/views/index.erb"))
html_content = template.result(playlist.get_binding)
File.open("index.html", "w") do |file|
  file.puts html_content
end

####### ARTIST PAGES #########

Artist.all.each do |artist|
  init_artist = InitArtist.new(artist)
  template = ERB.new(File.read("lib/views/artists.erb"))
  html_content = template.result(init_artist.get_binding)
  f = File.new("artists/#{artist.name.downcase}.html", "w")
  File.open(f, "w") do |file|
    file.puts html_content
  end
end

######### GENRES PAGE ##############
template = ERB.new(File.read("lib/views/genres.erb"))
html_content = template.result(playlist.get_binding)
File.open("genres.html", "w") do |file|
  file.puts html_content
end













