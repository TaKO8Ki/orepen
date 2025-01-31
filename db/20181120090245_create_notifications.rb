class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notified_by,index: true
      t.integer :article_id
      t.integer :comment_id
      t.string :notified_type
      t.boolean :read, default: false
      t.timestamps

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :notified_by_id
  end
end
