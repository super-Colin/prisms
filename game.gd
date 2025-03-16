extends Node2D

var level1 = preload("res://levels/level_1.tscn")

var currentLevel = 1
var loadedLevelScene


func _ready() -> void:
	Globals.s_levelComplete.connect(levelComplete)
	Globals.s_nextLevel.connect(loadNextLevel)
	return

func levelComplete():
	#Globals.currentLevelBeaten = true
	#showNextLevelMenu()
	pass

func loadNextLevel():
	currentLevel += 1
	loadLevel(currentLevel)
	Globals.currentLevelBeaten = false

func showNextLevelMenu():
	%CongratsMenu.visible = true

func loadLevel(lvl=1):
	var levelPath = "res://levels/level_" + str(lvl) +  ".tscn"
	var levelScene = load(levelPath)
	if not levelScene:
		return
	loadedLevelScene = levelScene.instantiate()
	#$Level.queue_free()
	$'.'.get_node("Level").free()
	loadedLevelScene.name ="Level"
	Globals.currentLevelBeaten = false
	%CongratsMenu.visible = false
	$'.'.add_child(loadedLevelScene)
