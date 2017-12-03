class HomeController < ApplicationController
  require 'net/http'

  def index
    # debugger
    uri_one = URI('http://localhost:3030/time/get_time')
    res = Net::HTTP.get_response(uri_one)
    time = JSON.parse(res.body)
    Timer.create(cliente: 'one', time: time['time'])

    uri = URI('http://localhost:3040/time/get_time')
    res = Net::HTTP.get_response(uri)
    time = JSON.parse(res.body)
    Timer.create(cliente: 'two', time: time['time'])

    time_one = Timer.where(cliente: 'one').last
    time_two = Timer.where(cliente: 'two').last

    time_one_s = (time_one.time.time.hour * 3600) + (time_one.time.time.min * 60) + time_one.time.time.sec
    time_two_s = (time_two.time.time.hour * 3600) + (time_two.time.time.min * 60) + time_two.time.time.sec
    media = (time_one_s + time_two_s) / 2
    puts media

    time_new = Time.at(media).utc.strftime('%H:%M:%S')
    puts time_new

    uri_one_set = URI('http://localhost:3030/time/set_time')
    uri_two_set = URI('http://localhost:3040/time/set_time')
    params_one = { time: time_new }
    res = Net::HTTP.post_form(uri_one_set, params_one)
    res = Net::HTTP.post_form(uri_two_set, params_one)
    puts res
  end
end
