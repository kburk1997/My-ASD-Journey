json.array!(@simulations) do |simulation|
  json.extract! simulation, :id, :title, :short_name, :image, :instructions, :long_desc
  json.url simulation_url(simulation, format: :json)
end
