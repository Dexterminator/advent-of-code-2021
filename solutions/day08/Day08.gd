extends Node2D

var digit_by_segment_count = {2:1,4:4,3:7,7:8}

func part1(input):
	var easy_digit_count = 0
	for line in input.split("\n"):
		for sig in line.split("|")[1].split(" "):
			var set = Utils.Set.new()
			set.add_all(sig)
			if set.size() in digit_by_segment_count:
				easy_digit_count += 1
	return easy_digit_count

func solve():
	var input = Utils.slurp("res://solutions/day08/input.txt")
	print(part1(input))

func _ready():
	solve()
