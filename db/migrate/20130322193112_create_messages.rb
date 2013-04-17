class CreateMessages < ActiveRecord::Migration
	def up
		create_table :messages do |t|
			t.string :sender_id,:null => false
			t.string :recipient_id
			t.boolean :sender_deleted, :recipient_deleted, :default => false
			t.string :subject,:null => false
			t.text :body
			t.datetime :read_at
			t.string :container,:default => "draft"
			t.timestamps
		end
	end

	def down
		drop_table :messages
	end
end