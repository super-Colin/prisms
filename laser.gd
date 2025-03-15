extends Node2D

@export var wavelenghtSpectrumMin:Vector2= Vector2.ZERO
@export var wavelenghtSpectrumMax:Vector2= Vector2.ZERO


func _ready() -> void:
	RayCast2D



func _physics_process(delta: float) -> void:
	var collider = $RayCast2D.get_collider()
	#if collider != null && "reflectInternal" in collider:
	if collider != null:
		#if collider.reflectInternal:
			#collider.handleRefraction($RayCast2D)
			if not extended:
				#extendedRay = extendRay($RayCast2D.get_collision_point(), $RayCast2D.get_collision_normal())
				extendedRay = extendRay($RayCast2D)
				extendedRay.collision_mask = 2
				$'.'.add_child(extendedRay)
				extended = true
			collider = extendedRay.get_collider()
			if collider != null:
				if not extended2:
					#extendedRay2 = extendRay(extendedRay.get_collision_point(), extendedRay.get_collision_normal())
					extendedRay2 = extendRay(extendedRay)
					$'.'.add_child(extendedRay2)
					extended2 = true
					print("laser - fully extended")
				




var extended = false
var extended2 = false
var extendedRay
var extendedRay2
#func extendRay(contactPoint:Vector2, contactNormal:Vector2):
	##var newRay = RayCast2D.new()
	#var newRay = $RayCast2D.duplicate()
	#newRay.collide_with_areas = true
	#newRay.position = contactPoint - $'.'.position
	#newRay.target_position = newRay.target_position.rotated(-PI/24)
	#print("laser - extended: ", contactPoint)
	#return newRay
func extendRay(theRay):
	var newRay = RayCast2D.new()
	#var newRay = theRay.duplicate()
	newRay.collide_with_areas = true
	#newRay.target_position = Vector2(100, 0)
	newRay.position = theRay.get_collision_point() - $'.'.position
	newRay.target_position = theRay.target_position.rotated(-PI/24)
	print("laser - extended: ", theRay.get_collision_point())
	return newRay




#func createRefractionRaycast(point:Vector2)->void:
	#print("laser - point is: ", point)
	#print("laser - global position is: ", $'.'.global_position)


#(-0.869837, -0.49334)
#(377.2537, 164.0)
#(-0.869837, -0.49334)
#(377.2537, 164.0)
