pragma Singleton

import QtTest 1.1

TestEvent {
	property var dummyKeyEvent
	property int threshold: util.dragThreshold + 1
	property int threshold2: threshold*threshold

	property TestUtil util: TestUtil { }

	function mouseDrag(item, sx, sy, ex, ey, button, modifiers, delay) {
		mouseMove(item, sx, sy, delay, button)
		mousePress(item, sx, sy, button, modifiers, delay)
		var dx = ex - sx, dy = ey - sy
		if (dx*dx+dy*dy<threshold2) {
			dx = sx>ex?threshold:-threshold
			dy = sy>ey?threshold:-threshold
			mouseMove(item,	sx + dx, sy + dy, delay, button) // back move > threshold
			mouseMove(item,	(sx + dx + ex)/2, (sy + dy + ey)/2, delay, button)
		}
		mouseMove(item, ex, ey, delay, button) // forward move > threshold
		mouseRelease(item, sx + dx, sy + dy, button, modifiers, delay)
	}
}
