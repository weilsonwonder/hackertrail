class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
    	t.text :name
    	t.text :ttype
    	t.belongs_to :account
      t.timestamps
    end
  end
end
