class UpdateCastType < ActiveRecord::Migration
  def change
  	rename_column :movies, :cast, :cast_members
  end
end
