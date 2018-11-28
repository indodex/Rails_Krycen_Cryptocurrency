class ZendeskClient < ZendeskAPI::Client
  def self.instance
    @instance ||= new do |config|
      config.url = ENV['ZD_URL']
      config.username = ENV['ZD_USER']
      config.token = ENV['ZD_TOKEN']

      config.retry = true

      config.logger = Rails.logger
    end
  end

  def tickets(email)
    search(:query => "requester:#{email}", :sort_by => "created_at", :sort_order => "DESC", :reload => true)
  end
end