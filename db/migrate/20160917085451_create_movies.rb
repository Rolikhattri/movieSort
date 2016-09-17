class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.text :cast
      t.string :genres
      t.string :languages
      t.string :company
      t.float :rating
      t.integer :year
      t.integer :votes
      t.text :summary
      t.string :imdb_id
      t.string :imdb_url

      t.timestamps null: false
    end
  end
end
