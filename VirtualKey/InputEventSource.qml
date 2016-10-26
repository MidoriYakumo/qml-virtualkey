pragma Singleton

import QtTest 1.1

TestEvent {
	property var dummyKeyEvent

	property TestUtil util: TestUtil { }

	function mouseDrag(item, sx, sy, ex, ey, button, modifiers, delay) {
		var dx, dy
		dx = sx>ex?1:-1
		dy = sy>ey?1:-1
		dx *= util.dragThreshold + 1
		dy *= util.dragThreshold + 1

		mousePress(item, sx, sy, button, modifiers, delay)
		mouseMove(item,	sx + dx, sy + dy, delay, button) // back move > threshold
		mouseMove(item, ex, ey, delay, button) // forward move > threshold
		mouseRelease(item, sx + dx, sy + dy, button, modifiers, delay)
	}
}
