namespace :games do
  desc "Inactive games with time and date passed"
  task :inactive_games => :environment do
    games = Game.current_games
    games.each do |game|
      if Time.now > game.game_date
        game.inactive!
      end
    end
  end
end
