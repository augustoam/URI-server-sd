class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*_args)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |_client|
      # If you pass a block to the get method, then it will loop
      _client.get('uri/sistemas-distribuidos/time') do |topic, message|
        # Realiza um subscribe no tópico comum, e a cada menssagem postada pelos clientes
        # Insere um novo registro n a tabela Timer, com o cliente e seu horario
        puts "#{topic}: #{message}"
        m = message.split
        Timer.create!(cliente: m[0], time: m[1])
      end
    end
  end
end
