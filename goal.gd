extends Area2D


@export var neededLasers = 1



var reflectInternal = false
var reflectExternal = false
var reflectable = true
var nextLayer = 1
var internalAngle = 0
var isGoal = true


func goalHit(byRay:Node2D):
	Globals.s_goalHit.emit()


func _ready() -> void:
	pass



func _physics_process(delta: float) -> void:
	pass
