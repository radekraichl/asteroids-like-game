extends Area2D

func hit(hit_info: HitInfo):
	get_parent().hit(hit_info)
