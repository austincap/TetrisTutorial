extends CanvasLayer

class_name UI

@onready var center_container = $CenterContainer
@onready var windscene = preload("res://Scenes/wind.tscn")
@onready var firestarterscene = preload("res://Scenes/firestarter.tscn")
@onready var explosivescene = preload("res://Scenes/explosive_sap.tscn")
@onready var firescene = preload("res://Scenes/fire.tscn")


func show_game_over():
	center_container.show()


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_windbutton_pressed():
	var wind = windscene.instantiate()
	wind.position = Vector2(20,100)
	var tween = create_tween()
	add_child(wind)
	tween.tween_property(wind, "position:x", 500, 7.0)
	tween.play()


func _on_button_2_pressed():
	var fire = firescene.instantiate()
	fire.position = Vector2(220,100)
	add_child(fire)



func _on_button_3_pressed():
	pass # Replace with function body.
