require 'rails_helper'

describe Address do
  describe '#create' do
    context '＊カラムの存在の有無についてのバリデーションチェック' do
      it "カラムがすべて存在すれば、登録できること" do
        address = build(:address)
        address.valid?
        expect(address).to be_valid
      end

      it "任意入力のカラムが空でも、登録できること" do
        address = build(:address, building_name: "", telephone_number: "")
        address.valid?
        expect(address).to be_valid
      end

      it "firstnameがない場合は登録できないこと" do
        address = build(:address, firstname: "")
        address.valid?
        expect(address.errors[:firstname]).to include("が入力されていません。")
      end

      it "lastnameがない場合は登録できないこと" do
        address = build(:address, lastname: "")
        address.valid?
        expect(address.errors[:lastname]).to include("が入力されていません。")
      end

      it "firstname_kanaがない場合は登録できないこと" do
        address = build(:address, firstname_kana: "")
        address.valid?
        expect(address.errors[:firstname_kana]).to include("が入力されていません。")
      end

      it "lastname_kanaがない場合は登録できないこと" do
        address = build(:address, lastname_kana: "")
        address.valid?
        expect(address.errors[:lastname_kana]).to include("が入力されていません。")
      end

      it "postal_codeがない場合は登録できないこと" do
        address = build(:address, postal_code: "")
        address.valid?
        expect(address.errors[:postal_code]).to include("が入力されていません。")
      end

      it "prefecturesがない場合は登録できないこと" do
        address = build(:address, prefectures: "")
        address.valid?
        expect(address.errors[:prefectures]).to include("が入力されていません。")
      end

      it "cityがない場合は登録できないこと" do
        address = build(:address, city: "")
        address.valid?
        expect(address.errors[:city]).to include("が入力されていません。")
      end
    end

    context '＊firstname/lastnameに設定しているバリデーションチェック' do
      it "全角漢字であれば登録できること" do
        address = build(:address, firstname: "鈴木")
        address.valid?
        expect(address).to be_valid
      end

      it "全角ひらがなであれば登録できること" do
        address = build(:address, firstname: "すずき")
        address.valid?
        expect(address).to be_valid
      end

      it "全角カナであれば登録できること" do
        address = build(:address, firstname: "スズキ")
        address.valid?
        expect(address).to be_valid
      end

      it "半角入力の場合、登録できないこと" do
        address = build(:address, firstname: "testman")
        address.valid?
        expect(address.errors[:firstname]).to include("は有効でありません。")
      end
    end

    context '＊firstname_kana/lastname_kanaに設定しているバリデーションチェック' do
      it "全角カナであれば登録できること" do
        address = build(:address, firstname_kana: "スズキ")
        address.valid?
        expect(address).to be_valid
      end

      it "全角漢字の場合、登録できないこと" do
        address = build(:address, firstname_kana: "鈴木")
        address.valid?
        expect(address.errors[:firstname_kana]).to include("は有効でありません。")
      end

      it "全角ひらがなの場合、登録できないこと" do
        address = build(:address, firstname_kana: "すずき")
        address.valid?
        expect(address.errors[:firstname_kana]).to include("は有効でありません。")
      end
    end

    context '＊postal_code固有のバリデーションチェック' do
      it "7桁の数字であれば登録できること" do
        address = build(:address, postal_code: "1230022")
        address.valid?
        expect(address).to be_valid
      end

      it "6桁以下の場合は、登録できないこと" do
        address = build(:address, postal_code: "123002")
        address.valid?
        expect(address.errors[:postal_code]).to include("は有効でありません。")
      end

      it "8桁以上の場合は、登録できないこと" do
        address = build(:address, postal_code: "12300222")
        address.valid?
        expect(address.errors[:postal_code]).to include("は有効でありません。")
      end

      it "数字以外の場合は、登録できないこと" do
        address = build(:address, postal_code: "テスト")
        address.valid?
        expect(address.errors[:postal_code]).to include("は有効でありません。")
      end
    end

    context '＊telephone_number固有のバリデーションチェック' do
      it "11桁の数字であれば登録できること" do
        address = build(:address, telephone_number: "08066667777")
        address.valid?
        expect(address).to be_valid
      end

      it "10桁の数字であれば登録できること" do
        address = build(:address, telephone_number: "0366667777")
        address.valid?
        expect(address).to be_valid
      end

      it "9桁以下の数字の場合、登録できないこと" do
        address = build(:address, telephone_number: "036666777")
        address.valid?
        expect(address.errors[:telephone_number]).to include("は有効でありません。")
      end

      it "12桁以上の数字の場合、登録できないこと" do
        address = build(:address, telephone_number: "080666677779")
        address.valid?
        expect(address.errors[:telephone_number]).to include("は有効でありません。")
      end

      it "数字以外の場合、登録できないこと" do
        address = build(:address, telephone_number: "電話番号の入力をしたよ")
        address.valid?
        expect(address.errors[:telephone_number]).to include("は有効でありません。")
      end
    end
  end
end