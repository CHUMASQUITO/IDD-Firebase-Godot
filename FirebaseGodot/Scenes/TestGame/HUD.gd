extends CanvasLayer

signal startGame;

func _on_StartButton_pressed():
	$StartButton.hide();
	emit_signal("startGame");

func _updateScore(score):
	$ScoreLabel.text = str(score);
	
func _showMessage(message):
	$MessageLabel.show();
	$MessageLabel.text = message;
	$MessageTimer.start();

func _showTitle():
	_showMessage("DODGE THE ENEMIES!");

func _showStart():
	_showMessage("Get ready!");
	
func _showGameOver():
	_showMessage("Game Over");
	yield($MessageTimer, "timeout");
	
	_showTitle();
	yield(get_tree().create_timer(1.0), "timeout");
	
	$StartButton.show();

func _on_MessageTimer_timeout():
	$MessageLabel.hide();
