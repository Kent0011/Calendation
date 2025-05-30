class EventList
  include Enumerable

  def initialize(events)
    @events = events
  end

  def each(&block)
    @events.each(&block)
  end

  def size
    @events.size
  end
end
