extends Node2D


func _on_button_pressed() -> void:
	$Player.increase_speed(10.0)
	pass # Replace with function body.


func _on_player_speed_increased() -> void:
	print("speed_increased received")
	pass # Replace with function body.
