class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :language
      t.string :publisher
      t.integer :publish_year
      t.text :description
      t.integer :categories

      t.timestamps
    end
  end
end
