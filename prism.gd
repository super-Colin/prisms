extends Node2D


@export var splits = 1
@export var angle = 90

var reflectInternal = true
var reflectExternal = false
var reflectable = true
#var nextLayer = 2
var internalAngle = (-PI/24)

#
#var reflectInternal = true
#var reflectExternal = false
#var reflectable = true



func dragRotate():
	$'.'.rotate()

var beingDragged = false
var mouseHovering = false

func _ready() -> void:
	$'.'.mouse_entered.connect(func():mouseHovering = true)
	$'.'.mouse_exited.connect(func():mouseHovering = false)

func _input(event: InputEvent) -> void:
	if Globals.currentLevelBeaten:
		return
	if Input.is_action_pressed("leftClick"):
		if mouseHovering:
			beingDragged = true
	else:
		beingDragged = false
	if beingDragged:
		if event is InputEventMouseMotion:
			#var rotateAmount = (event.relative * 0.01).angle()
			#var rotateAmount = (event.relative).angle()
			var rotateAmount = event.relative.x * 0.01
			$'.'.rotate(rotateAmount)
			#print(rotateAmount, ", ", event)



func _physics_process(delta: float) -> void:
	pass
	#createRefractionRaycast()
	#if internalRay != null:
		#var colliding = internalRay.is_colliding()
		#if colliding:
			#var collider = internalRay.get_collider()
			#if "createRefractionRaycast" in collider:
				#collider.createRefractionRaycast(internalRay)
