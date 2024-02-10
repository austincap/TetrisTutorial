extends Node2D

@onready var tetromino_script = preload("res://Scripts/tetromino.gd")
@onready var tetromino_scene = preload("res://Scenes/tetromino.tscn")
@onready var Firescene = preload("res://Scenes/fire.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var fire_array = []
var wind_array = []
@export var wood_array: Array[RigidBody2D] = []

var tick = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	tick +=1
	#every quarter second process interactions
	if tick%15 == 0:
		tetromino_scene.instantiate()
		#process_fire_wind_interactions()
		#process_fire_sap_interactions()
		#process_fire_wood_interactions()
		pass
		if tick == 60:
			tick = 0
			process_fire_wood_interactions()



func process_fire_wood_interactions():
	var i = 0
	for woodpiece in wood_array:
		if is_instance_valid(woodpiece):
			print("heat")
			print(woodpiece.get_meta("heat"))
			if woodpiece.get_meta("heat") < 4:
				woodpiece.set_meta("onfire", false)
			else:
				var earlier_fuel =  woodpiece.get_meta("fuel")
				woodpiece.set_meta("fuel", earlier_fuel-1)
				#print(earlier_fuel)
				var modulate_valuate = 1-((25.0-earlier_fuel)/25.0)
				#print("mod")
				#print(modulate_valuate)
				woodpiece.modulate = Color(modulate_valuate,modulate_valuate,modulate_valuate)
				#print(woodpiece.get_meta("fuel"))
				if woodpiece.get_meta("fuel") < 0:
					var firescene = Firescene.instantiate()
					firescene.global_position = woodpiece.global_position + Vector2(-189.0, -302.0)
					add_child(firescene)
					print(woodpiece.global_position)
					wood_array.erase(woodpiece)
					woodpiece.queue_free()
				#print(wood_array)
		i += 1

