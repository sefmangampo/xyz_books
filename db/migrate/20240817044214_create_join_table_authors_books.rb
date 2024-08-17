class CreateJoinTableAuthorsBooks < ActiveRecord::Migration[7.2]
  def change
    create_join_table :authors, :books do |t|
      t.index :author_id
      t.index :book_id

      t.index [ :author_id, :book_id ], unique: true
    end
  end
end
