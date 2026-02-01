extends Resource
class_name SceneLibraryData

enum SceneID { TITLE, DRAW }

@export var scene_dict: Dictionary[SceneID, PackedScene] = {
	SceneID.TITLE: null,
	SceneID.DRAW: null,
}

func get_scene(id: SceneID) -> PackedScene:
	return scene_dict.get(id)
