class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :username,                        null: false
      t.string 	 :email,            			      null: false
      t.string 	 :crypted_password,  			      null: false
      t.string 	 :salt,			  			   	        null: false
      t.string 	 :remember_me_token 			      
      t.datetime :remember_me_token_expires_at 
      t.string 	 :activation_state,            	default: "pending"
	    t.string   :activation_token             
	    t.datetime :activation_token_expires_at  
      t.string   :reset_password_token
      t.datetime :reset_password_token_expires_at
      t.datetime :reset_password_email_sent_at
    end
    
    add_index :users, :email, unique: true
    add_index :users, :remember_me_token
    add_index :users, :activation_token
    add_index :users, :reset_password_token
  end
end