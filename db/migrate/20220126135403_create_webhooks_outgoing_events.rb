# frozen_string_literal: true

class CreateWebhooksOutgoingEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks_outgoing_events do |t|
      t.integer :subject_id
      t.string :subject_type
      t.jsonb :data
      t.string :uuid
      t.jsonb :payload
      t.string :event_type_id
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
