
extends CanvasLayer

@onready var retry_button: Button = $ColorRect/CenterContainer/VBoxContainer/RetryButton


func _ready() -> void:
	visible = false
	retry_button.pressed.connect(_on_retry_pressed)


func show_game_over() -> void:
	visible = true
	get_tree().call_group("player", "set_physics_process", false)
	get_tree().call_group("player", "set_process_input", false)


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
