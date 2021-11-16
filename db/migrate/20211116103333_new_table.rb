class NewTable < ActiveRecord::Migration[6.1]
    def change
      create_table :users do |t|
        t.string :first_name
        t.string :last_name
        t.date :date_of_birth
        t.bigint :mobile_number
        t.string :email
        t.string :password

        t.timestamps
      end
    end
end
