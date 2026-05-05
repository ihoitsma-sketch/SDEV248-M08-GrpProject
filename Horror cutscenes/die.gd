extends CanvasLayer

@onready var label: RichTextLabel = $Panel/RichTextLabel


var typing_speed = 15.0
var char_progress = 0.0
signal typing_finished

func _ready():
	label.text = """ You weren't able to escape, and succumbed to the same fate as every other explorer that entered these forsaken walls.
	
	Or did you?
	
	You wake up, miles away from the fence you once crossed to enter the contaminated zone.
	
	How did you end up here?
	
	Dirty, tattered....
	
	But still alive.
	
	You're sure you were about to die....
	
	Did you dream the whole thing?
	
	You're not sure, but there's one thing you do know....
	
	You need answers.
	
	Try again?
	
"""
	label.visible_characters = 0.0
	char_progress = 0.0
	$Music.play()
	

func _process(delta):
	char_progress += typing_speed * delta
	var new_visible := int(char_progress)
	
	if new_visible > label.visible_characters:
		label.visible_characters = new_visible
		
		if label.visible_characters >= label.get_total_character_count():
			label.visible_characters = label.get_total_character_count()
			emit_signal("typing_finished")
			set_process(false)
