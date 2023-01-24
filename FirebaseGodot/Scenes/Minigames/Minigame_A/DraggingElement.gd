extends Node2D

var minigameController = null;

var elementSelected = false;
var elementDraggOffset = Vector2.ZERO;

var elementSpritesArray = [
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Bowtie.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Cap.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Controller.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Hat.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Keyboard.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Moustache.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Necktie.png"),
preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Sunglasses.png")
];

var elementCollisionShapeSizesArray = [
Vector2(30, 13),
Vector2(65, 43),
Vector2(48, 34),
Vector2(60, 44),
Vector2(53, 77),
Vector2(49, 40),
Vector2(15, 49),
Vector2(52, 26),
];

var elementIndex = randi() % elementSpritesArray.size();

#var elementSpriteCap = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Cap.png");
#var elementSpriteHat = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Hat.png");
#var elementSpriteMoustache = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Moustache.png");
#var elementSpriteSunglasses = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Sunglasses.png");
#var elementSpriteBowtie = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Bowtie.png");
#var elementSpriteNecktie = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Necktie.png");
#var elementSpriteController = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Controller.png");
#var elementSpriteKeyboard = preload("res://Assets/Sprites/Minigames/Minigame_A/MGA_Keyboard.png");

func _ready():
	$Sprite.texture = elementSpritesArray[elementIndex];
	$Area2D/CollisionShape2D.shape.extents = elementCollisionShapeSizesArray[elementIndex];

func _on_Area2D_input_event(viewport, event, shape_idx):
	#Hacer click en un elemento
	if (Input.is_action_just_pressed("leftClick")):
		if (minigameController != null):
			#Seleccionar elemento si no hay ninguno
			if (minigameController.draggingElement == null):
				_selectElement();
			else:
				#Seleccionar elemento con z index mayor si hay varios elementos superpuestos (y deseleccionar los de z index menor)
				if (z_index > minigameController.draggingElement.z_index):
					minigameController.draggingElement._deselectElement();
					_selectElement();

func _process(delta):
	#Mover elemento a la posición del mouse
	if (elementSelected):
		position = get_global_mouse_position() + elementDraggOffset;

		#Soltar elemento
		if (Input.is_action_just_released("leftClick")):
			if (minigameController != null):
				if (minigameController.draggingElement != null):
					_deselectElement();
					
					for i in minigameController.draggingZonesArray.size():
						var currentDraggingZone = minigameController.draggingZonesArray[i];
						if (get_global_mouse_position().distance_to(currentDraggingZone.global_position) < 50):
							global_position = currentDraggingZone.global_position;

func _selectElement():
	minigameController.draggingElement = self;
	elementSelected = true;
	elementDraggOffset = (position - get_global_mouse_position());

func _deselectElement():
	minigameController.draggingElement = null;
	elementSelected = false;
	elementDraggOffset = Vector2.ZERO;

func _dropElementInZone(zoneNode):
	pass;
