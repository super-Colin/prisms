extends Node2D


@export var splits = 1
@export var angle = 90

var calledRefract = false
var notCalledRefractFrames = 0
var incomingRay
var internalRay:RayCast2D
var externalRay:RayCast2D


var reflectInternal = true






func _physics_process(delta: float) -> void:
	#createRefractionRaycast()
	if internalRay != null:
		var colliding = internalRay.is_colliding()
		if colliding:
			var collider = internalRay.get_collider()
			if "createRefractionRaycast" in collider:
				collider.createRefractionRaycast(internalRay)



#func handleRefraction(ray):
	#createRefractionRaycast(ray)
	##if ray == incomingRay:
	#if ray == internalRay or ray == externalRay:
		#print("prism - is incoming ray")
	#else:
	##pass
#
#
#
#
##func createRefractionRaycast(ray:RayCast2D)->void:
#func createRefractionRaycast(ray = null)->void:
	##if notCalledRefractFrames >= 240 and ray != null:
		##if internalRay != null:
			##internalRay.queue_free()
			##if externalRay != null:
				##externalRay.queue_free()
		##return
	#if ray == null:
		##notCalledRefractFrames += 1
		#return
	##calledRefract = true
	##print("prism - ray is: ", ray)
	##print("prism - global position is: ", $'.'.global_position)
	#var newRay = RayCast2D.new()
	##if internalRay:
		##print("prism - creating EXternal refraction")
		##externalRay = RayCast2D.new()
		##$'.'.add_child(externalRay)
		##currentRay = externalRay
	##if not internalRay:
	##else:
	#print("prism - creating internal refraction")
	#print("prism - internal ray: ", internalRay, ", != ", ray)
	#internalRay = RayCast2D.new()
	#$'.'.add_child(internalRay)
	#currentRay = internalRay
	#currentRay.collision_mask = 2
	#currentRay.collide_with_areas = true
	#currentRay.position = ray.get_collision_point() - $'.'.global_position
	#currentRay.target_position = ray.target_position.rotated(-PI/24)

func createSecondaryRefractionRaycast()->void:
	if not externalRay:
		externalRay = RayCast2D.new()
		$'.'.add_child(externalRay)
