class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
    	t.text :privacy_type
    	t.belongs_to :account
    	t.belongs_to :event
      t.timestamps
    end
  end
end
