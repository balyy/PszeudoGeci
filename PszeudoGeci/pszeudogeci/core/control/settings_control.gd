extends Control


func _on_close_button_pressed() -> void:
	%SettingsPanelContainer.visible = false


func _on_show_input_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Settings.show_input = true
	else:
		Settings.show_input = false


func _on_show_output_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Settings.show_output = true
	else:
		Settings.show_output = false


func _on_show_first_line_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Settings.show_first_line = true
	else:
		Settings.show_first_line = false


func _on_show_settings_button_pressed() -> void:
	%SettingsPanelContainer.visible = true
