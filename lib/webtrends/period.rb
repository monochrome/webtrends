# WebTrends Period Regular Expressions
DAY_RE = /(\d{4})m(\d{2})d(\d{2})/
WEEK_RE = /(\d{4})w(\d{2})/
MONTH_RE = /(\d{4})m(\d{2}$)/

def convert_period_to_wt_format(period)
  if is_day_label?(period)
    "#{'%02d' %DAY_RE.match(period)[2].to_i}/#{'%02d' %DAY_RE.match(period)[3].to_i}/#{DAY_RE.match(period)[1]}"
  elsif is_week_label?(period)
    period
  elsif is_month_label?(period)
    "#{'%02d' %MONTH_RE.match(period)[2]}/#{MONTH_RE.match(period)[1]}"
  end
end

def subtract_period(period,count)
  if is_day_label?(period)
    # Convert period to actual date object
    period_date = Date.civil(y=DAY_RE.match(period)[1].to_i,m=DAY_RE.match(period)[2].to_i,d=DAY_RE.match(period)[3].to_i)
    # subtract 1 day
    previous_period_date = period_date - count.day
    # return a period label
    return "#{convert_date_to_day_period_label(previous_period_date)}"
  elsif is_week_label?(period)
    # Convert period to actual date object and subtract 1 week
    period_date = Date.commercial(y=WEEK_RE.match(period)[1].to_i,w=WEEK_RE.match(period)[2].to_i)
    # subtract 1 week
    previous_period_date = period_date - count.week
    # return a period label
    return "#{convert_date_to_week_period_label(previous_period_date)}"
  elsif is_month_label?(period)
    # Convert period to actual date object
    period_date = Date.civil(y=MONTH_RE.match(period)[1].to_i,m=MONTH_RE.match(period)[2].to_i)
    # subtract 1 month
    previous_period_date = period_date - count.month
    # return a period label
    return "#{convert_date_to_month_period_label(previous_period_date)}"
  end
end

def previous_period_label(period)    
  return "#{subtract_period(period,1)}"
end

def current_period(period,type)

end

def convert_date_to_day_period_label(date)
  "#{date.year}m#{'%02d' % (date.strftime("%m").to_i)}d#{'%02d' % (date.strftime("%d").to_i)}"
end

def convert_date_to_week_period_label(date)
  "#{date.year}w#{'%02d' % (date.strftime("%U").to_i)}"
end

def convert_date_to_month_period_label(date)
  "#{date.year}m#{'%02d' % (date.strftime("%m").to_i)}"
end  

def is_month_label?(period)
  !MONTH_RE.match(period).nil?
end

def is_week_label?(period)
  !WEEK_RE.match(period).nil?
end

def is_day_label?(period)
  !DAY_RE.match(period).nil?
end