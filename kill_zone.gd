
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var game_over = get_tree().current_scene.get_node_or_null("GameOver")
		if game_over:
			game_over.show_game_over()
