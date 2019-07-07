class CreateObservations < ActiveRecord::Migration[6.0]
  def change
    create_table :observations do |t|
      t.integer :observer_id
      t.string  :observer_type

      t.integer :observee_id
      t.string  :observee_type

      t.timestamps
    end
    add_index :observations, [:observer_type, :observee_type, :observer_id, :observee_id],
              name: :index_observations_on_observer_and_obsorvee_type_and_id
  end
end
