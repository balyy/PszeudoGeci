extends Control

@export var pseudo : Pseudo

func _ready() -> void:
	%NameLabel.text = pseudo.name
	apply_settings()
	Signalbus.check.connect(show_solution)
	Signalbus.settings_changed.connect(apply_settings)

func apply_settings():
	if Settings.show_input:
		%InputLineEdit.text = pseudo.input
	if Settings.show_output:
		%OutputLineEdit.text = pseudo.output
	if Settings.show_first_line:
		%LinesTextEdit.text = pseudo.lines[0]


func get_clean_string(text: String) -> String:
	var clean = text.to_lower()
	clean = clean.replace(" ", "").replace("\t", "").replace("\r", "").replace("\n", "")
	return clean

func show_solution():
	%ScriptSolution.clear()
	
	%InputSolution.clear()
	if %InputLineEdit.text != pseudo.input:
		%InputSolution.append_text("[color=#FF5555]Bemenet: " + pseudo.input + "[/color]")
	else:
		%InputSolution.text = "Bemenet: " + pseudo.input
	
	%OutputSolution.clear()
	if %OutputLineEdit.text != pseudo.output:
		%OutputSolution.append_text("[color=#FF5555]Kimenet: " + pseudo.output + "[/color]")
	else:
		%OutputSolution.text = "Kimenet: " + pseudo.output

	for i in range(pseudo.lines.size()):
		var raw_line = pseudo.lines[i].c_unescape()
		
		var user_line = ""
		if i < %LinesTextEdit.get_line_count():
			user_line = %LinesTextEdit.get_line(i)
		
		
		var clean_user = get_clean_string(user_line)
		var clean_correct = get_clean_string(raw_line)
		
		if clean_user != clean_correct:
			print("--- ELTÉRÉS A " + str(i+1) + ". SORBAN ---")
			print("Te írtad (nyers): '" + user_line + "'")
			print("Te írtad (clean): '" + clean_user + "'")
			print("Helyes (clean):   '" + clean_correct + "'")
		
		var safe_text = raw_line.replace("[", "[lb]") 
		
		
		if clean_user == clean_correct:
			%ScriptSolution.append_text(safe_text + "\n")
		else:
			%ScriptSolution.append_text("[color=#FF5555]" + safe_text + "[/color]\n")
	
	%SolutionContainer.visible = !%SolutionContainer.visible
