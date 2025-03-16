extends RayCast2D


signal reflectNeeded

var extendingRay:Node2D
var extended = false

var updateEveryXFrames = 40
var updateFrameCounter = 0

func _physics_process(delta: float) -> void:
	var collider = $'.'.get_collider()
	if collider == null:
		if extended:
			extendingRay.queue_free()
			extended = false
		return
	if not "reflectable" in collider:
		return
	#extendingRay.position = $'.'.get_collision_point()
	updateFrameCounter += 1
	if updateFrameCounter == updateEveryXFrames:
		updateFrameCounter = 0
		extendingRay.free()
		extended = false
	if not extended:
		if "isGoal" in collider:
			if collider.isGoal:
				print("hit goal!")
				collider.goalHit($'.')
				return
		reflectNeeded.emit()
		#if collider.reflectInternal:
		extendingRay = extendRay(collider)
		extendingRay.collision_mask = collider.nextLayer
		$'.'.add_child(extendingRay)
		extended = true
		if "isGoal" in collider:
			if collider.isGoal:
				print("hit goal!")
				collider.goalHit($'.')

	#print(extendingRay.extended)



#func extendRay(internal=true):
func extendRay(colliderArea):
	var newRay = $'.'.duplicate()
	#var newRay = theRay.duplicate()
	newRay.position = $'.'.get_collision_point() - $'.'.global_position
	if colliderArea.reflectInternal:
		#newRay.target_position = $'.'.target_position.rotated(colliderArea.internalAngle + ($'.'.get_collision_normal().angle() * -1) )
		#newRay.target_position = $'.'.target_position.rotated(colliderArea.internalAngle + ($'.'.get_collision_normal().angle() ) * -1 )
		#newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal().angle() * -1)
		#newRay.target_position = $'.'.target_position.rotated( (-PI/24))
		#var twistAngle = (-PI/24) + $'.'.get_collision_normal().angle() * -1
		var twistAngle = (-PI/24) + ($'.'.get_collision_normal() * -1).angle()
		newRay.target_position = $'.'.target_position.rotated(twistAngle)
		print($'.'.get_collision_normal().angle(), ", ", twistAngle)
		#newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal().angle())
	elif colliderArea.reflectExternal:
		#newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal())
		newRay.target_position = $'.'.target_position + $'.'.get_collision_normal()

	newRay.collision_mask = colliderArea.nextLayer
	#print("laser - extended: ", $'.'.get_collision_point(), ", ", newRay.position)
	return newRay
