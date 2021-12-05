extends Node2D

func nums_between(n1, n2):
	var delta = n1 - n2
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

func add_coord_count(count_by_coord, coord):
	count_by_coord[coord] = count_by_coord.get(coord, 0) + 1

func add_diagonal_coord_counts(count_by_coord, x1, x2, y1, y2):
	var x_nums_between = nums_between(x1, x2)
	var y_nums_between = nums_between(y1, y2)
	for i in len(x_nums_between):
		add_coord_count(count_by_coord, "%s,%s" % [x_nums_between[i], y_nums_between[i]])

func add_horizontal_coord_counts(count_by_coord, x1, x2, y1, y2):
	if x1 == x2:
		for y in nums_between(y1, y2):
			add_coord_count(count_by_coord, "%s,%s" % [x1, y])
	elif y1 == y2:
		for x in nums_between(x1, x2):
			add_coord_count(count_by_coord, "%s,%s" % [x, y1])

func part2(lines):
	var count_by_coord = {}
	for line in lines:
		var x1 = int(line[0])
		var y1 = int(line[1])
		var x2 = int(line[2])
		var y2 = int(line[3])

		if x1 != x2 and y1 != y2:
			add_diagonal_coord_counts(count_by_coord, x1, x2, y1, y2)
		else:
			add_horizontal_coord_counts(count_by_coord, x1, x2, y1, y2)

	return get_score(count_by_coord)

func part1(lines):
	var count_by_coord = {}
	for line in lines:
		var x1 = int(line[0])
		var y1 = int(line[1])
		var x2 = int(line[2])
		var y2 = int(line[3])

		if x1 == x2 or y1 == y2:
			add_horizontal_coord_counts(count_by_coord, x1, x2, y1, y2)

	return get_score(count_by_coord)

func solve():
	var input = Utils.slurp("res://solutions/day05/input.txt")
	var lines = Utils.regex_group_list(input, "(\\d+),(\\d+) -> (\\d+),(\\d+)")
	print(part1(lines))
	print(part2(lines))

func _ready():
	solve()
