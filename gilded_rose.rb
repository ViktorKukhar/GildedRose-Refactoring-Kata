class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_item_quality(item)
      update_item_sell_in(item)
      handle_expired_item(item) if item.sell_in < 0
    end
  end

  private

  def update_item_quality(item)
    case item.name
    when "Aged Brie"
      update_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_passes(item)
    when "Conjured Mana Cake"
      update_conjured_item(item)
    when "Sulfuras, Hand of Ragnaros"
      # not change
    else
      update_normal_item(item)
    end
  end

  def update_item_sell_in(item)
    item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  end

  def handle_expired_item(item)
    case item.name
    when "Aged Brie"
      handle_expired_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      handle_expired_backstage_passes(item)
    when "Conjured Mana Cake"
      handle_expired_conjured_item(item)
    when "Sulfuras, Hand of Ragnaros"
      # not change
    else
      handle_expired_normal_item(item)
    end
  end

  def handle_expired_aged_brie(item)
    increase_quality(item)
  end

  def handle_expired_backstage_passes(item)
    item.quality = 0
  end

  def handle_expired_conjured_item(item)
    2.times { decrease_quality(item) }
  end

  def handle_expired_normal_item(item)
    decrease_quality(item)
  end

  def update_normal_item(item)
    decrease_quality(item)
  end

  def update_conjured_item(item)
    2.times { decrease_quality(item) }
  end

  def update_aged_brie(item)
    increase_quality(item)
  end

  def update_backstage_passes(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
