extends Control


func _on_check_button_pressed() -> void:
	Signalbus.check.emit()
