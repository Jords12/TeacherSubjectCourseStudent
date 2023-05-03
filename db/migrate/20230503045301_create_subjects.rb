class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :section
      t.integer :number_of_units
      t.integer :per_unit_rate
      t.integer :number_of_students
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
