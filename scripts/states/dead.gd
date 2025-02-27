extends State

func enter():
	parent.killzone.get_node('KillzoneTimer').start()
	parent.animations.play('jump')
	parent.velocity = Vector2(0,0)



func physics_update(delta):
	pass

	
func update(_delta):
	pass
