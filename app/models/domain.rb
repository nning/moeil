class Domain < ActiveRecord::Base

  has_many :aliases
  has_many :mailboxes

  attr_accessible :active, :backupmx, :description, :name

  default_scope order('name asc')

  validates :name,
    format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  def self.default
    d = where(name: Settings.default_domain).limit(1).first
    d = Domain.first if d.nil?

    d
  end

end
