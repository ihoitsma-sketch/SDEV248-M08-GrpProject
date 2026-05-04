extends CanvasLayer

@onready var label: RichTextLabel = $Panel/RichTextLabel


var typing_speed = 15.0
var char_progress = 0.0
signal typing_finished

func _ready():
	label.text = """ You've finally found a safe place to hide, with those.... things locked behind you.
	
	Are they why the others who have ventured into this facility never returned?
	
	Then there's the even more troubling question lingering in the back of your mind:
	
	Are there more ahead of you?
	
	You catch your breath, and think you see something.... glowing in the distance.
	
	And despite everything you've had to survive so far, it's quiet. The kind of quiet that shouldn't exist.
	
	But unfortunately the way back is through the locked door keeping you safe. You have only one option right now:
	
	Keep pushing forward.
	
	Maybe you'll find the answer you were looking for.
	
	And maybe you'll survive.

[OBJECTIVE: EXPLORE DEEPER INTO THE DEPTHS]"""
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
