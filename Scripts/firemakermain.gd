extends Node2D

@onready var tetromino_script = preload("res://Scripts/tetromino.gd")
@onready var tetromino_scene = preload("res://Scenes/tetromino.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var fire_array = []
var wind_array = []
var wood_array = []

var tick = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	tick +=1
	#every quarter second process interactions
	if tick%15 == 0:
		tetromino_scene.instantiate()
#		process_fire_wind_interactions()
#		process_fire_sap_interactions()
#		process_fire_wood_interactions()
		pass
		if tick == 60:
			tick = 0
