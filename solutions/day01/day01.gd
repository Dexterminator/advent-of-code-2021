extends Node2D
onready var screen_size = get_viewport_rect().size
onready var label = $ShakeCamera2D/Label
onready var sprite = $Sprite
onready var camera = $ShakeCamera2D
onready var line = $Line2D
var x = 50
var current_depth = 0

func _process(_delta):
	camera.global_position.x = $Sprite.global_position.x - 100
	camera.global_position.y = $Sprite.global_position.y - 100
	x += 10
	sprite.global_position.x = x - 400
	line.add_point(Vector2(x, current_depth))
	while line.get_point_count() > 100:
		line.remove_point(0)

# VISUALIZATION
func update_viz(count, depth):
	var tmp = current_depth
	current_depth = depth * 5
	var anima := Anima.begin(self)
	anima.then({node=sprite, property="y", to=current_depth - 200, duration=0.7, easing=Anima.EASING.EASE_IN_OUT_CUBIC})
	anima.with({node=sprite, property="rotation", to=(current_depth - tmp)/3, duration=0.3})
	anima.then({node=sprite, property="rotation", to=0, duration=0.1, easing=Anima.EASING.EASE_IN_OUT_CUBIC})
	anima.play()

	yield(anima, "animation_completed")
	label.text = "COUNT: %s" % count

# SOLUTION
func part1(depths):
	var count = 0
	for i in range(1, len(depths)):
		if depths[i] > depths[i-1]:
			count += 1
		yield(update_viz(count, depths[i]), "completed")
	return count

func part2(depths):
	var count = 0
	for i in range(1, len(depths) - 2):
		var prev_depth_sum = depths[i-1] + depths[i] + depths[i+1]
		var depth_sum = depths[i] + depths[i+1] + depths[i+2]
		if depth_sum > prev_depth_sum:
			count += 1
	return count

func solve():
	var text = Utils.slurp("res://solutions/day01/input.txt")
	var depths = []
	for line in text.split("\n"): depths.push_back(int(line))
	print(part1(depths))
	print(part2(depths))

func _ready():
	$Line2D.remove_point(0)
	solve()
