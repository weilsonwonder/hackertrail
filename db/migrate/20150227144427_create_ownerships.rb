class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
    	t.belongs_to :account
    	t.belongs_to :event
      t.timestamps
    end
  end
end
