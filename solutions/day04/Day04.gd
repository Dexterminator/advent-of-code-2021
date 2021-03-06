extends Node2D

onready var BingoBoard = preload("res://solutions/day04/BingoBoard.tscn")
onready var board_grid = $BoardGrid
onready var octopus = $Octopus
var is_part1 = true
var example_input = """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""

func part1(nums, board):
	pass

func solve():
	var input = Utils.slurp("res://solutions/day04/input.txt")
	var parts = Array(input.split("\n\n"))
	var nums = []
	for x in parts[0].split(","):
		nums.push_back(x)

	var boards = []
	for board_string in parts.slice(1, len(parts)):
		board_string = board_string.strip_edges()
		var board = []
		var board_lines = board_string.split("\n")
		for line_string in board_lines:
			var line = []
			var matches = Utils.regex_list(line_string, "\\d+")
			for m in matches: line.push_back(int(m))
			board.push_back(line)
		boards.push_back(board)
	
	for b in boards:
		var board = BingoBoard.instance()
		board_grid.add_child(board)
		board.init(b)
	
	for num in nums:
		get_tree().call_group("boards", "light_up_square", num)
		yield(get_tree().create_timer(0.2), "timeout")

func _ready():
	var a = Anima.begin(self)
	a.then({node=octopus, property="x", duration=1, to=100, relative=true})
	a.then({node=octopus, property="x", duration=1, to=-100, relative=true})
	a.loop()

	solve()
