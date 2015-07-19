class Session < ActiveRecord::Base
  # validates :useragent, presence: true
  validates :session_token, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user

  after_initialize :set_token

  def set_token
    self.session_token = generate_token
  end

  private

  def generate_token
    while (token = SecureRandom::urlsafe_base64(128)) &&
      Session.find_by(session_token: token)

      # empty loop

    end

    token
  end
end
