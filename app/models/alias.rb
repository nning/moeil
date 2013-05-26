class Alias < ActiveRecord::Base

  belongs_to :domain

  attr_accessible :active, :domain_id, :goto, :username

  default_scope order('username asc')


  validates :username,
    presence: true,
    uniqueness: {
      scope: :domain_id,
      message: 'Combination of username and domain is not unique.'
    },
    format: {
      with: /^[a-zA-Z0-9.\-_]+$/,
      message: 'Username contains invalid characters.'
    },
    exclusion: {
      in: Settings.blocked_usernames,
      message: 'Username is blocked.'
    }

  validates :domain_id, presence: true


  def email
    [self.username, self.domain.name].join '@' rescue nil
  end

end
