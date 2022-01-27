# frozen_string_literal: true

class CreateWebhooksOutgoingEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks_outgoing_endpoints do |t|
      t.text :url
      t.string :name
      t.jsonb :event_type_ids, default: []
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
