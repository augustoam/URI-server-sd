class TimeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'time_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def estado(data)
    ActionCable.server.broadcast 'componente_channel', componente: data['componente']
  end
end
