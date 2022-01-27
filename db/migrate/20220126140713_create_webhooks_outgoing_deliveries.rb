class CreateWebhooksOutgoingDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks_outgoing_deliveries do |t|
      t.text :endpoint_url
      t.datetime :delivered_at
      t.integer :event_id
      t.integer :endpoint_id

      t.timestamps
    end
  end
end
