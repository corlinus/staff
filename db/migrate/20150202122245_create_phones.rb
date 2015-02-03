class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number, null: false
      t.belongs_to :employee, index: true
      t.timestamps null: false
    end
  end
end
