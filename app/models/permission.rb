class Permission < ActiveRecord::Base
  
  ROLES = %w(owner editor)
  
  # Thrown if the last admin/owner tries to remove itself.
  class PowerVaccuumError < Exception; end

  has_paper_trail
  
  attr_accessible :subject, :subject_id, :subject_type, :role
  
  belongs_to :subject, polymorphic: true
  belongs_to :item,    polymorphic: true
  belongs_to :creator, class_name: 'Mailbox'
  
  validates :role, inclusion: { in: ROLES }, presence: true
  validates :subject_id,
    uniqueness: { scope: [:subject_id, :subject_type, :item_id, :item_type] },
    presence: true

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
  
  scope :role, ->(role) { where role: role }
  scope :owner, role(:owner)
  scope :editor, role(:editor)

  def to_s
    "#{subject.email} is #{role} on #{item.name}"
  end

end
