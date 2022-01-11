class CreateSplutTables < ActiveRecord::Migration<%= migration_version %>
  def self.up
    ActiveRecord::Base.transaction do

      create_table :experiments do |t|
        t.string :name

        t.timestamps
      end

      create_table :variations do |t|
        t.integer :experiment_id
        t.string :name
        t.string :letter_designation
        t.integer :_impression_total, default: 0, null: false
        t.integer :_segmentation_total, default: 0, null: false
        t.integer :_impression_success, default: 0, null: false
        t.integer :_segmentation_success, default: 0, null: false

        t.timestamps
      end

      create_table :impressions do |t|
        t.integer :variation_id
        t.boolean :success
        t.datetime :success_at
        t.integer :splutable_id
        t.string :splutable_type
        t.integer :segment_participant_id

        t.timestamps
      end

      create_table :segment_participants do |t|
        t.integer :variation_id
        t.boolean :success
        t.datetime :success_at
        t.integer :splutable_id
        t.string :splutable_type

        t.timestamps
      end
    end
  end


  def self.down
    ActiveRecord::Base.transaction do
      drop_table :experiments
      drop_table :impressions
      drop_table :segment_participants
      drop_table :variations

    end
  end
end
