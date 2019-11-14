class AddPointsAndTrendingToLink < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :points, :integer, default: 1
    add_column :links, :trending, :float, default: 0
  end
end
