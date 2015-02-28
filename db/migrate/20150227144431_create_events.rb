class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.text :ttype
    	t.text :privacy_type
    	t.integer :capacity
    	t.datetime :start_date
    	t.datetime :end_date
      t.timestamps
    end
  end
end
