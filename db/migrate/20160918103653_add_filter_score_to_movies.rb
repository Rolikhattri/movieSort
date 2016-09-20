class AddFilterScoreToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :filter_score, :integer, :default => 0
  end
end
