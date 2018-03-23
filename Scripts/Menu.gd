extends Control

func _on_NesMegamanButton_pressed():
	get_tree().change_scene("res://Levels/MegamanNes.tscn")
	pass


func _on_DoubleJumpButton_pressed():
	get_tree().change_scene("res://Levels/DoubleJump.tscn")
	pass


func _on_SuperSmashBrosButton_pressed():
	get_tree().change_scene("res://Levels/SuperSmashBros.tscn")
	pass
