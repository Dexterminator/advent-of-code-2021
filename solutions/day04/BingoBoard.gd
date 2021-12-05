extends VBoxContainer

var square_by_num = {}
var row_counts = [0, 0, 0, 0, 0]
var column_counts = [0, 0, 0, 0, 0]
var bingo = false
var done = false
var highest_count = 0

func init(board):
	modulate = Color(1,1,1,0.3)
	var hboxes = get_children()
	for y in 5:
		var squares = hboxes[y].get_children()
		for x in 5:
			var num = str(board[y][x])
			squares[x].num = int(num)
			squares[x].x = x
			squares[x].y = y
			squares[x].text = num if len(num) == 2 else " %s" % num
			square_by_num[num] = squares[x]


func fade():
	done = true
	if not bingo:
		var a = Anima.begin(self)
		a.then({node=self, property="modulate", duration=1, to=Color(1,1,1,0)})
		a.play()

func get_score(win_num):
	var sum = 0
	var hboxes = get_children()
	for y in 5:
		var squares = hboxes[y].get_children()
		for x in 5:
			if squares[x].modulate == Color.white:
				sum += squares[x].num
	return sum * int(win_num)

func light_up_square(num):
	if done:
		return
	if num in square_by_num:
		var square = square_by_num[num]
		square.modulate = Color.lightgreen
		row_counts[square.y] += 1
		column_counts[square.x] += 1
		highest_count = [highest_count, row_counts[square.y], row_counts[square.x]].max()
		var a = Anima.begin(self)
		a.then({node=self, property="modulate", duration=0.2, to=Color(1,1,1,0.3+(highest_count*0.14))})
		a.play()

		if row_counts[square.y] == 5 or column_counts[square.x] == 5:
			bingo = true
			done = true
			print(get_score(num))
			get_tree().call_group("boards", "fade")
