class Domain < ActiveRecord::Base

  has_many :aliases
  has_many :mailboxes

  attr_accessible :active, :backupmx, :description, :name

  default_scope order('name asc')

  validates :name,
    format: { with: /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix }

  def self.default
    d = where(name: Settings.default_domain).limit(1).first
    d = Domain.first if a.nil?

    d
  end

end
