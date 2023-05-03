class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :year_level
      t.integer :number_of_units
      t.float :total_assessment

      t.timestamps
    end
  end
end
