class Domain < ActiveRecord::Base

  include Permissionable


  has_many :aliases, dependent: :destroy
  has_many :mailboxes, dependent: :destroy

  attr_accessible :active, :backupmx, :catch_all_address, :description, :name

  default_scope order('name asc')

  validates :name,
    format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix },
    presence: true

  has_paper_trail

  before_save ->{ name.downcase! }


  def aliases_count
    aliases.count
  end

  def catch_all_alias
    aliases.where(username: nil).first
  end

  def catch_all_address
    catch_all_alias.try :goto
  end

  def catch_all_address=(goto)
    return catch_all_alias.try(:destroy) if goto.blank?

    a = catch_all_alias || aliases.build
    a.goto = goto
    a.save! validate: false
  end

  def mailboxes_count
    mailboxes.count
  end

  def mailboxes_for_select
    mailboxes.map { |m| [m.email, m.id] }
  end

  def to_s
    name
  end


  def self.default
    domain = where(name: Settings.default_domain).limit(1).first
    domain = Domain.first if domain.nil?

    domain
  end

  def self.managable(mailbox)
    Domain.all.map { |d| d if d.permission? :editor, mailbox }.compact
  end

end
