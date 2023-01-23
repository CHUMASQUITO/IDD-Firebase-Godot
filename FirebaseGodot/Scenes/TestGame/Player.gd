extends Area2D

export var playerMaxSpeed = 100;

var screenSize = Vector2.ZERO;

signal playerHit;

func _ready():
	screenSize = get_viewport_rect().size;

func _process(delta):
	var inputLeft = Input.is_action_pressed("left");
	var inputRight = Input.is_action_pressed("right");
	var inputUp = Input.is_action_pressed("up");
	var inputDown = Input.is_action_pressed("down");
	
	var playerDirection = Vector2.ZERO;
	
	if (inputLeft != inputRight):
		playerDirection.x = int(inputRight) - int(inputLeft);
		
		$Sprite.flip_h = (playerDirection.x < 0);
		
	if (inputUp != inputDown):
		playerDirection.y = int(inputDown) - int(inputUp);
		
	if (playerDirection.length() > 0):
		$AnimationPlayer.play("FishSwim");
	else:
		$AnimationPlayer.stop();
	
	if (playerDirection.length() > 1):
		playerDirection = playerDirection.normalized();
		
	position += playerDirection * playerMaxSpeed * delta;
	position.x = clamp(position.x, 0, screenSize.x);
	position.y = clamp(position.y, 0, screenSize.y);

func _on_Player_area_entered(area):
	hide();
	emit_signal("playerHit");
	$CollisionShape2D.set_deferred("disabled", true);
	
func _startGame():
	show();
	position = screenSize/2;
	$CollisionShape2D.disabled = false;
