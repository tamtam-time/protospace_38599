class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user_id, null: false, foreign_key: true
      t.references :prototype_id, null: false, foreign_key: true
      t.text :text
      t.timestamps
    end
  end
end
