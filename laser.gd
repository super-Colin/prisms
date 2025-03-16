extends Node2D

@export var wavelenghtSpectrumMin:Vector2= Vector2.ZERO
@export var wavelenghtSpectrumMax:Vector2= Vector2.ZERO



func _ready() -> void:
	projectLaser()


#force_raycast_update() 
func projectLaser():
	var firstRay = newLaserRay()
	$'.'.add_child(firstRay)
	firstRay.force_raycast_update()
	var collider = firstRay.get_collider()
	print("laser - collider ", collider)
	if collider != null:
		if "reflectable" in collider:
			print("laser - collider ", collider.reflectable)
			if collider.reflectInternal:
				extendedRay = extendRay(firstRay, true)
				extendedRay.position -= $'.'.position
				$'.'/Rays.add_child(extendedRay)


func newLaserRay():
	var newRay = RayCast2D.new()
	newRay.collide_with_areas = true
	newRay.target_position = Vector2(1000,0)
	return newRay

var extended = false
var extended2 = false
var extendedRay
var extendedRay2

func extendRay(theRay, internal=true):
	var newRay = newLaserRay()
	#var newRay = theRay.duplicate()
	newRay.position = theRay.get_collision_point()
	if internal:
		newRay.target_position = theRay.target_position.rotated(-PI/24)
		newRay.collision_mask = 2
	print("laser - extended: ", theRay.get_collision_point(), ", ", newRay.position)
	return newRay


func _physics_process(delta: float) -> void:
	#return
	projectLaser()

	#var collider = $Rays/RayCast2D.get_collider()
	##if collider != null && "reflectInternal" in collider:
	#if collider != null:
		##if collider.reflectInternal:
			##collider.handleRefraction($RayCast2D)
			##if not extended:
				##extendedRay = extendRay($RayCast2D.get_collision_point(), $RayCast2D.get_collision_normal())
			#extendedRay = extendRay($Rays/RayCast2D)
			#extendedRay.collision_mask = 2
			#extendedRay.position -= $'.'.position
			#$'.'.add_child(extendedRay)
				##extended = true
			#collider = extendedRay.get_collider()
			#if collider != null:
				##if not extended2:
					##extendedRay2 = extendRay(extendedRay.get_collision_point(), extendedRay.get_collision_normal())
				#extendedRay2 = extendRay(extendedRay)
				#$'.'.add_child(extendedRay2)
				#extendedRay2.position -= $'.'.position
					##extended2 = true
				#print("laser - fully extended")
				#


	






#func createRefractionRaycast(point:Vector2)->void:
	#print("laser - point is: ", point)
	#print("laser - global position is: ", $'.'.global_position)


#(-0.869837, -0.49334)
#(377.2537, 164.0)
#(-0.869837, -0.49334)
#(377.2537, 164.0)
