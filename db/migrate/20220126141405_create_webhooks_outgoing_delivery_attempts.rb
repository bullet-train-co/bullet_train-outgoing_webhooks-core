class CreateWebhooksOutgoingDeliveryAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks_outgoing_delivery_attempts do |t|
      t.integer :response_code
      t.text :response_body
      t.text :response_message
      t.text :error_message
      t.integer :attempt_number
      t.integer :delivery_id

      t.timestamps
    end
  end
end
