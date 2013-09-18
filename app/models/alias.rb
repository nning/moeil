class Alias < ActiveRecord::Base

  belongs_to :domain

  attr_accessible :active, :description, :domain_id, :goto, :username

  default_scope order('username asc')

  has_paper_trail


  validates :username,
    presence: true,
    uniqueness: {
      scope: :domain_id,
      message: 'Combination of username and domain is not unique.'
    },
    format: {
      with: /\A[a-zA-Z0-9.\-_]+\z/,
      message: 'Username contains invalid characters.'
    },
    exclusion: {
      in: Settings.blocked_usernames,
      message: 'Username is blocked.'
    }

  validates :domain_id, presence: true
  validates :goto, presence: true


  def email
    [self.username, self.domain.name].join '@' rescue nil
  end

  def to_s
    username ? email : "Catch-All for #{domain.name} to #{goto}"
  end

end
