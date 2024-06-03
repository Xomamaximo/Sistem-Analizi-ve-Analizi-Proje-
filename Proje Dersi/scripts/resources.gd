extends Node
@export var new_round:bool = false

@export var peasent_total:int = 2
@export var knight_total:int = 2
@export var peasent_left:int = peasent_total
@export var knight_left:int = knight_total

@export var game_round:int = 0
@export var game_health:int = 20

@export var gold:float = 0
@export var gold_multiplier:float = 1 + game_round * 0.1
@export var wood:int = 0
@export var stone:int = 0
@export var iron:int = 0
