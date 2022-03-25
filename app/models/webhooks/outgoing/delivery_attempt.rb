class Webhooks::Outgoing::DeliveryAttempt < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :delivery
  has_one :team, through: :delivery
  scope :successful, -> { where(response_code: 200) }

  before_create do
    self.attempt_number = delivery.attempt_count + 1
  end

  def still_attempting?
    error_message.nil? && response_code.nil?
  end

  def successful?
    [200, 201, 202, 203, 204, 205, 206, 207, 226].include?(response_code)
  end

  def failed?
    !(successful? || still_attempting?)
  end

  def attempt
    uri = URI.parse(delivery.endpoint_url)

    unless allowed_uri?(uri)
      self.response_code = 0
      self.error_message = "URI is not allowed: " + uri
      return false
    end

    http = Net::HTTP.new(resolve_ip_from_authoritative(uri.hostname.downcase), uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Post.new(uri.path)
    request.add_field("Content-Type", "application/json")
    request.add_field("Host", uri.host)
    request.body = delivery.event.payload.to_json

    begin
      response = http.request(request)
      self.response_message = response.message
      self.response_code = response.code
      self.response_body = response.body
    rescue Exception => exception
      self.response_code = 0
      self.error_message = exception.message
    end

    save
    successful?
  end

  def label_string
    "#{attempt_number.ordinalize} Attempt"
  end
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :response_code, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
