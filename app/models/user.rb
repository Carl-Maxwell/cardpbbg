class User < ActiveRecord::Base
  attr_reader :password

  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email, :name
  # validates :password, length: {minimum: 6}
  validates :name, format: {with: /\A[^@]+\z/, message: ""}
  validates :email, format: {with: /@/, message: "must be a valid email address"}

  has_many :sessions
  has_many :cards

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(name, password)
    user = self.find_by("name = :q OR email = :q", q: name)

    return nil unless user

    user.is_password?(password) ? user : nil
  end

  def self.find_by_session_token(session_token, useragent)
    token = self
      .joins(:sessions)
      .find_by(<<-SQL, session_token, useragent, 2.days.ago, 2.weeks.ago)
        sessions.session_token = ? AND
        sessions.useragent     = ? AND
        sessions.updated_at    > ? AND
        sessions.created_at    > ?
      SQL

    if token
      token.save
      token
    else
      nil
    end
  end
end
