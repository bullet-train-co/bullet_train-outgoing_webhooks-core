class Webhooks::Outgoing::Endpoint < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :team
  # 🚅 add belongs_to associations above.

  has_many :deliveries, class_name: "Webhooks::Outgoing::Delivery", dependent: :destroy, foreign_key: :endpoint_id
  has_many :endpoint_event_types, dependent: :destroy
  has_many :event_types, through: :endpoint_event_types
  has_many :events, -> { distinct }, through: :deliveries
  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def valid_event_types
    Webhooks::Outgoing::EventType.order(:name)
  end

  # 🚅 add methods above.
end
