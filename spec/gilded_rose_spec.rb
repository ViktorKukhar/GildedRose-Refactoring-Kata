require_relative '../gilded_rose'
require 'rspec'

describe GildedRose do
  before(:each) do
    @items = [
      Item.new("Aged Brie", 2, 0),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
      Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
      Item.new("Normal Item", 10, 20)
    ]
    @gilded_rose = GildedRose.new(@items)
  end

  describe "#update_quality" do
    it "does not change the name of items" do
      @gilded_rose.update_quality()
      expect(@items[0].name).to eq "Aged Brie"
      expect(@items[1].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(@items[2].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(@items[3].name).to eq "Normal Item"
    end

    it "decreases the sell_in value" do
      @gilded_rose.update_quality()
      expect(@items[0].sell_in).to eq 1
      expect(@items[1].sell_in).to eq 14
      expect(@items[2].sell_in).to eq 0 # Sulfuras does not change
      expect(@items[3].sell_in).to eq 9
    end

    it "decreases the quality of normal items" do
      @gilded_rose.update_quality()
      expect(@items[3].quality).to eq 19
    end

    it "increases the quality of Aged Brie" do
      @gilded_rose.update_quality()
      expect(@items[0].quality).to eq 1
    end

    it "does not change the quality of Sulfuras" do
      @gilded_rose.update_quality()
      expect(@items[2].quality).to eq 80
    end

    it "increases the quality of Backstage passes" do
      @gilded_rose.update_quality()
      expect(@items[1].quality).to eq 21
    end

    it "sets the quality of Backstage passes to 0 after the concert" do
      16.times { @gilded_rose.update_quality() }
      expect(@items[1].quality).to eq 0
    end

    it "does not increase the quality of an item above 50" do
      50.times { @gilded_rose.update_quality() }
      expect(@items[0].quality).to be <= 50
    end

    it "degrades quality twice as fast once sell_in date has passed" do
      10.times { @gilded_rose.update_quality() } # Move sell_in to 0
      current_quality = @items[3].quality
      @gilded_rose.update_quality()
      expect(@items[3].quality).to eq(current_quality - 2)
    end
  end
end