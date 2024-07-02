class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.string :status

      t.timestamps
    end
  end
end
