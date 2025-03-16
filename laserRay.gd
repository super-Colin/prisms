extends RayCast2D


signal reflectNeeded

var extendingRay:Node2D
var extendingRays:Array[Node2D] = []
var extended = false

var updateEveryXFrames = 10
var updateFrameCounter = 0

var laserRayScene = preload("res://laser_ray.tscn")


func _physics_process(delta: float) -> void:
	if Globals.currentLevelBeaten:
		return
	var collider = $'.'.get_collider()
	if collider == null:
		if extended:
			for ray in extendingRays:
				ray.queue_free()
			extended = false
		return
	if not "reflectable" in collider:
		return
	#extendingRay.position = $'.'.get_collision_point()
	updateFrameCounter += 1
	if updateFrameCounter == updateEveryXFrames:
		updateFrameCounter = 0
		for ray in extendingRays:
			if ray:
				ray.free()
		#extendingRay.free()
		extended = false
	if not extended:
		if "isGoal" in collider:
			if collider.isGoal:
				print("hit goal!")
				collider.goalHit($'.')
				return
		#reflectNeeded.emit()
		#if collider.reflectInternal:
		var currentExtension = 1
		for n in collider.splits:
			extendingRay = extendRay(collider)
			#extendingRay.collision_mask = collider.nextLayer
			extendingRays.append(extendingRay)
			$'.'.add_child(extendingRay)
			if collider.splits > 1:
				if currentExtension < (collider.splits/2):
					var splitAngle = (collider.angle / collider.splits) # 90 / 2 = 45
					splitAngle *= currentExtension # 45 and 90
					splitAngle -= collider.angle / 2
					extendingRay.target_position = extendingRay.target_position.rotated(splitAngle)
			currentExtension += 1
		extended = true
		if "isGoal" in collider:
			if collider.isGoal:
				collider.goalHit($'.')

	#print(extendingRay.extended)



#func extendRay(internal=true):
func extendRay(colliderArea):
	#var newRay = $'.'.duplicate()
	var newRay = laserRayScene.instantiate()
	#var newRay = theRay.duplicate()
	newRay.position = $'.'.get_collision_point() - $'.'.global_position
	if colliderArea.reflectInternal:
		var twistAngle = (-PI/24) + ($'.'.get_collision_normal() * -1).angle()
		newRay.target_position = $'.'.target_position.rotated(twistAngle)
		#print($'.'.get_collision_normal().angle(), ", ", twistAngle)
	elif colliderArea.reflectExternal:
		#newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal())
		newRay.target_position = $'.'.target_position.rotated($'.'.get_collision_normal())

	#newRay.collision_mask = colliderArea.nextLayer
	#print("laser - extended: ", $'.'.get_collision_point(), ", ", newRay.position)
	return newRay
