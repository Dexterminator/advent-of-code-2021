extends Node2D

func simulate(count_by_timer):
	var new_fish = count_by_timer[0]
	for i in len(count_by_timer)-1:
		count_by_timer[i] = count_by_timer[i+1]
	count_by_timer[6] += new_fish
	count_by_timer[8] = new_fish

func get_fish_count(nums, n):
	var count_by_timer = []
	for _i in 9: count_by_timer.push_back(0)
	for n in nums: count_by_timer[n] += 1
	for _i in n: simulate(count_by_timer)
	var sum = 0
	for n in count_by_timer: sum += n
	return sum

func part1(nums):
	return get_fish_count(nums, 80)

func part2(nums):
	return get_fish_count(nums, 256)

func solve():
	var input = Utils.slurp("res://solutions/day06/input.txt")
	var nums = []
	for n in input.split(","): nums.push_back(int(n))
	print(part1(nums))
	print(part2(nums))

func _ready():
	solve()
