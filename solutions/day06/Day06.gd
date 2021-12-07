extends Node2D

onready var fish_scool = $FishSchool
onready var new_fish_particles = $NewFish
onready var bar = $Bar
onready var count_label = $CountPivot/Count
onready var count_pivot = $CountPivot
var viz_steps = []

func update_viz(count, new_fish):
	count_pivot.global_position = Vector2(50, 250 - count * 0.001)
	count_label.text = str(count)
	new_fish_particles.amount = new_fish
	new_fish_particles.process_material.spread = new_fish * 0.01
	new_fish_particles.restart()
	var a = Anima.begin(self)
	var pos = Vector2(150, max(1, count * 0.001))
	a.then({node=bar, property="rect_size", to=pos, duration=0.5})
	a.play()
	yield(a, "animation_completed")

func append_sum(count_by_timer, new_fish):
	var sum = 0
	for n in count_by_timer: sum += n
	viz_steps.push_back(["update_viz", sum, new_fish])

func visualize():
	for step in viz_steps:
		var func_name = step[0]
		var args = step.slice(1, len(step))
		var f = funcref(self, func_name).call_funcv(args)
		if f is GDScriptFunctionState:
			yield(f, "completed")

func simulate(count_by_timer):
	var new_fish = count_by_timer[0]
	for i in len(count_by_timer)-1:
		count_by_timer[i] = count_by_timer[i+1]
	count_by_timer[6] += new_fish
	count_by_timer[8] = new_fish
	append_sum(count_by_timer, new_fish)

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
	# print(part2(nums))

func _ready():
	solve()
	visualize()
