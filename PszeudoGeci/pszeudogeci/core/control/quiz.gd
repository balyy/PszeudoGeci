extends Control

@export var pseudo : Pseudo

func _ready() -> void:
	%NameLabel.text = pseudo.name
	apply_settings()
	Signalbus.check.connect(show_solution)

func apply_settings():
	if Settings.show_input:
		%InputLineEdit.text = pseudo.input
	if Settings.show_output:
		%OutputLineEdit.text = pseudo.output
	if Settings.show_first_line:
		%LinesTextEdit.text = pseudo.lines[0]

# Segédfüggvény a szöveg tisztítására (tedd a fájl végére vagy elejére)
func get_clean_string(text: String) -> String:
	var clean = text.to_lower()
	# Minden szóközt, tabot és speciális karaktert kiszedünk
	clean = clean.replace(" ", "").replace("\t", "").replace("\r", "").replace("\n", "")
	return clean

func show_solution():
	# 1. Töröljük a megoldás dobozt
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

	# 3. Végigmegyünk a sorokon
	for i in range(pseudo.lines.size()):
		var raw_line = pseudo.lines[i].c_unescape()
		
		# A felhasználó sora (ha létezik)
		var user_line = ""
		if i < %LinesTextEdit.get_line_count():
			user_line = %LinesTextEdit.get_line(i)
		
		# --- DEBUGGER ---
		# Ha pirosnak jelzi, nézd meg a Godot alsó "Output" fülét!
		# Ott látni fogod, pontosan mi a különbség a gép szerint.
		var clean_user = get_clean_string(user_line)
		var clean_correct = get_clean_string(raw_line)
		
		if clean_user != clean_correct:
			print("--- ELTÉRÉS A " + str(i+1) + ". SORBAN ---")
			print("Te írtad (nyers): '" + user_line + "'")
			print("Te írtad (clean): '" + clean_user + "'")
			print("Helyes (clean):   '" + clean_correct + "'")
		# ----------------
		
		# A megjelenítéshez "hatástalanítjuk" a BBCode-ot (zárójelek cseréje)
		var safe_text = raw_line.replace("[", "[lb]") 
		
		# Összehasonlítás a "csontváz" (clean) szövegekkel
		if clean_user == clean_correct:
			# HA EGYEZIK: Fehér
			%ScriptSolution.append_text(safe_text + "\n")
		else:
			# HA NEM EGYEZIK: Piros
			%ScriptSolution.append_text("[color=#FF5555]" + safe_text + "[/color]\n")
	
	# Megjelenítés kapcsolása
	%SolutionContainer.visible = !%SolutionContainer.visible

#func show_solution():
	#%InputSolution.clear()
	#if %InputLineEdit.text != pseudo.input:
		#%InputSolution.append_text("[color=#FF5555]Bemenet: " + pseudo.input + "[/color]")
	#else:
		#%InputSolution.text = "Bemenet: " + pseudo.input
	#
	#%OutputSolution.clear()
	#if %OutputLineEdit.text != pseudo.output:
		#%OutputSolution.append_text("[color=#FF5555]Kimenet: " + pseudo.output + "[/color]")
	#else:
		#%OutputSolution.text = "Kimenet: " + pseudo.output
	#
	#%ScriptSolution.clear()
	#for i in range(pseudo.lines.size()):
		#var text_line = pseudo.lines[i].c_unescape().replace("[", "[lb]")
		#if get_clean_string(%LinesTextEdit.get_line(i).strip_edges()) != get_clean_string(pseudo.lines[i].strip_edges()):
			#%ScriptSolution.append_text("[color=#FF5555]" + text_line + "[/color]\n")
		#else:
			#%ScriptSolution.append_text(text_line + "\n")
	#
	#if %SolutionContainer.visible == false:
		#%SolutionContainer.visible = true
	#else:
		#%SolutionContainer.visible = false


#func get_clean_string(text: String) -> String:
	#var clean = text.to_lower()
	#clean = clean.replace(" ", "").replace("\t", "")
	#return clean
