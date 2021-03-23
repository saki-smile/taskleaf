require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # user_a = FactoryBot.create(:user)　ファクトリで作成したユーザー情報が入る
  # テストで使うユーザーが一人なら上記で良いが、二人以上作成したい場合にスムーズにするために
  # 下記のように一部の属性を指定した値に変えてデータを作成することができる
  # ユーザーAを作成しておく
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  # ユーザーBを作成しておく
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  # 作成者がユーザーAであるタスクを作成しておく
  let!(:task_a) {FactoryBot.create(:task, name: '最初のタスク', user: user_a)}

  before do
    # 1　ログイン画面にアクセスする
    visit login_path
    # 2　メールアドレスを入力する
    fill_in 'メールアドレス', with: login_user.email
    # 3　パスワードを入力する
    fill_in 'パスワード', with: login_user.password
    # 4　ログインするボタンをおす
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    # 作成済みタスクの名称が画面上に表示されていることを確認
    it {expect(page).to have_content '最初のタスク'}
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}
      # shared_example_forを利用して下記のように書く
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) {user_b}

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーA作成済みタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
        # expect(page).not_to have_content '最初のタスク' これでも同じ
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end
      # shared_example_forを利用して下記のように書く
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}
    let(:task_name) {'新規作成のテストを書く'}

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力した時' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      # let(:task_name) {'新規作成のテストを書く'}の上書き
      let(:task_name) {''}

      it 'エラーになる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
