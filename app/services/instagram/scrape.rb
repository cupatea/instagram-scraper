class Instagram::Scrape < ApplicationService

  required do
    string :username
  end

  optional do
    string :resource_url, default: 'https://www.instagram.com'
  end

  def execute
    prepare_basic_info
  rescue ServiceError => e
    service_log status: :failure, message: "#{self.class.name} has errors: #{@errors.try(:message)}"
    service_backtrace e
  end

  private

  def prepare_basic_info
    html_page       = _get_html_page(url: "#{resource_url}/#{username}")
    element         = _find_element(html_page: html_page)
    parsed_element  = _parse_element(element: element)
    graph_element   = parsed_element["entry_data"]["ProfilePage"].first["graphql"]

    OpenStruct.new(
      user: _prepare_user(user: graph_element["user"]),
      content: _prepare_content(content: graph_element["user"]["edge_owner_to_timeline_media"])
    )
  end

  # Below are helper methods

  def _get_html_page url:
    HTTParty.get(url).body
  rescue => e
    service_method_raise_error(error: e)
  end

  def _find_element html_page:, xpath: '/html/body/script[1]'
    Nokogiri(html_page).xpath(xpath).children.first.text[/({.+})/, 1]
  rescue => e
    service_method_raise_error(error: e)
  end

  def _parse_element element:
    JSON.parse(element)
  rescue => e
    service_method_raise_error(error: e)
  end

  def _prepare_user user:
    { id: user['id'],
      user_name: user['username'],
      full_name: user['full_name'],
      followers_count: user['edge_followed_by']['count'],
      following_count: user['edge_follow']['count'],
      biography: user['biography'],
      externale_url: user['external_url'],
      is_private: user['is_private'],
      is_verified: user['is_verified'],
      profile_pic_url: user['profile_pic_url'],
      profile_pic_url_hd: user['profile_pic_url_hd'] }
  rescue => e
    service_method_raise_error(error: e)
  end

  def _prepare_content content:
    { count: content['count'],
      has_next_page: content['has_next_page'],
      content: content['edges'] }
  rescue => e
    service_method_raise_error(error: e)
  end
end
