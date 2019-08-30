extends KinematicBody2D


var skills_dict = {
	"Skills" : [
		{
			"Combination": "QQQ",
			"Name": "Cold Snap"
		},
		{
			"Combination": "QQW",
			"Name": "Ghost Walk"
		},
		{
			"Combination": "QQE",
			"Name": "Ice Wall"
		},
		{
			"Combination": "WWW",
			"Name": "EMP"
		},
		{
			"Combination": "WWQ",
			"Name": "Tornado"
		},
		{
			"Combination": "WWE",
			"Name": "Alacrity"
		},
		{
			"Combination": "EEE",
			"Name": "Sun Strike"
		},
		{
			"Combination": "EEQ",
			"Name": "Forge Spirit"
		},
		{
			"Combination": "EEW",
			"Name": "Meteor"
		},
		{
			"Combination": "QWE",
			"Name": "Deaf Blast"
		}
	]
}

onready var lbl_spell = $CanvasLayer/VBoxContainer/Spell
onready var lbl_action = $CanvasLayer/VBoxContainer/Action

var spell = ""
var SPEED = 350
var target = Vector2()
var velocity = Vector2()

func _ready():
	skills_dict = JSON.parse(JSON.print(skills_dict)).result

func _process(delta):
	
	# Spell input
	if (Input.is_action_just_pressed("q")):
		spell += "Q"
	if (Input.is_action_just_pressed("w")):
		spell += "W" 
	if (Input.is_action_just_pressed("e")):
		spell += "E"
	
	if spell.length() > 3:
		spell = spell.substr(1, 3)
	lbl_spell.text = spell
	
	# Cast
	if (Input.is_action_just_pressed("ui_accept")):
		if spell.length() == 3:
			lbl_action.text = get_spell_name(spell)
	
	# Character movement
	target = get_global_mouse_position()
	velocity = (target - position).normalized() * (SPEED)
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)

func get_spell_name(combination):
	for spell in skills_dict.Skills:
		if spell.Combination == combination:
			return spell.Name
	return "Deaf Blast"