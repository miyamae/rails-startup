step 'ユーザー :user を用意' do |user|
  create :user, name: user
end

step '権限 :role のユーザー :user を用意' do |role, user|
  create :user, name: user
  create :users_role, user: User.find_by(name: user), role: Role.find_by(code: role)
end

step ':user でログインする' do |user|
  unless User.find_by(email: "#{user}@example.com")
    create :user, name: user
  end
  visit '/users/sign_in'
  fill_in 'user_email', with: "#{user}@example.com"
  fill_in 'user_password', with: 'password'
  click_button 'ログイン'
end
