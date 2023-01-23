extends Node

#Variables de juego
var score = 0;

#Variables de nivel
var screenCenter = Vector2(160, 90);

#Variables de enemigos
export var enemySpawnRadius = 200;
export (PackedScene) var enemyScene;

func _ready():
	randomize();
	
func _newGame():
	score = 0;
	$HUD._updateScore(score);
	
	$StartTimer.start();
	$HUD._showStart();
	
	yield($StartTimer, "timeout");
	$ScoreTimer.start();
	$EnemySpawnTimer.start();
	
func _gameOver():
	$ScoreTimer.stop();
	$EnemySpawnTimer.stop();
	$HUD._showGameOver();

#Spawnear enemigos
func _on_EnemySpawn_timeout():
	var newEnemy = enemyScene.instance();
	add_child(newEnemy);
	
	var enemySpawnDirection = rand_range(0, 360);
	
	newEnemy.position.x = screenCenter.x + enemySpawnRadius * cos(deg2rad(enemySpawnDirection));
	newEnemy.position.y = screenCenter.y + enemySpawnRadius * sin(deg2rad(enemySpawnDirection));
	
	var rndXTarget = screenCenter.x + rand_range(-60, 60);
	var rndYTarget = screenCenter.y + rand_range(-60, 60);
	var rndAngle = newEnemy.position.direction_to(Vector2(rndXTarget, rndYTarget));
	
	newEnemy.enemyDirection = rndAngle;


func _on_ScoreTimer_timeout():
	score += 1;
	$HUD._updateScore(score);
