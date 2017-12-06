class TimeController < ApplicationController
  def atualiza_time
    # debugger
    uri = URI('http:/localhost:3030/time/get_time')
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end


    def get_time
      render json: Timer.where(cliente: 'server').last.time
    end
end
