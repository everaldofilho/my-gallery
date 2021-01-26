defmodule ApiGalleryUpload.ClientQueue do

  def send(%{} = playload) do
    IO.inspect(playload)
    {:ok, result} = JSON.encode(playload)
    send(result)
  end

  def send(text_playload) do
    setup()
    {:ok, chan} = channel()
    AMQP.Basic.publish(chan, "ex.image", "", text_playload)
  end

  def setup() do
    {:ok, chan} = channel()
    # Create Exchanges
    AMQP.Exchange.declare(chan, "ex.image", :direct, [durable: true])
    AMQP.Exchange.declare(chan, "ex.image.dlq", :direct, [durable: true])

    # Create Queues
    AMQP.Queue.declare(chan, "image", [durable: true, arguments: [
      {"x-dead-letter-exchange", "ex.image.dlq"},
      {"x-queue-type", "classic"},
      # {"x-message-ttl", 60000},
    ]])

    AMQP.Queue.declare(chan, "image.dlq", [durable: true, arguments: [
      {"x-queue-type", "classic"},
    ]])

    # Bind Exchanges Queues
    AMQP.Queue.bind(chan, "image", "ex.image")
    AMQP.Queue.bind(chan, "image.dlq", "ex.image.dlq")

  end

  defp channel() do
    {:ok, chan} = AMQP.Application.get_channel(:mychan)
  end

end
