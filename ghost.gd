extends CharacterBody2D

@export var wander_speed: float = 45.0
@export var chase_speed: float = 95.0
@export var chase_range: float = 250.0

var player: Node2D
var frozen: bool = false
var wander_direction := Vector2.RIGHT

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pick_new_direction()

func _physics_process(delta: float) -> void:
	if frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if player and global_position.distance_to(player.global_position) <= chase_range:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * chase_speed
	else:
		velocity = wander_direction * wander_speed

	move_and_slide()

	if is_on_wall():
		pick_new_direction()

func pick_new_direction() -> void:
	wander_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func freeze_mob() -> void:
	frozen = true

func unfreeze_mob() -> void:
	frozen = false
