extends Node2D

var minigameTitle = "MinigameA";

const draggingElementInstance = preload("res://Scenes/Minigames/Minigame_A/DraggingElement.tscn");

var draggingElementsArray = [];
var draggingElement = null;

var draggingZonesArray = [];

func _ready():
	randomize();
	
	draggingZonesArray = get_tree().get_nodes_in_group("draggingZones");
	
	for i in draggingZonesArray.size():
		var newDraggingZone = draggingZonesArray[i];
		
		#Adjudicarle el controlador del minijuego a cada elemento
		newDraggingZone.minigameController = self;
	
	var elementsAmount = randi() % 4 + 2; #Número entero aleatorio entre 2 y 5
	for i in elementsAmount:
#		#Instanciar elemento
		var newDraggingElement = draggingElementInstance.instance();
		
		#Adjudicarle el controlador del minijuego a cada elemento
		newDraggingElement.minigameController = self;
		
		#Posición y z index del elemento
		newDraggingElement.position.y += 16*i;
		newDraggingElement.z_index = i;
		
		#Tipo de elemento
		newDraggingElement.elementIndex = i; #Random y que no se repita
		
		#Añadirlo a la lista de elementos del controlador
		draggingElementsArray.push_back(newDraggingElement);
		
		#Añadirlo como nodo hijo del controlador
		self.add_child(newDraggingElement);

func _process(delta):
		pass;
#	for i in draggingElementsArray.size():
#		print(draggingElementsArray[i]);
