
extends Area2D

@export var speed: float = 100.0
@export var patrol_distance: float = 150.0

var direction: float = 1.0
var start_x: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	start_x = position.x
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position.x += direction * speed * delta

	# Turn around at the patrol limits.
	if position.x >= start_x + patrol_distance:
		direction = -1.0
	elif position.x <= start_x - patrol_distance:
		direction = 1.0

	# Make the sprite face the walking direction.
	sprite.flip_h = direction < 0


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var game_over = get_tree().current_scene.get_node_or_null("GameOver")
		if game_over:
			game_over.show_game_over()
