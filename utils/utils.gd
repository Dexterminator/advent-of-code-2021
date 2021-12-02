extends Node

func random_choice(arr):
	return arr[randi() % arr.size()]

func slurp(file_name):
	var file = File.new()
	file.open(file_name, file.READ)
	var text = file.get_as_text().strip_edges()
	file.close()
	return text
