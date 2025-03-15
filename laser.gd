extends Node2D




func _ready() -> void:
	RayCast2D



func _physics_process(delta: float) -> void:
	var colliding = $RayCast2D.is_colliding()
	#print(colliding)
	if colliding:
		var collider = $RayCast2D.get_collider()
		#print("laser - collider: ", collider)
		#print($RayCast2D.get_collision_normal())
		#print($RayCast2D.get_collision_point())
		#createRefractionRaycast($RayCast2D.get_collision_point())
		if "createRefractionRaycast" in collider:
			collider.createRefractionRaycast($RayCast2D)



#func createRefractionRaycast(point:Vector2)->void:
	#print("laser - point is: ", point)
	#print("laser - global position is: ", $'.'.global_position)


#(-0.869837, -0.49334)
#(377.2537, 164.0)
#(-0.869837, -0.49334)
#(377.2537, 164.0)
