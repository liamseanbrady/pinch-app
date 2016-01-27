class ShowTimestamp
  def initialize(app, message)
    @app = app
    @message = message
  end

  def call(env)
    status, headers, response = @app.call(env)

    # Very Rails specific, but it will do for just now
    if headers['Content-Type'] && headers['Content-Type'].split(';').first == 'text/html'
      response.body = "<!-- The request was processed at #{@message} -->" + response.body
    end

    [status, headers, response]
  end
end
