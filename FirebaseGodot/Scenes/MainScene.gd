extends Node2D

func _on_SignInButton_pressed():
	get_tree().change_scene("res://Scenes/SignIn.tscn");

func _on_LogInButton_pressed():
	get_tree().change_scene("res://Scenes/LogIn.tscn");
