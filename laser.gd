extends Node2D




#func _ready() -> void:
	#RayCast2D



func _physics_process(delta: float) -> void:
	print($RayCast2D.is_colliding())
	#var collider = $RayCast2D.get_collider()
	#if $RayCast2D.is_colliding():
		#print(collider)
