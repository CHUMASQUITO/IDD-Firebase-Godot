extends Node2D

func _on_SignInButton_pressed():
	var emailText = $EmailText.text;
	var passText = $PassText.text;
	
	Firebase.Auth.signup_with_email_and_password(emailText, passText);

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn");

