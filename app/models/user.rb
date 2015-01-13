# == Schema Information
#
# Table name: users # ユーザーマスタ
#
#  id                     :integer          not null, primary key  # ユーザーマスタ
#  key                    :string           not null               # 固有キー
#  name                   :string           default(""), not null  # ユーザー名
#  nick_name              :string           default(""), not null  # ニックネーム
#  email                  :string           default(""), not null  # メールアドレス
#  encrypted_password     :string           default(""), not null  # パスワード(ハッシュ値)
#  reset_password_token   :string                                  # パスワードリセットトークン
#  reset_password_sent_at :datetime                                # パスワードリセット要求日時
#  remember_created_at    :datetime                                # 次回自動指定でのログイン日時
#  sign_in_count          :integer          default("0"), not null # ログイン回数
#  current_sign_in_at     :datetime                                # 今回ログイン日時
#  last_sign_in_at        :datetime                                # 前回ログイン日時
#  current_sign_in_ip     :string                                  # 今回アクセス元IP
#  last_sign_in_ip        :string                                  # 前回アクセス元IP
#  confirmation_token     :string                                  # 登録確認トークン
#  confirmed_at           :datetime                                # 登録確認済み日時
#  confirmation_sent_at   :datetime                                # 登録確認要求日時
#  unconfirmed_email      :string                                  # 未確認メールアドレス
#  twitter_uid            :string                                  # TwitterアカウントUID
#  facebook_uid           :string                                  # FacebookアカウントUID
#  google_uid             :string                                  # GoogleアカウントUID
#  failed_attempts        :integer          default("0"), not null # 認証失敗回数
#  unlock_token           :string                                  # アカウントロック解除トークン
#  locked_at              :datetime                                # アカウントロック日時
#  image_file_name        :string                                  # 画像ファイル名
#  image_content_type     :string                                  # 画像MIMEタイプ
#  image_file_size        :integer                                 # 画像ファイルサイズ
#  image_updated_at       :datetime                                # 画像更新日時
#  bio                    :text                                    # 自己紹介
#  note                   :text                                    # メモ
#  created_at             :datetime         not null               # 作成日時
#  updated_at             :datetime         not null               # 更新日時
#  deleted_at             :datetime                                # 削除日時
#
# Indexes
#
#  index_users_on_confirmation_token           (confirmation_token) UNIQUE
#  index_users_on_created_at                   (created_at)
#  index_users_on_deleted_at                   (deleted_at)
#  index_users_on_deleted_at_and_facebook_uid  (deleted_at,facebook_uid) UNIQUE
#  index_users_on_deleted_at_and_google_uid    (deleted_at,google_uid) UNIQUE
#  index_users_on_deleted_at_and_key           (deleted_at,key) UNIQUE
#  index_users_on_deleted_at_and_twitter_uid   (deleted_at,twitter_uid) UNIQUE
#  index_users_on_email                        (email)
#  index_users_on_name                         (name)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_unlock_token                 (unlock_token) UNIQUE
#  index_users_on_updated_at                   (updated_at)
#

#= User accounts

class User < ActiveRecord::Base
  include HashKey

  extend FriendlyId
  friendly_id :key

  acts_as_paranoid

  include Garage::Representer
  include Garage::Authorizable
  property :id
  property :key
  property :name
  property :nick_name
  property :email
  property :bio
  property :created_at
  property :updated_at
  link(:self) { v1_user_url(self.id) }

  default_scope { order created_at: :desc }
  scope :enabled, -> { where 'confirmed_at is not null' }

  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :confirmable,
    :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

  has_attached_file :image,
    styles: { avatar_lg: '256x256#' ,avatar_sm: '48x48#' }
  validates_attachment_size :image, less_than: 1.megabytes,
    message: I18n.t('errors.messages.too_large')
  validates_attachment_content_type :image,
    content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
    message: I18n.t('errors.messages.invalid_content_type')

  include PaperclipUuidFilename
  uuid_attached_file :image

  validates :email, presence: true
  validates :email, uniqueness: { scope: :deleted_at, allow_blank: true }
  validates :password, confirmation: true
  validates :password, length: { minimum: 8, allow_blank: true }
  validates :name, length: { maximum: 30, allow_blank: true }
  validates :name, uniqueness: { scope: :deleted_at, allow_blank: true }
  validates :nick_name, length: { maximum: 30, allow_blank: true }
  validates :bio, length: { maximum: 1000, allow_blank: true }
  validates :note, length: { maximum: 1000, allow_blank: true }
  validates :twitter_uid, uniqueness: { scope: :deleted_at, allow_blank: true }
  validates :facebook_uid, uniqueness: { scope: :deleted_at, allow_blank: true }
  validates :google_uid, uniqueness: { scope: :deleted_at, allow_blank: true }

  # Permissins for API (:index)
  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end

  # Permissins for API (:show, :create, :update, :destroy)
  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end

  # Find or add user with Facebook OAuth
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

  # Find or add user with Twitter OAuth
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

  # Find or add user with Google OAuth
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

  # OAuth user does not require email
  def email_required?
    super && facebook_uid.blank? && twitter_uid.blank? && google_uid.blank?
  end

  # OAuth user does not require password
  def password_required?
    super && facebook_uid.blank? && twitter_uid.blank? && google_uid.blank?
  end

  # Even if email is not set, you can reconfirm that
  def reconfirmation_required?
    self.class.reconfirmable && @reconfirmation_required # && !self.email.blank?
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    clean_up_passwords
    update_attributes(params, *options)
  end

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

  def has_role?(role_code=:any)
    if role_code == :any
      ! roles.empty?
    else
      roles.find_by(code: role_code.to_s) ? true : false
    end
  end

end
