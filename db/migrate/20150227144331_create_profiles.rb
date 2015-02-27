class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.text :name
    	t.belongs_to :account
      t.timestamps
    end
  end
end
