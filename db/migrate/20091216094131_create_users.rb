class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :language
      t.string :identity_url
      t.string :oauth_token
      t.string :oauth_secret
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
