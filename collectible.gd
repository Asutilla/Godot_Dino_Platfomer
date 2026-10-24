
extends Area2D

@export var item_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if item_texture != null:
		sprite.texture = item_texture
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	# Only collect the item if the body supports collecting.
	if body.has_method("collect_item"):
		body.call("collect_item")
		queue_free()
