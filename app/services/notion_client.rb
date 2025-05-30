class NotionClient

  def self.fetch_all(user)
    client = Notion::Client.new(token: user.notion_api_key)
    sorts = [
      {
        'property': 'Date',
        'direction': 'ascending'
      }
    ]
    begin
      response = client.database_query(database_id: user.notion_database_id, sorts: sorts)
    rescue => e
      Rails.logger.error("Notionデータベースの取得に失敗しました: #{e.message}")
      return []
    end
    return response.results
  end
end