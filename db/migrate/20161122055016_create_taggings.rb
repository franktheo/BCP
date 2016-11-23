class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.string :entity_type
      t.string :entity_id
      t.text :tags, array: true, default: []
      t.timestamps
    end
  end
end
