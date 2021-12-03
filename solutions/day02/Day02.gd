extends Node2D

onready var sub = $Sub
onready var camera = $ShakeCamera2D
onready var label = camera.get_node("Label")
onready var anim = $Sub/AnimationPlayer
onready var particles = $Sub/Particles2D
const UNIT_SIZE = 10

func update_viz(x, y):
	var new_pos = Vector2(x*UNIT_SIZE, y*UNIT_SIZE + 20)
	if new_pos.x > sub.global_position.x:
		particles.emitting = true
		anim.play("propeller")
	else:
		particles.emitting = false
		anim.play("default")
	var distance = sub.global_position.distance_to(new_pos)
	var a = Anima.begin(self)
	a.then({node=sub, property="position", to=new_pos, duration=distance/100, easing=Anima.EASING.EASE_IN_OUT_CUBIC})
	if new_pos.x > sub.global_position.x:
		a.with({node=sub, property="scale", to=Vector2(1.1,0.9), duration=0.1, easing=Anima.EASING.EASE_IN_OUT_CUBIC})
		a.with({node=sub, property="scale", to=Vector2.ONE, duration=0.1, delay=0.1, easing=Anima.EASING.EASE_IN_OUT_CUBIC})
	a.play()
	yield(a, "animation_completed")
	label.text = "DEPTH: %s, X: %s" % [y, x]

func part1(instructions):
	var x = 0
	var y = 0
	for instruction in instructions:
		match instruction:
			["forward", var n]: x += n
			["down", var n]: y += n
			["up", var n]: y -= n
		yield(update_viz(x, y), "completed")
	return x * y

func part2(instructions):
	var x = 0
	var y = 0
	var aim = 0
	for instruction in instructions:
		match instruction:
			["forward", var n]:
				x += n
				y += aim * n
			["down", var n]: aim += n
			["up", var n]: aim -= n
	return x * y

func solve():
	var text = Utils.slurp("res://solutions/day02/input.txt")
	var instructions = []
	for line in text.split("\n"):
		var parts = line.split(" ")
		instructions.push_back([parts[0], int(parts[1])])
	print(part1(instructions))
	print(part2(instructions))

func _ready():
	solve()
