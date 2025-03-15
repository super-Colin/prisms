extends Area2D


var calledRefract = false
var notCalledRefractFrames = 0
var internalRay:RayCast2D
var externalRay:RayCast2D







func _physics_process(delta: float) -> void:
	createRefractionRaycast()
	#if internalRay:
		#var colliding = internalRay.is_colliding()
		#print("prism - internal collision: ", colliding, ", internal ray: ", internalRay)
		#if colliding:
			#var collider = internalRay.get_collider()
			##createRefractionRaycast(internalRay.get_collision_point())
			#notCalledRefractFrames += 1
			#if "createRefractionRaycast" in collider:
				#collider.createRefractionRaycast(internalRay, true)


#func createRefractionRaycast(ray:RayCast2D)->void:
func createRefractionRaycast(ray = null)->void:
	if notCalledRefractFrames >= 40 and ray != null:
		if internalRay != null:
			internalRay.queue_free()
			if externalRay != null:
				externalRay.queue_free()
		return
	elif ray == null:
		notCalledRefractFrames += 1
		return
	calledRefract = true
	#print("prism - ray is: ", ray)
	#print("prism - global position is: ", $'.'.global_position)
	var currentRay
	if ray == internalRay:
		print("prism - creating EXternal refraction")
		externalRay = RayCast2D.new()
		$'.'.add_child(externalRay)
		currentRay = externalRay
	#elif not internalRay:
	else:
		print("prism - creating internal refraction")
		internalRay = RayCast2D.new()
		$'.'.add_child(internalRay)
		currentRay = internalRay
		currentRay.collision_mask = 2
	currentRay.collide_with_areas = true
	currentRay.position = ray.get_collision_point() - $'.'.global_position
	currentRay.target_position = ray.target_position.rotated(-PI/24)

func createSecondaryRefractionRaycast()->void:
	if not externalRay:
		externalRay = RayCast2D.new()
		$'.'.add_child(externalRay)
