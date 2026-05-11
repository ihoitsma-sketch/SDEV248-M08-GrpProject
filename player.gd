extends CharacterBody2D

@export var speed: float = 180.0
@export var flashlight_hold_offset := Vector2(0, 0)

@onready var flashlight_pivot: Node2D = $FlashlightPivot
@onready var beam_sprite: Sprite2D = $FlashlightPivot/BeamSprite

func _ready() -> void:
	#beam_sprite.centered = false
#	beam_sprite.position = Vector2.ZERO
	#beam_sprite.rotation = 0
	return

func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider().get('name')
		
		if collider == 'ghost':
			queue_free()
			get_tree().change_scene_to_file("res://SDEV248-M08-GrpProject-main/Horror cutscenes/die.tscn")
		if collider == 'mutant':
			queue_free()
			get_tree().change_scene_to_file("res://SDEV248-M08-GrpProject-main/Horror cutscenes/die.tscn")
	
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = mouse_pos - global_position
	
	if direction_to_mouse != Vector2.ZERO:
		$Pivot.rotation = direction_to_mouse.angle() + deg_to_rad(175)

#	flashlight_pivot.position = flashlight_hold_offset

	#var angle = (get_global_mouse_position() - flashlight_pivot.global_position).angle()
	#flashlight_pivot.rotation = angle


func _on_flashlight_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and body.freeze == false:
		body.freeze = true


func _on_flashlight_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies") and body.freeze == true:
		body.freeze = false
