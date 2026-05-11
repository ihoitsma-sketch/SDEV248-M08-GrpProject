extends Area2D
func _on_body_entered(body):
	if body.has_method("freeze_mob"):
		body.freeze_mob()

func _on_body_exited(body):
	if body.has_method("unfreeze_mob"):
		body.unfreeze_mob()
