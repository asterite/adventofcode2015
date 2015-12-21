record Player, hit_points, damage, armor, cost
record Equipment, cost, damage, armor

def new_player(hit_points, equipment)
  Player.new(hit_points,
    equipment.sum(&.damage),
    equipment.sum(&.armor),
    equipment.sum(&.cost))
end

def turns(a, b)
  damage = {a.damage - b.armor, 1}.max
  (b.hit_points.fdiv(damage)).ceil
end

def wins?(player, boss)
  turns(player, boss) <= turns(boss, player)
end

weapons = [
  Equipment.new(8, 4, 0),
  Equipment.new(10, 5, 0),
  Equipment.new(25, 6, 0),
  Equipment.new(40, 7, 0),
  Equipment.new(74, 8, 0),
]

armors = [
  Equipment.new(13, 0, 1),
  Equipment.new(31, 0, 2),
  Equipment.new(53, 0, 3),
  Equipment.new(75, 0, 4),
  Equipment.new(102, 0, 5),
]

rings = [
  Equipment.new(25, 1, 0),
  Equipment.new(50, 2, 0),
  Equipment.new(100, 3, 0),
  Equipment.new(20, 0, 1),
  Equipment.new(40, 0, 2),
  Equipment.new(80, 0, 3),
]

boss = Player.new(104, 8, 1, 0)

max = 0
weapons.each do |weapon|
  (0..1).each do |armor_comb|
    armors.each_combination(armor_comb) do |armors|
      (0..2).each do |ring_comb|
        rings.each_combination(ring_comb) do |rings|
          player = new_player(100, [weapon] + armors + rings)
          if player.cost > max && !wins?(player, boss)
            max = player.cost
          end
        end
      end
    end
  end
end
puts max
