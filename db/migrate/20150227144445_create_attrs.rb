class CreateAttrs < ActiveRecord::Migration
  def change
    create_table :attrs do |t|
    	t.text :name
    	t.text :value
    	t.integer :position
    	t.belongs_to :event
    	t.belongs_to :template
      t.timestamps
    end
  end
end
