
defmodule Receive do
  alias Image.Transformer
  require Logger
  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->


        try do
          path_original = "/tmp/#{UUID.uuid1()}.png"
          {:ok, payload} = JSON.decode(payload)
          Logger.debug("Processando image #{payload["image_name"]}")
          :ok = File.write(path_original, Base.decode64!(payload["image_source"]));

          Logger.debug("- Deixando a imagem em um tamanho padrão 500x300")
          {:ok, path_thumb} = Transformer.transform_thumb(path_original , "500x300")

          Logger.debug("- Procurando uma imagem para o background")
          {:ok, %{"urls" => %{"small" => url_backfround}}} = Transformer.search_random_image(Enum.random([
            "travel",
            "computer",
            "nature",
            "Wallpapers"
          ]))

          Logger.debug("- Fazendo o download da imagem do background")
          {:ok, path_background} = Transformer.download_image(url_backfround)
          Logger.debug("- Deixando a imagem background em um tamanho padrão")
          {:ok, path_background_thumb} = Transformer.transform_thumb(path_background, "700x500")
          Logger.debug("- Criando a primeira parte da montagem")
          {:ok, path_charge} = Transformer.add_background(path_thumb, path_background_thumb, Transformer.position_random())
          Logger.debug("- Criando a segunda parte da montagem")
          {:ok, path_charge_charge} = Transformer.transform_charge(path_charge)

          name = Path.basename(path_original);
          Logger.debug("- Enviando imagem para AWS S3")
          {:ok, url} = ClientAws.send_bucket(path_charge_charge, name)

          Logger.debug("- Registrando imagem na Gallery")
          ImageTreatment.ClientGallery.register_image(payload["gallery_id"], payload["image_name"], url)

          File.rm(path_background_thumb)
          File.rm(path_charge_charge)
          File.rm(path_background)
          File.rm(path_thumb)
          File.rm(path_charge)
          File.rm(path_original)
          AMQP.Basic.ack(channel, meta.delivery_tag)
          Logger.debug("- Imagem disponibilizada com sucesso #{url}")
        catch
          x ->
            IO.inspect(x)
            IO.puts " [x] Reject #{meta.delivery_tag} "
            AMQP.Basic.nack(channel, meta.delivery_tag, requeue: false)
        end

        wait_for_messages(channel)
    end
  end
end

{:ok, channel} = AMQP.Application.get_channel(:mychan)
# AMQP.Queue.declare(channel, "my-consumer")
AMQP.Basic.qos(channel, prefetch_count: 10)
AMQP.Basic.consume(channel, "image")
# AMQP.Basic.consume(channel, "teste", nil, no_ack: false)
IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"

Receive.wait_for_messages(channel)
