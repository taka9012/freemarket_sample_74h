require 'rails_helper'

describe Item do
  describe '#create' do
    context '＊カラムの存在の有無についてのバリデーションチェック' do
      it "必須カラムがすべて存在すれば、登録できること" do
        item = build(:item)
        item.valid?
        expect(item).to be_valid
      end

      it "画像がない場合に、登録できないこと" do
        item_no_picture = build(:item_no_picture)
        item_no_picture.valid?
        expect(item_no_picture.errors[:images]).to include("が入力されていません。")
      end

      it "nameがない場合は登録できないこと" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("が入力されていません。")
      end

      it "explanationがない場合は登録できないこと" do
        item = build(:item, explanation: "")
        item.valid?
        expect(item.errors[:explanation]).to include("が入力されていません。")
      end

      it "priceがない場合は登録できないこと" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("数字を入力してください")
      end

      it "categoryがない場合は登録できないこと" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category]).to include("が入力されていません。")
      end

      it "item_status_idがない場合は登録できないこと" do
        item = build(:item, item_status_id: "")
        item.valid?
        expect(item.errors[:item_status_id]).to include("が入力されていません。")
      end

      it "postage_type_idがない場合は登録できないこと" do
        item = build(:item, postage_type_id: "")
        item.valid?
        expect(item.errors[:postage_type_id]).to include("が入力されていません。")
      end

      it "postage_burden_idがない場合は登録できないこと" do
        item = build(:item, postage_burden_id: "")
        item.valid?
        expect(item.errors[:postage_burden_id]).to include("が入力されていません。")
      end

      it "shipping_areaがない場合は登録できないこと" do
        item = build(:item, shipping_area: "")
        item.valid?
        expect(item.errors[:shipping_area]).to include("が入力されていません。")
      end

      it "shipping_date_idがない場合は登録できないこと" do
        item = build(:item, shipping_date_id: "")
        item.valid?
        expect(item.errors[:shipping_date_id]).to include("が入力されていません。")
      end

      it "trading_status_idがない場合は登録できないこと" do
        item = build(:item, trading_status_id: "")
        item.valid?
        expect(item.errors[:trading_status_id]).to include("が入力されていません。")
      end

    end

    context '＊price固有のバリデーションチェック' do
      it "priceが300未満場合は登録できないこと" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("以上の数字を入力してください")
      end

      it "priceが0以下の場合は登録できないこと" do
        item = build(:item, price: -1)
        item.valid?
        expect(item.errors[:price]).to include("以上の数字を入力してください")
      end

      it "priceが100000000以上の場合は登録できないこと" do
        item = build(:item, price: 100000000)
        item.valid?
        expect(item.errors[:price]).to include("未満の数字を入力してください")
      end

      it "priceが300の場合は登録できること" do
        item = build(:item, price: 300)
        item.valid?
        expect(item).to be_valid
      end

      it "priceが9999999の場合は登録できること" do
        item = build(:item, price: 9999999)
        item.valid?
        expect(item).to be_valid
      end
    end
  end

  describe '#update' do
    
  end
end
    