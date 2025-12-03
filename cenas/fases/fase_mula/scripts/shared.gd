extends Node

var isGamePlaying: bool = false
var points: int = 0

signal score_updated(new_score)
signal triggerHoles

func newGame():
	points = 0
	isGamePlaying = true
	score_updated.emit(points)

func endGame() -> int:
	isGamePlaying = false
	return points
