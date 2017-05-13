require 'parser'

namespace :jobs do

  task parse_news: :environment do
    p 'start'
    Parser.run
    p 'done'
  end
end
