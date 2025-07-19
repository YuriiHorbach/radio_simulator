# usr/bin/env ruby
require 'byebug'

require_relative 'classes/radio'

radio = Radio.new

puts radio.status

radio.band = 'AM'
radio.frequency=1000
puts radio.status

radio.band = 'FM'
radio.frequency=100
radio.volume = 9
puts radio.status
puts '-' * 20
radio_am =  Radio.am
puts radio_am.status
puts '-' * 20
radio_fm = Radio.fm
puts radio_fm.status

