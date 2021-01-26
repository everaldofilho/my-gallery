defmodule Image.Transformer do

  def add_background(image_path, background_path, position \\ "Center") do
    path_destiny = "/tmp/#{UUID.uuid1()}.png"
    System.cmd("composite", [
      "-gravity",
      position,
      image_path,
      background_path,
      path_destiny
    ])

    {:ok, path_destiny}
  end
  def transform_charge(path_file) do
    images = Path.wildcard("/app/images/**")
    image_front = Enum.random(images)
    add_background(image_front, path_file, position_random())
  end

  def position_random() do
    Enum.random(["NorthWest", "North", "NorthEast", "West", "Center", "East", "SouthWest", "South", "SouthEast"])
  end

  def transform_thumb(original_file, size \\ "250x250") do

    # 1 get thumbnail file name
    thumb_path = generate_thumb_file(original_file)

    # 2 generate thumbnail by passing appropriate parameters
    System.cmd("convert", operation_commands(original_file, thumb_path, size))

    # 3 return the generated thumbnail
    {:ok, thumb_path}
  end

  def search_random_image(query) do
    url = "https://api.unsplash.com/photos/random?query=#{query}&client_id=edbe273ee10f354b5373c644bbc2a9afd7b24239f3cdae06bf784a4b65f1d18d"
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    {:ok, json} = JSON.decode(body)
  end

  def download_image(url) do
    uuid = UUID.uuid1()
    filename = "#{uuid}.png"
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)

    File.write!("/tmp/#{filename}", body)
    {:ok, "/tmp/#{filename}"}
  end

  defp generate_thumb_file(original_file) do
    extension = Path.extname(original_file)

    original_file
    |> String.replace(extension, "_thumb#{extension}")
  end

  defp operation_commands(original_file_path, thumb_path, size \\ "250x90") do
    [
      "-define",
      "jpeg:size=500x180",
      original_file_path,
      "-auto-orient",
      "-thumbnail",
      size,
      "-unsharp",
      "0x.5",
      thumb_path
    ]
  end
end
