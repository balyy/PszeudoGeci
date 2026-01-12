extends Node

const PSEUDO_DIR = "res://core/pseudo/pseudo_list/"
var pseudo_list : Array[Pseudo]

func _ready() -> void:
	load_all_pseudos()
	Signalbus.new_quiz.connect(load_random_pseudo)
	

func load_all_pseudos() -> void:
	var dir = DirAccess.open(PSEUDO_DIR)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if !dir.current_is_dir():
				
				
				var final_file_name = file_name
				if final_file_name.ends_with(".remap"):
					final_file_name = final_file_name.trim_suffix(".remap")
				
			
				if final_file_name.ends_with(".tres"):
					
					var resource = load(PSEUDO_DIR + final_file_name)
					
					
					if resource is Pseudo:
						pseudo_list.append(resource)
						print("Betöltve: ", final_file_name)
			
			
			file_name = dir.get_next()
	else:
		print("Hiba: Nem található a könyvtár: " + PSEUDO_DIR)

func load_random_pseudo():
	if %CurrentQuiz.get_child_count() != 0:
		for child in %CurrentQuiz.get_children():
			child.queue_free()
	
	var new_quiz = load("res://core/control/quiz.tscn").instantiate()
	new_quiz.pseudo = pseudo_list.pick_random()
	%CurrentQuiz.add_child(new_quiz)
