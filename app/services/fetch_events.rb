class FetchEvents

  # @param [User] user
  # @return [EventList]
  def self.event_list(user)
    events = NotionClient.fetch_all(user).map do |page|
      Event.new(name: page.properties.Title.title.first.text.content, start_datetime: page.properties.Date.date.start, end_datetime: page.properties.Date.date.end, category: page.properties.Category[:select][:color], url: page.url)
    end
    return EventList.new(events)
  end
end