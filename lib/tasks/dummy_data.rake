namespace :dummy_data do
  desc 'Generate dummy data'

  task generate: :environment do
    DummyData.generate
  end
end
