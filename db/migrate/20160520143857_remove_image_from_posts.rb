class RemoveImageFromPosts < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :image, :string
  end
end
