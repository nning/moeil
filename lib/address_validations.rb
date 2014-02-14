# Shared validations for Alias and Mailbox models.
module AddressValidations

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

end
