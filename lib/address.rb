# Shared functionality for Alias and Mailbox models.
module Address
  include ActionView::Helpers::UrlHelper
  extend ActiveSupport::Concern

  included do
    validates :username,
      presence: true,
      uniqueness: {
        scope: :domain_id,
        message: 'Combination of username and domain is not unique.'
      },
      format: {
        with: /\A[a-zA-Z0-9.\-_]+\z/,
        message: 'Username contains invalid characters.'
      },
      exclusion: {
        in: Settings.blocked_usernames,
        message: 'Username is blocked.'
      }

    validates :domain_id, presence: true
  end

  # Returns URL array for editing model instance.
  def edit_url_array
    [:edit, :admin, domain, self]
  end
end
