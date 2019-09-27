class Instagram::SendMessage < ApplicationService
  required do
    string :username
    string :message
  end

  def execute
    visit_login_page
    enter_credentials
    subscribe_to_user
    visit_direct_messages
    send_message
  rescue ServiceError => e
    service_log status: :failure, message: "#{self.class.name} has errors: #{@errors.try(:message)}"
    service_backtrace e
  ensure
    _browser.reset!
  end

  private

  def visit_login_page
    _browser.visit _login_page_url
    _browser.assert_current_path(_login_page_url)
  rescue
    add_error __method__.to_sym, :failed, "Expected url to be #{_login_page_url}"\
                                          "but url insted #{_browser.current_url}"
    raise ServiceError
  end

  def enter_credentials
    _browser.fill_in 'username', with: Rails.application.credentials.instagram_username
    _browser.fill_in 'password', with: Rails.application.credentials.instagram_password
    _browser.find('button[type="submit"]').click
    _browser.click_on(_ok_text) if _ok_button?
    _browser.click_on(_save_info) if _save_info_button?
    _browser.assert_selector('span[aria-label="Direct"]')
  rescue
    add_error __method__.to_sym, :failed, "Cant find direct messeges element "\
                                          "on the page #{_browser.current_url}"
    raise ServiceError
  end

  def subscribe_to_user
    _browser.visit _user_page_url
    return if _user_is_followed?

    unless _browser.click_on(_follow_text) && _browser.send(:sleep, 2) && _browser.assert_text(_message_text)
      add_error __method__.to_sym, :failed, "Can't find `#{_message_text}` text on the page #{_browser.current_url}"
      raise ServiceError
    end
  end

  def visit_direct_messages
    _browser.visit _user_page_url
    _browser.click_on(_message_text)
    _browser.assert_selector("textarea")
  rescue
    add_error __method__.to_sym, :failed, "Cant find `#{_message_text}` text on the page #{_browser.current_url}"
    raise ServiceError
  end

  def send_message
    _browser.find("textarea")
            .set(message)
            .send_keys(:space)
            .send_keys(:backspace)
    _browser.send(:sleep, 2)
    _browser.find('textarea', text: message)
    _browser.find('button', text: _send_text).click
    _browser.send(:sleep, 2)
    _browser.find('textarea', text: '')
    _browser.visit _user_page_url
  rescue
    add_error __method__.to_sym, :failed, "Cant find message text after pressing enter "\
                                          "on the page #{_browser.current_url}"
    raise ServiceError
  end

  def _browser
    return @_browser if @_browser

    Capybara.register_driver :context_selenium_chrome do |app|
      chrome_args = %w[headless disable-gpu no-sandbox disable-dev-shm-usage]

      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        'goog:chromeOptions': { args: chrome_args,
                                mobileEmulation: { "deviceName": "Pixel 2" } }
      )
      Capybara::Selenium::Driver.new app,
                                     browser: :chrome,
                                     desired_capabilities: capabilities
    end
    Capybara.default_driver    = :context_selenium_chrome
    Capybara.javascript_driver = :context_selenium_chrome
    Capybara.enable_aria_label = true

    @_browser = Capybara.current_session
  end

  def _home_page_url
    "https://www.instagram.com/?hl=en"
  end

  def _user_page_url
    "https://www.instagram.com/#{username}?hl=en"
  end

  def _login_page_url
    "https://www.instagram.com/accounts/login/?hl=en"
  end

  def _follow_text
    'Follow'
  end

  def _message_text
    'Message'
  end

  def _send_text
    'Send'
  end

  def _ok_text
    'OK'
  end

  def _save_info
    'Save Info'
  end

  def _user_is_followed?
    _browser.find('button', text: _message_text)
  rescue
    false
  end

  def _save_info_button?
    _browser.find('button', text: _save_info)
  rescue
    false
  end

  def _ok_button?
    _browser.find('button', text: _ok_text)
  rescue
    false
  end
end
