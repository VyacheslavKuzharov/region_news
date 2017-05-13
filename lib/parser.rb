Dir[Rails.root.join('lib', 'parser', '*.rb')].each { |file| require file}

module Parser

  def self.run
    Parser::MyTaganrogCom.new.parse


  end
end