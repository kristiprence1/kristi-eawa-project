class CreateJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :journals do |t|
      t.string :title
      t.integer :volume
      t.integer :issue
      t.string :language
      t.integer :publish_year
      t.string :publisher
      t.integer :categories
      t.text :description

      t.timestamps
    end
  end
end
