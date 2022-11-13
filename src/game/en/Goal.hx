package en;

class Goal extends Entity {
	public function new() {
		super(0, 0);
		setPivots(0.5);

		var goalLocation = level.data.l_Entities.all_Goal[0];
		if (goalLocation != null) {
			setPosCase(goalLocation.cx, goalLocation.cy);
		}

		var b = new h2d.Bitmap(h2d.Tile.fromColor(Yellow, iwid, ihei), spr);
		b.tile.setCenterRatio(0.5, 0.5);
	}

	override public function dispose() {
		super.dispose();
	}
}
