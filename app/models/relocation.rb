# Relocation model for moving of mailbox directories.
class Relocation < ActiveRecord::Base

  belongs_to :mailbox

  attr_accessible :old_username, :old_domain, :mailbox_id

  default_scope order('updated_at asc')

  validates :old_username,
    presence: true,
    uniqueness: {
      scope: [:old_domain, :mailbox_id],
      message: 'Relocation already existing.'
    }
  validates :old_domain, presence: true
  validates :mailbox_id, presence: true

  def perform
    "mv /srv/mail/#{old_domain}/#{old_username} /srv/mail/#{mailbox.domain.name}/#{mailbox.username}"
  end

end
