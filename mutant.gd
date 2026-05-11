extends CharacterBody2D
@export var patrol_speed: float = 60.0
@export var chase_speed: float = 130.0
@export var chase_range: float = 220.0

var player: Node2D
var frozen: bool = false
var direction := -1

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if player and global_position.distance_to(player.global_position) <= chase_range:
		var chase_direction = sign(player.global_position.x - global_position.x)
		velocity.x = chase_direction * chase_speed
	else:
		velocity.x = direction * patrol_speed

	velocity.y += 900 * delta

	move_and_slide()

	if is_on_wall():
		direction *= -1
		
func freeze_mob() -> void:
	frozen = true

func unfreeze_mob() -> void:
	frozen = false
