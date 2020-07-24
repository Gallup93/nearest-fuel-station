class SearchController < ApplicationController
  def index
    #refactor API calls into their own service files. 
    conn = Faraday.new(url: "https://developer.nrel.gov")
    response = conn.get("/api/alt-fuel-stations/v1/nearest.json?limit=1&api_key=#{ENV["DEVELOPER_NETWORK_KEY"]}&location=#{params[:location]}")
    @station = JSON.parse(response.body, symbolize_names: true)[:fuel_stations][0]

    address = @station[:street_address]+"+"+@station[:city]+"+"+@station[:state]+"+"+@station[:zip]

    conn2 = Faraday.new(url: "https://www.mapquestapi.com")
    response2 = conn2.get("/directions/v2/route?key=#{ENV["MAP_QUEST_KEY"]}&from=#{params[:location]}&to=#{address}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
    @json = JSON.parse(response2.body, symbolize_names: true)
  end
end
