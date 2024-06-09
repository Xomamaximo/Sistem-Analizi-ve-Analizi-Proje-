extends Node

var in_game:bool = false

@export var start_new_round:bool = false
@export var round_ended:bool = false
@export var round_end_reward_given:bool = true

@export var peasent_total:int = 2
@export var knight_total:int = 1
@export var peasent_left:int = peasent_total
@export var knight_left:int = knight_total

@export var game_round:int = 0
@export var game_health:int = 20

@export var gold:float = 0
@export var gold_multiplier:float = 1 + game_round * 0.5
@export var wood:int = 4
@export var stone:int = 2
@export var iron:int = 0

var secilenzorluk:String = "orta"
