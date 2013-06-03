class SmsApi
  API_URL = "smsc.ru"
  API_PATH = "/sys/get.php"
  API_URL_ACTIONS = {
    :inbox => "get_answers=1"
  }

  def initialize(login, password)
    @login, @password = login, password
  end

  def get_sms_list
    clean_result http_api_call
  end

  private

  def clean_result(result)
    JSON.parse(result.body.gsub!("\n", ""))
  end

  def http_api_call
    http = Net::HTTP.new(API_URL, 80)
    http.use_ssl = false
    http.post(API_PATH, request_string, headers)
  end

  def headers
    {}
  end

  def data_hash
    {
      :action => API_URL_ACTIONS[:inbox],
      :login => @login,
      :password => @password
    }
  end

  def request_string
    "#{data_hash[:action]}&login=#{data_hash[:login]}&psw=#{data_hash[:password]}&fmt=3&charset=utf-8"
  end

end
