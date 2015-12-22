abstract class Spell
  def initialize(@turns)
  end

  def apply(player, boss)
    effect(player, boss)
    @turns -= 1
  end

  def finished?
    @turns == 0
  end

  def clone
    self.class.new(@turns)
  end

  abstract def cost : Int32
  abstract def effect(player, boss)
end

class MagicMissile < Spell
  def initialize(turns = 1)
    super(turns)
  end

  def cost
    53
  end

  def effect(player, boss)
    boss.hit_points -= 4
  end
end

class Drain < Spell
  def initialize(turns = 1)
    super(turns)
  end

  def cost
    73
  end

  def effect(player, boss)
    boss.hit_points -= 2
    player.hit_points += 2
  end
end

class Shield < Spell
  def initialize(turns = 6)
    super(turns)
  end

  def cost
    113
  end

  def effect(player, boss)
    player.armor += 7 if @turns == 6
    player.armor -= 7 if @turns == 1
  end
end

class Poison < Spell
  def initialize(turns = 6)
    super(turns)
  end

  def cost
    173
  end

  def effect(player, boss)
    boss.hit_points -= 3
  end
end

class Recharge < Spell
  def initialize(turns = 5)
    super(turns)
  end

  def cost
    229
  end

  def effect(player, boss)
    player.mana += 101
  end
end

class Player
  property hit_points
  property mana
  property armor
  property spells
  property mana_used

  def initialize(@hit_points, @mana, @armor, @spells = [] of Spell, @mana_used = 0)
  end

  def apply_spells(boss)
    spells.each &.apply(self, boss)
    spells.reject! &.finished?
  end

  def clone
    Player.new(hit_points, mana, armor, spells.clone, mana_used)
  end
end

class Boss
  property hit_points
  property damage

  def initialize(@hit_points, @damage)
  end

  def clone
    Boss.new(hit_points, damage)
  end
end

def player_turn(player, boss, min)
  # Player turn
  player.hit_points -= 1
  if player.hit_points == 0
    # Loose (dead)
    return
  end

  player.apply_spells(boss)

  available_spells = {{ Spell.subclasses }}.map(&.new).select { |s| player.mana >= s.cost && !player.spells.any? { |ps| ps.class == s.class } }
  if available_spells.empty?
    # Loose (can't cast spells)
    return
  end

  # Try each spell in turn
  available_spells.each do |spell|
    # Cast, but use clones so later we can try a different spell
    # but with the same initial scenario
    cast(spell, player.clone, boss.clone, min)
  end
end

def cast(spell, player, boss, min)
  player.mana -= spell.cost
  player.spells << spell
  player.mana_used += spell.cost

  # Stop if we already exceeded the minimum so fr
  if player.mana_used >= min.value
    return
  end

  boss_turn(player, boss, min)
end

def boss_turn(player, boss, min)
  player.apply_spells(boss)

  if boss.hit_points <= 0
    # Victory
    if player.mana_used < min.value
      min.value = player.mana_used
    end
    return
  end

  player.hit_points -= {boss.damage - player.armor, 1}.max
  if player.hit_points <= 0
    # Loose (dead)
    return
  end

  player_turn(player, boss, min)
end

player = Player.new(50, 500, 0)
boss = Boss.new(71, 10)

min = Int32::MAX
player_turn(player, boss, pointerof(min))
puts min
