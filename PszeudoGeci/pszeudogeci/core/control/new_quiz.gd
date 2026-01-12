extends Control



func _on_button_pressed() -> void:
	Signalbus.new_quiz.emit()
