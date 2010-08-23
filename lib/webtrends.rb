require 'webtrends/wtgateway'
require 'webtrends/period'

class Webtrends < ActiveRecord::Base
  
  def self.get(period)
    record = self.find_by_period_label(period)
    record.nil? ? get_new_period_from_api(period) : record
  end
  
  def self.get_from_db(period)
    self.find_by_period_label(period)
  end
  
end