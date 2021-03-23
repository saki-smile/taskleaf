FactoryBot.define do
  factory :task do
    name {'テストを書く'}
    description {'RSpec＆Capybra＆FactoryBotを準備する'}
    user
    # 関連名とファクトリ名が異なる場合は下記のように記述することもできる
    # association :user, factory: :admin_user
  end
end