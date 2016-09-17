namespace :populate_db do
  desc "TODO"
  task movies: :environment do
    list = Imdb::Top250.new.movies
    list.each_with_index { |movie, index| 
      if index%2 != 0
        Movie.create(:title => movie.title, :director => movie.director.join(","), :cast => movie.cast_members.join(","), :genres => movie.genres.join(","), :languages => movie.languages.join(","), :company => movie.company, :rating => movie.rating, :year => movie.year, :votes => movie.votes, :summary => movie.plot_summary, :imdb_id => movie.id, :imdb_url => movie.url)
      end
    }
  end

  desc "TODO"
  task genre: :environment do
    list = Movie.all.collect{|movie| movie.genres.split(",")}.flatten.uniq
    list.each_with_index { |genre, index|
      Genre.create(:name => genre)
    }
  end

  desc "TODO"
  task language: :environment do
    list = Movie.all.collect{|movie| movie.languages.split(",")}.flatten.uniq
    list.each_with_index { |language, index|
      Language.create(:name => language)
    }
  end

  desc "TODO"
  task company: :environment do
    list = Movie.all.collect{|movie| movie.company}.flatten.uniq
    list.each_with_index { |company, index|
      Company.create(:name => company)
    }
  end

end
