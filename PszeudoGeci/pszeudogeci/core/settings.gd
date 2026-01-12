extends Node

var show_input: bool = false
func toggle_show_input(toggled_on: bool) -> void:
	show_input = toggled_on
	Signalbus.settings_changed.emit()


var show_output: bool = false
func toggle_show_output(toggled_on: bool) -> void:
	show_output = toggled_on
	Signalbus.settings_changed.emit()


var show_first_line: bool = false
func toggle_show_first_line(toggled_on: bool) -> void:
	show_first_line = toggled_on
	Signalbus.settings_changed.emit()
