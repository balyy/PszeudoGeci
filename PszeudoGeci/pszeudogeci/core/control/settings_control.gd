extends Control


func _on_close_button_pressed() -> void:
	%SettingsPanelContainer.visible = false


func _on_show_input_check_button_toggled(toggled_on: bool) -> void:
	Settings.toggle_show_input(toggled_on)


func _on_show_output_check_button_toggled(toggled_on: bool) -> void:
	Settings.toggle_show_output(toggled_on)


func _on_show_first_line_check_button_toggled(toggled_on: bool) -> void:
	Settings.toggle_show_first_line(toggled_on)


func _on_show_settings_button_pressed() -> void:
	%SettingsPanelContainer.visible = true
