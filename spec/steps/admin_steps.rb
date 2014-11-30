step '管理者でログインする' do
  visit '/users/sign_in'
  fill_in 'user_email', with: 'admin@example.com'
  fill_in 'user_password', with: 'adminadmin'
  click_button 'ログイン'
end

step 'ユーザーのテストデータを用意する' do
  (1..5).each do |n|
    create :user, name: "user#{n}"
  end
end
