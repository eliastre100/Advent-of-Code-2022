require_relative '../helpers/helpers'

content = File.read(ARGV[0])

# A => Rock
# B => Paper
# C => Scissors
# X => Rock
# Y => Paper
# Z => Scissors

ACTION_SCORE = {
  X: 1,
  Y: 2,
  Z: 3
}

MATCH_SCORE = {
  AX: 3,
  AY: 6,
  AZ: 0,
  BX: 0,
  BY: 3,
  BZ: 6,
  CX: 6,
  CY: 0,
  CZ: 3
}

puts content.split("\n")
       .map { |actions| actions.split(" ").join }
       .map { |actions| ACTION_SCORE[actions[1].to_sym] + MATCH_SCORE[actions.to_sym] }
       .sum



