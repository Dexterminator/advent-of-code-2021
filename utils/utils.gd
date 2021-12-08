extends Node

const MIN_INT = -9223372036854775808
const MAX_INT = 9223372036854775807

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

func visualize(viz_steps, inst):
	for step in viz_steps:
		var func_name = step[0]
		var args = step.slice(1, len(step))
		var f = funcref(inst, func_name).call_funcv(args)
		if f is GDScriptFunctionState:
			yield(f, "completed")

class Set:
	var _dict

	func _init():
		_dict = {}

	func add(x):
		_dict[x] = x

	func add_all(coll):
		for x in coll:
			_dict[x] = x

	func size():
		return len(_dict)
