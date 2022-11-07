package en;

import hxd.Window;
import h2d.col.RoundRect;

class Golfer extends Entity {
	var ca: ControllerAccess<GameAction>;

	var rotationSpeed: Float = 0.5;

	// var mousePosition: Vector2;

	public function new() {
		super(5, 5);

		// Starting point using level entity "PlayerStart"
		var start = level.data.l_Entities.all_PlayerStart[0];
		if (start != null) {
			setPosCase(start.cx, start.cy);
		}

		camera.trackEntity(this, true);
		camera.clampToLevelBounds = true;

		// Init controller
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;

		// Placeholder display of a blue rectangle
		var b = new h2d.Bitmap(h2d.Tile.fromColor(Blue, iwid, ihei), spr);
		b.tile.setCenterRatio(start.pivotX, start.pivotY);
	}

	override function dispose() {
		super.dispose();
		ca.dispose();
	}

	override function preUpdate() {
		super.preUpdate();
	}

	override function fixedUpdate() {
		super.fixedUpdate();

		// keyboard-based character rotation
		if (ca.getAnalogDist2(MoveLeft, MoveRight) > 0) {
			spr.rotate(ca.getAnalogValue2(MoveLeft, MoveRight) * rotationSpeed);
		}
	}
}
