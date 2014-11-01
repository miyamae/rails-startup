#= テスト用のダミーデータを生成

class DummyData

  def self.generate
    generate_users
  end

  def self.generate_users(num: 100)
    Faker::Config.locale = :en
    print 'User '
    num.times do
      print '.'
      time = Faker::Time.backward(num)
      User.create!(
        email:        Faker::Internet.email,
        password:     Faker::Internet.password,
        name:         Faker::Internet.user_name,
        nick_name:    Faker::Name.name,
        # image:        Faker::Avatar.image,
        confirmed_at: time,
        created_at:   time,
        updated_at:   time
      )
    end
    puts
  end

end
