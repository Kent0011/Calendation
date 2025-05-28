class Event
  attr_accessor :name, :start_datetime, :end_datetime, :category, :url

  def initialize(name:, start_datetime:, end_datetime:, category:, url:)
    @name = name
    @start_datetime = start_datetime 
    @end_datetime = end_datetime
    @category = category
    @url = url
  end
end
