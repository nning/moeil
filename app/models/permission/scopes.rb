# Scopes for the Permission model.
module Permission::Scopes
  extend ActiveSupport::Concern

  included do
    scope :item, ->(item) {
      where \
        item_id:   item.id,
        item_type: item.class.to_s
    }
    
    scope :subject, ->(subject) {
      where \
        subject_id:   subject.id,
        subject_type: subject.class.to_s
    }
    
    scope :role,   ->(role) { where role: role }
    scope :owner,  -> { role(:owner) }
    scope :editor, -> { role(:editor) }
  end
end
