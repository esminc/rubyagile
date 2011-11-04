class Date
  private
  def feed_utils_to_time(dest, method)
    Time.send(method, dest.year, dest.month, dest.day, dest.hour, dest.min, dest.sec, dest.zone)
  end
end
