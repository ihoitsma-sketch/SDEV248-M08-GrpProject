extends CanvasLayer

@onready var label: RichTextLabel = $Panel/RichTextLabel

var typing_speed = 15.0
var char_progress = 0.0
signal typing_finished

func _ready():
	label.text = """ Chernobyl was never meant to be silent like this.
	
On April 26, 1986, Reactor 4 of the Chernobyl Nuclear Power Plant exploded, releasing radioactive contamination across more than 58,000 square miles.

They said people came here chasing stories.

Urban explorers. Journalists. Drifters.

None of them came back.

No bodies. No signals. No clues.

Just… gone.

You step over a rusted fence, its warning signs long since faded and unreadable. The Geiger counter at your side crackles faintly—just enough to remind you that this place is still very much alive.

Ahead, half-swallowed by encroaching forest, the facility looms. Some sort of warehouse, from what you can tell. Concrete walls split by time. Windows staring out like hollow eyes. Something about it feels wrong—like it’s watching you.

You check your gear. Flashlight. Camera. Radio.

All working.

For now.

A low hum vibrates through the air—subtle, unnatural. It wasn’t on any of the reports.
You hesitate.

Just for a moment.

Then you step forward.

Because whatever happened here—

You’re going to find it.

[OBJECTIVE: ENTER THE FACILITY]"""
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
