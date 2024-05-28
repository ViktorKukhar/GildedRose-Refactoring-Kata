require_relative '../gilded_rose'
require 'rspec'

describe GildedRose do
  describe "#update_quality" do
    context "when updating Aged Brie" do
      it "increases quality as it gets older" do
        items = [Item.new("Aged Brie", 2, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 1
      end

      it "increases quality twice as fast after sell_in date has passed" do
        items = [Item.new("Aged Brie", 0, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 2
      end

      it "does not increase quality above 50" do
        items = [Item.new("Aged Brie", 2, 50)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 50
      end
    end

    context "when updating Backstage passes" do
      it "increases quality by 1 when sell_in is more than 10 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 21
      end

      it "increases quality by 2 when sell_in is 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 22
      end

      it "increases quality by 3 when sell_in is 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 23
      end

      it "drops quality to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 0
      end
    end

    context "when updating Sulfuras" do
      it "does not change sell_in or quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 80
      end
    end

    context "when updating normal items" do
      it "decreases quality and sell_in by 1 each day" do
        items = [Item.new("Normal Item", 10, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 19
      end

      it "decreases quality twice as fast after sell_in date has passed" do
        items = [Item.new("Normal Item", 0, 20)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 18
      end

      it "does not decrease quality below 0" do
        items = [Item.new("Normal Item", 10, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 0
      end
    end

    context "when updating Conjured items" do
      it "decreases quality twice as fast as normal items" do
        items = [Item.new("Conjured Mana Cake", 3, 6)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 4
      end

      it "decreases quality four times as fast after sell_in date has passed" do
        items = [Item.new("Conjured Mana Cake", 0, 6)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        expect(items[0].quality).to eq 2
      end
    end
  end
end
