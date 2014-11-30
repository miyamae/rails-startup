step 'debug' do
  puts page.html
end

step 'break' do
  binding.pry
end

step ':filename に保存' do |filename|
  page.save_screenshot(filename, full: true)
end

step ':driver ドライバを使用' do |driver|
  Capybara.current_driver = driver.to_sym
end

step ':sec 秒待つ' do |sec|
  sleep sec.to_f
end

step 'URL :pattern が表示されている' do |pattern|
  expect(page.current_url).to match pattern
end

step ':url を表示する' do |url|
  visit url
end

step ':str と表示されている' do |str|
  expect(page).to have_content(str)
end

step ':str と表示されていない' do |str|
  expect(page).not_to have_content(str)
end

step ':tgt に :str と表示されている' do |tgt, str|
  within tgt do
    expect(page).to have_content(str)
  end
end

step ':tgt に :str と表示されていない' do |tgt, str|
  within tgt do
    expect(page).not_to have_content(str)
  end
end

step ':str をクリックする' do |str|
  click_on str
end

step ':tgt の :str をクリックする' do |tgt, str|
  within tgt do
    click_on str
  end
end

step ':tgt に :str と入力する' do |tgt, str|
  fill_in tgt, with: str
end

step ':scp の :tgt に :str と入力する' do |scp, tgt, str|
  within scp do
    fill_in tgt, with: str
  end
end

step ':tgt の :str を選択する' do |tgt, str|
  select str, from: tgt
end

step ':scp の :tgt の :str を選択する' do |scp, tgt, str|
  within scp do
    select str, from: tgt
  end
end

step ':tgt をチェックする' do |tgt|
  check tgt
end

step ':scp の :tgt をチェックする' do |scp, tgt|
  within scp do
    check tgt
  end
end

step ':element で :key キーを押す' do |element, key|
  find(element).native.send_keys(key.to_sym)
end

step ':scp の :element で :key キーを押す' do |element, key|
  within scp do
    find(element).native.send_keys(key.to_sym)
  end
end

step 'ステータスコード :code' do |code|
  expect(page.status_code).to eq code.to_i
end

step '例外が発生する' do
  expect(page.status_code).to eq 500
end
