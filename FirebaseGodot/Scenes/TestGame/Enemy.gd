extends Area2D;

export var enemyMinSpeed = 30;
export var enemyMaxSpeed = 50;

var enemySpeed;
var enemyDirection;

func _ready():
	enemySpeed = rand_range(enemyMinSpeed, enemyMaxSpeed);
	var rndAngle = rand_range(0, 360);
	enemyDirection = Vector2(cos(deg2rad(rndAngle)), sin(deg2rad(rndAngle)));

	$AnimationPlayer.play("EnemySwim");

func _process(delta):
	position += enemyDirection * enemySpeed * delta;
	
	$Sprite.flip_h = (enemyDirection.x > 0);

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
