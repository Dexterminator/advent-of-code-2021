extends Node

func random_choice(arr):
	return arr[randi() % arr.size()]

func slurp(file_name):
	var file = File.new()
	file.open(file_name, file.READ)
	var text = file.get_as_text().strip_edges()
	file.close()
	return text

func regex_list(s, re):
	var regex = RegEx.new()
	regex.compile(re)
	var matches = regex.search_all(s)
	var res = []
	for m in matches: res.push_back(m.get_string())
	return res

func regex_group_list(s, re):
	var regex = RegEx.new()
	regex.compile(re)
	var matches = regex.search_all(s)
	var res = []
	for m in matches:
		var match_groups = []
		for i in range(1, m.get_group_count()+1):
			match_groups.push_back(m.get_string(i))
		res.push_back(match_groups)
	return res
