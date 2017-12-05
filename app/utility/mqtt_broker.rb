module MqttBroker
  require 'rubygems'
  require 'mqtt'

  def publish_mqtt(topico, time)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |client|
      client.publish(topico, time)
    end
  end
end
