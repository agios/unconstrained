class ParentsWithChildren < ActiveRecord::Migration
  def change
    create_table :parents do |t|
    end
    create_table :children do |t|
      t.references :parent
    end
    add_foreign_key :children, :parents
  end
end
