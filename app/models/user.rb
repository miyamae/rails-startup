# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  key                    :string(255)      not null
#  name                   :string(255)      default(""), not null
#  nick_name              :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  twitter_uid            :string(255)
#  facebook_uid           :string(255)
#  google_uid             :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  image_file_name        :string(255)
#  image_content_type     :string(255)
#  image_file_size        :integer
#  image_updated_at       :datetime
#  bio                    :text
#  note                   :text
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_created_at            (created_at)
#  index_users_on_email                 (email)
#  index_users_on_key                   (key) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_updated_at            (updated_at)
#

#= ユーザー

class User < ActiveRecord::Base
  include HashKey
  extend FriendlyId
  friendly_id :key

  default_scope { order created_at: :desc }
  scope :enabled, -> { where 'confirmed_at is not null' }

  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles

  validates :twitter_uid, uniqueness: { allow_blank: true }
  validates :facebook_uid, uniqueness: { allow_blank: true }
  validates :google_uid, uniqueness: { allow_blank: true }

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :confirmable,
    :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

  has_attached_file :image,
    styles: { avater_lg: '256x256#' ,avater_sm: '48x48#' }
  validates_attachment_size :image, less_than: 1.megabytes,
    message: I18n.t('activerecord.errors.messages.too_large')
  validates_attachment_content_type :image,
    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
    message: I18n.t('activerecord.errors.messages.invalid_content_type')

  include PaperclipUuidFilename
  uuid_attached_file :image

  validates :name, length: { maximum: 30 }
  validates :nick_name, length: { maximum: 30 }
  validates :bio, length: { maximum: 1000 }
  validates :note, length: { maximum: 1000 }

  # Facebook OAuth認証情報からユーザーを取得または追加
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    if signed_in_resource
      user = signed_in_resource
      user.update_attributes(facebook_uid: auth.uid)
    else
      user = find_by(facebook_uid: auth.uid)
      unless user
        user = create(
          nick_name: auth.extra.raw_info.name,
          facebook_uid: auth.uid,
          email: auth.info.email,
          image: auth.info.image + '?type=large',
          confirmed_at: Time.now
        )
      end
    end
    user
  end

  # Twitter OAuth認証情報からユーザーを取得または追加
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    if signed_in_resource
      user = signed_in_resource
      user.update_attributes(twitter_uid: auth.uid)
    else
      user = find_by(twitter_uid: auth.uid)
      unless user
        user = create(
          nick_name: auth.extra.raw_info.name,
          twitter_uid: auth.uid,
          image: auth.info.image.gsub('_normal', ''),
          confirmed_at: Time.now
        )
      end
    end
    user
  end

  # Google OAuth認証情報からユーザーを取得または追加
  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    if signed_in_resource
      user = signed_in_resource
      user.update_attributes(google_uid: auth.uid)
    else
      user = find_by(google_uid: auth.uid)
      unless user
        user = create(
          nick_name: auth.extra.raw_info.name,
          google_uid: auth.uid,
          email: auth.info.email,
          image: auth.info.image,
          confirmed_at: Time.now
        )
      end
    end
    user
  end

  # OAuth認証ユーザーはE-mail不要
  def email_required?
    super && facebook_uid.blank? && twitter_uid.blank? && google_uid.blank?
  end

  # OAuth認証ユーザーはパスワード不要
  def password_required?
    super && facebook_uid.blank? && twitter_uid.blank? && google_uid.blank?
  end

  # E-mail未設定でも再設定可能に
  def reconfirmation_required?
    self.class.reconfirmable && @reconfirmation_required # && !self.email.blank?
  end

  # 現在のパスワードなしで更新
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    clean_up_passwords
    update_attributes(params, *options)
  end

  # 表示名
  def screen_name
    if nick_name.present?
      return nick_name
    else
      email =~ /(.*)@.*/
      return $1
    end
  end
  def to_s
    screen_name
  end

  # 権限あり？
  def has_role?(role_code=:any)
    if role_code == :any
      ! roles.empty?
    else
      roles.find_by(code: role_code.to_s) ? true : false
    end
  end

end
