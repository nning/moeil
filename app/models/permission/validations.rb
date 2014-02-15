# Validations for the Permission model.
module Permission::Validations
  extend ActiveSupport::Concern

  ROLES = %w(owner editor)

  included do
    validates :role, inclusion: { in: ROLES }, presence: true
    validates :subject_id,
      uniqueness: { scope: [:subject_id, :subject_type, :item_id, :item_type] },
      presence: true
  end
end
