class Domain < ActiveRecord::Base

  include Permissionable


  has_many :aliases, dependent: :destroy
  has_many :mailboxes, dependent: :destroy

  attr_accessible :active, :backupmx, :description, :name

  default_scope order('name asc')

  validates :name,
    format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  has_paper_trail


  def self.default
    domain = where(name: Settings.default_domain).limit(1).first
    domain = Domain.first if domain.nil?

    domain
  end

end
