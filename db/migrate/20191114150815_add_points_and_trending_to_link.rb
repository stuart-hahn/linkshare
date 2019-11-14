class AddPointsAndTrendingToLink < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :points, :integer
    add_column :links, :trending, :float
  end
end
