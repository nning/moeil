# Alias model.
class Alias < ActiveRecord::Base

  include AddressValidations

  belongs_to :domain

  attr_accessible :active, :description, :domain_id, :goto, :username

  default_scope order('username asc')

  has_paper_trail

  validates :goto, presence: true

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
