extends Node2D

#Variables generales de minijuego
var minigameTitle = "MinigameA";
var minigameDescription = "¡Viste al DEV!";

var minigameCanBeCompletedBeforeTime = true;
var minigameCanBeFailedBeforeTime = false;

var minigameBackgroundColor = Color.white;


#Variables arrastrar objetos
var draggingZoneRadius = 64;

var draggingObject = null;
var draggingObjectXOffset = 0;
var draggingObjectYOffset = 0;
const draggingObjectScene = preload("res://Scenes/Minigames/Minigame_A/DraggingElement.tscn");

#Variables de dificultad
var draggingObjectsAmount = randi() % 4 + 2;

var draggingObjectsArray = [];
var draggingZonesArray = [];

#Diccionario y listas de objetos posibles
var draggingObjectsDictionary = {
	MinigamesEnums.MGA_ZONE_TYPE.HEAD: [
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingCap.tscn"),
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingHat.tscn")
	],
	MinigamesEnums.MGA_ZONE_TYPE.FACE: [
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingMoustache.tscn"),
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingSunglasses.tscn")
	],
	MinigamesEnums.MGA_ZONE_TYPE.BODY: [
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingBowtie.tscn"),
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingNecktie.tscn")
	],
	MinigamesEnums.MGA_ZONE_TYPE.LHAND: [
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingController.tscn")
	],
	MinigamesEnums.MGA_ZONE_TYPE.RHAND: [
		preload("res://Scenes/Minigames/Minigame_A/DraggingElements/MGA_DraggingKeyboard.tscn")
	]
};


func _ready():	
	randomize();
	
	#Variables del DEV
	$DeV.devInitialYPosition = Vector2(540, 1320);
	$DeV.devTargetYPosition = Vector2(540, 540);
	
	$DeV.position = $DeV.devInitialYPosition;
	
	
	#Elementos para arrastrar
	for i in draggingObjectsAmount:
#		#Instanciar objeto
		var newDraggingObject = draggingObjectScene.instance();

		#Adjudicarle el controlador del minijuego a cada objeto
		newDraggingObject.minigameController = self;

		#Posición y z index del objeto
		newDraggingObject.position.y += 16*i;
		newDraggingObject.z_index = i;

		#Añadirlo a la lista de objeto del controlador
		draggingObjectsArray.push_back(newDraggingObject);

		#Añadirlo como nodo hijo del controlador
		$DraggingObjects.add_child(newDraggingObject);
	
	
	
	
#devStatueYInitial = devStatueInstance.y + room_height;
#devStatueInstance.devStatueYTarget = devStatueInstance.y;
#
##Coordenadas 0,0 del sprite
#var devX = devStatueInstance.x - sprite_get_xoffset(spr_MGA_Dev);
#var devY = devStatueInstance.y - sprite_get_yoffset(spr_MGA_Dev);
#
#
##Crear "zonas" del DEV
#devZoneInstancesList = ds_list_create();
#
##Cabeza
#devZoneHead = instance_create_depth(devX + 129, devY + 43, 0, obj_MGA_Zones);
#devZoneHead.devZoneType = devZonesList[|0];
#ds_list_add(devZoneInstancesList, devZoneHead);
#
##Cara
#devZoneFace = instance_create_depth(devX + 157, devY + 104, 0, obj_MGA_Zones);
#devZoneFace.devZoneType = devZonesList[|1];
#ds_list_add(devZoneInstancesList, devZoneFace);
#
##Cuerpo
#devZoneBody = instance_create_depth(devX + 167, devY + 169, 0, obj_MGA_Zones);
#devZoneBody.devZoneType = devZonesList[|2];
#ds_list_add(devZoneInstancesList, devZoneBody);
#
##Mano izquierda
#devZoneLeftHand = instance_create_depth(devX + 267, devY + 26, 0, obj_MGA_Zones);
#devZoneLeftHand.devZoneType = devZonesList[|3];
#ds_list_add(devZoneInstancesList, devZoneLeftHand);
#
##Mano derecha
#devZoneRightHand = instance_create_depth(devX + 29, devY + 224, 0, obj_MGA_Zones);
#devZoneRightHand.devZoneType = devZonesList[|4];
#ds_list_add(devZoneInstancesList, devZoneRightHand);
#
##Valores comunes en todos los objetos
#for (var i=0; i<ds_list_size(devZoneInstancesList); i++) {
#	var currentDevZone = devZoneInstancesList[|i];
#	currentDevZone.devZoneYInitial = currentDevZone.y + room_height;
#	currentDevZone.devZoneYTarget = currentDevZone.y;
#	currentDevZone.devZoneRadius = draggingDistance;
#}
#
#
##Crear objetos
#devObjectInstancesList = ds_list_create();
#
##Número de objetos que se van a crear
#ds_list_shuffle(devZonesList);
#
#for(var i=0; i<devObjectsAmount; i++) {
#	var xx = choose(irandom_range(64, room_width/2 - 160), irandom_range(room_width/2 + 160, room_width - 64));
#	var yy = room_height/(devObjectsAmount + 1) * (i + 1);
#	var devObjectInstance = instance_create_depth(xx, yy, 1, obj_MGA_Objects);
#	devObjectInstance.devObjectXInitial = room_width/2;
#	devObjectInstance.devObjectYInitial = room_height*1.5;
#	devObjectInstance.devObjectXTarget = devObjectInstance.x;
#	devObjectInstance.devObjectYTarget = devObjectInstance.y;
#	devObjectInstance.devObjectZoneType = devZonesList[|i];
#
#	//var spriteIndex = asset_get_index("spr_MGA_Object" + string(devZonesList[|i]));
#	//var imageIndex = irandom(sprite_get_number(spriteIndex) - 1);
#
#	var spritesList = devObjectsMap[? devZonesList[|i]];
#	var spriteIndex = irandom(ds_list_size(spritesList) - 1);
#	var sprite = spritesList[| spriteIndex];
#
#	devObjectInstance.sprite_index = sprite;
#	//devObjectInstance.image_index = imageIndex;
#	ds_list_add(devObjectInstancesList, devObjectInstance);
#}
#
##Destruir listas y mapas
#ds_list_destroy(devZonesList);
#
#ds_list_destroy(devObjectsHeadList);
#ds_list_destroy(devObjectsFaceList);
#ds_list_destroy(devObjectsBodyList);
#ds_list_destroy(devObjectsLeftHandList);
#ds_list_destroy(devObjectsRightHandList);
#ds_map_destroy(devObjectsMap);
#
#
##Variables de animación
#minigameIntroAnimation = animcurve_get(crv_MinigameAIntro);
#minigameIntroAnimationChannelDevStatueY = animcurve_get_channel(minigameIntroAnimation, "devStatueY");
#minigameIntroAnimationChannelDevObjectPos = animcurve_get_channel(minigameIntroAnimation, "devObjectPos");
#
#minigameOutroAnimation = animcurve_get(crv_MinigameAOutro);
#minigameOutroAnimationChannelDevStatueY = animcurve_get_channel(minigameOutroAnimation, "devStatueY");
#minigameOutroAnimationChannelDevObjectPos = animcurve_get_channel(minigameOutroAnimation, "devObjectPos");















#const draggingElementInstance = preload("res://Scenes/Minigames/Minigame_A/DraggingElement.tscn");
#
#var draggingElementsArray = [];
#var draggingElement = null;
#
#var draggingZonesArray = [];
#
#func _ready():	
#	randomize();
#
#	draggingZonesArray = get_tree().get_nodes_in_group("draggingZones");
#
#	#Zonas para arrastrar elementos
#	for i in draggingZonesArray.size():
#		var newDraggingZone = draggingZonesArray[i];
#
#		#Adjudicarle el controlador del minijuego a cada zona
#		newDraggingZone.minigameController = self;
#
#	#Elementos para arrastrar
#	var elementsAmount = randi() % 4 + 2; #Número entero aleatorio entre 2 y 5
#	for i in elementsAmount:
##		#Instanciar elemento
#		var newDraggingElement = draggingElementInstance.instance();
#
#		#Adjudicarle el controlador del minijuego a cada elemento
#		newDraggingElement.minigameController = self;
#
#		#Posición y z index del elemento
#		newDraggingElement.position.y += 16*i;
#		newDraggingElement.z_index = i;
#
#		#Añadirlo a la lista de elementos del controlador
#		draggingElementsArray.push_back(newDraggingElement);
#
#		#Añadirlo como nodo hijo del controlador
#		self.add_child(newDraggingElement);
#
#func _process(delta):
#		pass;
##	for i in draggingElementsArray.size():
##		print(draggingElementsArray[i]);
