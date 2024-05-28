class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == "Aged Brie"
        update_aged_brie(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      elsif item.name == "Conjured Mana Cake"
        update_conjured_item(item)
      elsif item.name != "Sulfuras, Hand of Ragnaros"
        update_normal_item(item)
      end

      decrease_sell_in(item) unless item.name == "Sulfuras, Hand of Ragnaros"

      if item.sell_in < 0
        handle_expired_item(item)
      end
    end
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

  def handle_expired_item(item)
    if item.name == "Aged Brie"
      increase_quality(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality = 0
    elsif item.name == "Conjured Mana Cake"
      2.times { decrease_quality(item) }
    elsif item.name != "Sulfuras, Hand of Ragnaros"
      decrease_quality(item)
    end
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
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
