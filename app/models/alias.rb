# Alias model.
class Alias < ActiveRecord::Base
  include Address

  belongs_to :domain

  default_scope -> { order 'username asc' }

  validates :goto, presence: true

  has_paper_trail

  searchkick word_middle: [:description, :username]
  # Search fields options includable in search on model.
  SEARCH_FIELDS = [
    { description: :word_middle },
    { username: :word_middle }
  ]

  # E-Mail address.
  def email
    [self.username, self.domain.name].join '@' rescue nil
  end

  # String representation.
  def to_s
    if domain
      if username
        email
      else
        "Catch-All for #{domain.name} to #{goto}"
      end
    else
      if username
        "#{username}@#{domain_id}"
      else
        "Catch-All for #{domain_id} to #{goto}"
      end
    end
  end
end
