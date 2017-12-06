class HomeController < ApplicationController
  include MqttBroker

  def index
    time_one = Timer.where(cliente: 'one').last
    time_two = Timer.where(cliente: 'two').last

    # Transforma horario em segundos para poder calcular média
    time_one_s = (time_one.time.time.hour * 3600) + (time_one.time.time.min * 60) + time_one.time.time.sec
    time_two_s = (time_two.time.time.hour * 3600) + (time_two.time.time.min * 60) + time_two.time.time.sec
    media = (time_one_s + time_two_s) / 2
    puts media

    # Transforma média em horario padrão
    new_time = Time.at(media).utc.strftime('%H:%M:%S')
    puts new_time

    Timer.create!(cliente: 'server', time: new_time)

    # Publica no topico o novo time
    publish_mqtt('uri/sistemas-distribuidos/new-time', new_time)
  end

end
