FactoryBot.define do
  # ファクトリ名とクラスが異なる場合は下記のように:classオプションでクラスを指定する
  # factory :admin_user, class User do
  factory :user do
    name {'テストユーザー'}
    email {'test1@example.com'}
    password {'password'}
  end
end