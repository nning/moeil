# Permission model.
class Permission < ActiveRecord::Base
  include Permission::Scopes
  include Permission::Validations

  has_paper_trail

  belongs_to :subject, polymorphic: true
  belongs_to :item,    polymorphic: true
  belongs_to :creator, class_name: 'Mailbox'

  # Return URL array for editing model instance.
  def edit_url_array
    item ? [:edit, :admin, item, self] : nil
  end

  # String representation.
  def to_s
    # Fetch associated Mailbox and Domain.
    s, i = subject, item

    # Fallback names if Mailbox or Domain is deleted.
    s ||= 'Deleted mailbox'
    i ||= 'deleted domain'

    # Return String representation.
    "#{s} is #{role} of #{i}"
  end
end
