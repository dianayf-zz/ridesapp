class RidesApp < Sinatra::Application
  post "/rides/" do
    MultiJson.dump(Sport.all.map { |s| s.to_api })
  end

  put "/rides/:id" do
    sport = Ride.where(id: params[:id]).first
    MultiJson.dump(sport ? sport.to_api : {})
  end
end

