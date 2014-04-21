require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'
require 'notify_couriers_job'

include Clockwork

every(3.day, 'Queueing scheduled job for City A', :at => ['8:00','13:30','15:45']) { Delayed::Job.enqueue NotifyCouriersJob.new(ENV['CITY_A']) }
every(2.day, 'Queueing scheduled job for City B', :at => ['10:40','16:00']) { Delayed::Job.enqueue NotifyCouriersJob.new(ENV['CITY_B']) }
#every(1.minutes, 'Queueing interval job') { Delayed::Job.enqueue NotifyCouriersJob.new() }
