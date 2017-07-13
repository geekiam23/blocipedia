class AddUserIdToWikis < ActiveRecord::Migration
  def change
    add_reference :wikis, :user, index: true, foreign_key: true
  end
end
