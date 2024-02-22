extends Node
@onready var Windscene = preload("res://Scenes/wind.tscn")
var firewood_array: Array[RigidBody2D] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var tick = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	tick +=1
	#every quarter second process interactions
	if tick%15 == 0:
		for wood in firewood_array:
			if is_instance_valid(wood):
				wood.set_meta("heat", wood.get_meta("heat")+1)
		if tick == 60:
			self.set_meta("fireoxygenation", self.get_meta("fireoxygenation") - 1 )
			$GPUParticles2D.process_material.scale_max = 40*(1+0.05*self.get_meta("fireoxygenation"))
			if get_meta("fireoxygenation") <= 0:
				for wood in firewood_array:
					if is_instance_valid(wood):
						wood.set_meta("heat", wood.get_meta("heat")-3)
				queue_free()
			tick = 0




func _on_area_entered(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		self.set_meta("fireoxygenation", self.get_meta("fireoxygenation")+1 )
		area.windpower -= 1
		area.set_meta("windpower", area.get_meta("windpower")-1 )
	elif area.is_in_group("sap"):
		print("fire touched sap")
		var wind = Windscene.instantiate()
		wind.global_position = self.global_position + Vector2(-189.0, -302.0)
		add_child(wind)
		var tween = create_tween()
		add_child(wind)
		tween.tween_property(wind, "position:x", 500, 7.0)
		tween.play()
		

func _on_area_exited(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		self.set_meta("fireoxygenation", self.get_meta("fireoxygenation")+1 )
		area.windpower -= 1
		area.set_meta("windpower", area.get_meta("windpower")-1 )



func _on_body_entered(body):
	if body.is_in_group("wood"):
		body.set_meta("onfire", true)
		print("wood is on fire")
		get_tree().get_root().get_node("firemakermain").wood_array.append(body)
		self.firewood_array.append(body)
