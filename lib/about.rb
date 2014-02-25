module About
  # Ruby platform.
  def self.ruby
    RUBY_DESCRIPTION
  end

  # Change time of Rails root.
  def self.last_deploy
    File.ctime Rails.root
  end
end
