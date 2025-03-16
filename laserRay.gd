extends RayCast2D


signal reflectNeeded

var extendingRay:Node2D
var extended = false

func _physics_process(delta: float) -> void:
	var collider = $'.'.get_collider()
	if collider == null:
		if extended:
			extendingRay.queue_free()
		return
	if not "reflectable" in collider:
		return
	#extendingRay.position = $'.'.get_collision_point()
	if not extended:
		reflectNeeded.emit()
		extendingRay = extendRay()
		#print("children: ", $'.'.get_child_count())
		$'.'.add_child(extendingRay)
		extended = true
	print(extendingRay.extended)



func extendRay(internal=true):
	var newRay = $'.'.duplicate()
	#var newRay = theRay.duplicate()
	newRay.position = $'.'.get_collision_point() - $'.'.global_position
	if internal:
		newRay.target_position = $'.'.target_position.rotated(-PI/24)
		newRay.collision_mask = 2
	else:
		newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal())
	#print("laser - extended: ", $'.'.get_collision_point(), ", ", newRay.position)
	return newRay
