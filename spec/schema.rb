ActiveRecord::Schema.define :version => 0 do
  
	create_table :relationships, :force => true do |t|
		t.references :requestor, :polymorphic => true, :null => false
		t.references :requestee, :polymorphic => true, :null => false
		t.boolean :restricted, :default => true
		t.timestamps
	end
  
	create_table :friend_classes, :force => true do |t|
		t.timestamps
	end
  
	create_table :follower_classes, :force => true do |t|
		t.string :type
		t.integer :business_id # whatever - it works
		t.timestamps
	end
	
	create_table :both_classes, :force => true do |t|
		t.timestamps
	end
	
end