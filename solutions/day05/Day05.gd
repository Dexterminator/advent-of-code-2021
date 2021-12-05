extends Node2D

# var input = """0,9 -> 5,9
# 8,0 -> 0,8
# 9,4 -> 3,4
# 2,2 -> 2,1
# 7,0 -> 7,4
# 6,4 -> 2,0
# 0,9 -> 2,9
# 3,4 -> 1,4
# 0,0 -> 8,8
# 5,5 -> 8,2"""

func nums_between(n1, n2):
	var delta = n1 - n2
	if delta == 0:
		return null
	var s = -sign(delta)
	var nums = range(n1+s, n2, s)
	nums.push_back(n1)
	nums.push_back(n2)
	return nums

func get_score(count_by_coord):
	var score = 0
	for coord in count_by_coord:
		var count = count_by_coord[coord]
		if count >= 2:
			score += 1
	return score

func part1(lines):
	var count_by_coord = {}
	for line in lines:
		var x1 = int(line[0])
		var y1 = int(line[1])
		var x2 = int(line[2])
		var y2 = int(line[3])

		if x1 != x2 and y1 != y2:
			continue

		if x1 == x2:
			for y in nums_between(y1, y2):
				var coord = "%s,%s" % [x1, y]
				count_by_coord[coord] = count_by_coord.get(coord, 0) + 1
		elif y1 == y2:
			for x in nums_between(x1, x2):
				var coord = "%s,%s" % [x, y1]
				count_by_coord[coord] = count_by_coord.get(coord, 0) + 1

	return get_score(count_by_coord)

func solve():
	var input = Utils.slurp("res://solutions/day05/input.txt")
	var lines = Utils.regex_group_list(input, "(\\d+),(\\d+) -> (\\d+),(\\d+)")
	print(part1(lines))

func _ready():
	solve()
