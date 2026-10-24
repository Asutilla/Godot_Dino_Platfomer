
extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -450.0

var gravity: float = float(
	ProjectSettings.get_setting("physics/2d/default_gravity")
)

var collected: int = 0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collected_label: Label = $Camera2D2/HUD/CollectedLabel
@onready var reset_button: Button = $Camera2D2/HUD/ResetButton

func _ready() -> void:
	collected_label.text = "Collected: 0"
	reset_button.pressed.connect(_on_reset_button_pressed)


func _physics_process(delta: float) -> void:
	# Apply gravity while in the air.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Read left and right movement.
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	# Jump only when standing on the ground.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Move the player and resolve collisions.
	move_and_slide()

	# Face the direction of movement.
	if direction != 0:
		sprite_2d.flip_h = direction < 0

	# Choose the correct animation.
	if not is_on_floor():
		change_animation("jumping")
	elif abs(velocity.x) > 1:
		change_animation("running")
	else:
		change_animation("idle")


func collect_item() -> void:
	collected += 1
	collected_label.text = "Collected: " + str(collected)


func change_animation(animation_name: StringName) -> void:
	# Avoid restarting the same animation every physics frame.
	if sprite_2d.animation != animation_name:
		sprite_2d.play(animation_name)
		
func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()
