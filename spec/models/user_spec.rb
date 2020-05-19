require 'rails_helper'

describe User do
  describe '#create' do
    context '＊カラムの存在の有無についてのバリデーションチェック' do
      it "カラムがすべて存在すれば、登録できること" do
        user = build(:user)
        user.valid?
        expect(user).to be_valid
      end

      it "nicknameがない場合は登録できないこと" do
          user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("が入力されていません。")
      end

      it "emailがない場合は登録できないこと" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("が入力されていません。")
      end

      it "passwordがない場合は登録できないこと" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("が入力されていません。")
      end

      it "passwordが存在しても、password_confirmationがない場合は登録できないこと" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
      end

      it "firstnameがない場合は登録できないこと" do
        user = build(:user, firstname: "")
        user.valid?
        expect(user.errors[:firstname]).to include("が入力されていません。")
      end

      it "lastnameがない場合は登録できないこと" do
        user = build(:user, lastname: "")
        user.valid?
        expect(user.errors[:lastname]).to include("が入力されていません。")
      end

      it "firstname_kanaがない場合は登録できないこと" do
        user = build(:user, firstname_kana: "")
        user.valid?
        expect(user.errors[:firstname_kana]).to include("が入力されていません。")
      end

      it "lastname_kanaがない場合は登録できないこと" do
        user = build(:user, lastname_kana: "")
        user.valid?
        expect(user.errors[:lastname_kana]).to include("が入力されていません。")
      end

      it "birth_yearがない場合は登録できないこと" do
        user = build(:user, birth_year: "")
        user.valid?
        expect(user.errors[:birth_year]).to include("が入力されていません。")
      end

      it "birth_monthがない場合は登録できないこと" do
        user = build(:user, birth_month: "")
        user.valid?
        expect(user.errors[:birth_month]).to include("が入力されていません。")
      end

      it "birth_dayがない場合は登録できないこと" do
        user = build(:user, birth_day: "")
        user.valid?
        expect(user.errors[:birth_day]).to include("が入力されていません。")
      end
    end

    context '＊nickname固有のバリデーションチェック' do
      it "nicknameが9文字以上であれば登録できないこと" do
        user = build(:user, nickname: "aaaaaaaaa")
        user.valid?
        expect(user.errors[:nickname]).to include("は8文字以下に設定して下さい。")
      end

      it "nicknameが8文字以下では登録できること" do
        user = build(:user, nickname: "aaaaaaaa")
        user.valid?
        expect(user).to be_valid
      end
    end

    context '＊email固有のバリデーションチェック' do
      it " 重複したemailが存在する場合は登録できないこと " do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("は既に使用されています。")
      end
    end

    context '＊password固有のバリデーションチェック' do
      it "passwordが7文字以上であれば登録できないこと" do
        user = build(:user, password: "0000000", password_confirmation: "0000000")
        user.valid?
        expect(user).to be_valid
      end

      it "passwordが6文字以下であれば登録できないこと " do
        user = build(:user, password: "000000", password_confirmation: "000000")
        user.valid?
        expect(user.errors[:password]).to include("は7文字以上に設定して下さい。")
      end
    end

    context '＊firstname/lastnameに設定しているバリデーションチェック' do
      it "全角漢字であれば登録できること" do
        user = build(:user, firstname: "鈴木")
        user.valid?
        expect(user).to be_valid
      end

      it "全角ひらがなであれば登録できること" do
        user = build(:user, firstname: "すずき")
        user.valid?
        expect(user).to be_valid
      end

      it "全角カナであれば登録できること" do
        user = build(:user, firstname: "スズキ")
        user.valid?
        expect(user).to be_valid
      end

      it "半角入力の場合、登録できないこと" do
        user = build(:user, firstname: "testman")
        user.valid?
        expect(user.errors[:firstname]).to include("は有効でありません。")
      end
    end

    context '＊firstname_kana/lastname_kanaに設定しているバリデーションチェック' do
      it "全角カナであれば登録できること" do
        user = build(:user, firstname_kana: "スズキ")
        user.valid?
        expect(user).to be_valid
      end

      it "全角漢字の場合、登録できないこと" do
        user = build(:user, firstname_kana: "鈴木")
        user.valid?
        expect(user.errors[:firstname_kana]).to include("は有効でありません。")
      end

      it "全角ひらがなの場合、登録できないこと" do
        user = build(:user, firstname_kana: "すずき")
        user.valid?
        expect(user.errors[:firstname_kana]).to include("は有効でありません。")
      end
    end

    context '＊birth_year固有のバリデーションチェック' do
      it "birth_yearが4桁の数字であれば登録できること" do
        user = build(:user, birth_year: 1988)
        user.valid?
        expect(user).to be_valid
      end

      it "birth_yearが4桁以外の桁数の場合、登録できないこと" do
        user = build(:user, birth_year: 19885)
        user.valid?
        expect(user.errors[:birth_year]).to include("は有効でありません。")
      end

      it "birth_yearが数字以外の場合、登録できないこと" do
        user = build(:user, birth_year: "西暦")
        user.valid?
        expect(user.errors[:birth_year]).to include("は有効でありません。")
      end
    end

    context 'birth_month固有のバリデーションチェック' do
      it "birth_monthが数字であれば、登録できること" do
        user = build(:user, birth_month: 4)
        user.valid?
        expect(user).to be_valid
      end

      it "birth_monthが数字でない場合、登録できないこと" do
        user = build(:user, birth_month: "よん")
        user.valid?
        expect(user.errors[:birth_month]).to include("数字を入力してください")
      end

      it "birth_monthが0以下の場合、登録できないこと" do
        user = build(:user, birth_month: -1)
        user.valid?
        expect(user.errors[:birth_month]).to include("以上の数字を入力してください")
      end

      it "birth_monthが13以上の場合、登録できないこと" do
        user = build(:user, birth_month: 13)
        user.valid?
        expect(user.errors[:birth_month]).to include("未満の数字を入力してください")
      end

      it "birth_monthが12以下であれば登録できること" do
        user = build(:user, birth_month: 12)
        user.valid?
        expect(user).to be_valid
      end
    end

    context '＊birth_day固有のバリデーションチェック' do
      it "birth_dayが32以上の場合、登録できないこと" do
        user = build(:user, birth_day: 32)
        user.valid?
        expect(user.errors[:birth_day]).to include("未満の数字を入力してください")
      end

      it "birth_dayが31以下であれば登録できること" do
        user = build(:user, birth_day: 31)
        user.valid?
        expect(user).to be_valid
      end
    end
  end
end
