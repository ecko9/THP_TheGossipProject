class User < ApplicationRecord
  belongs_to :city
  has_secure_password
  has_many :likes
  has_many :gossips, through: :likes
  has_many :gossips
  has_many :comments
  has_many :received_messages, foreign_key: 'recipient_id', class_name: 'PrivateMessage'
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'PrivateMessage'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Donnez un mail valide" }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :password, presence: true, length: { minimum: 6 }


#####################################
  def remember_it(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end

end
