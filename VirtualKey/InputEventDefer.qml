/*
  Add input event into eventloop asynchronously
*/

import QtQuick 2.7

Item {
	id: defer

	property Item input: parent
	property bool pauseInput: true

	signal finished()

	function push(event) {
		if (event["action"])
			d.queue.push(event);
		else
			console.warn("Event %1 has no 'action' method".arg(event));
	}

	function start(){
		timer.start();
	}

	QtObject {
		id: d

		property var queue: []
	}

	Timer {
		id: timer

		interval: 0
		repeat: false

		onTriggered: {
			if (pauseInput)
				input.enabled = false;
			while (d.queue.length) {
				var event = d.queue.shift();
				event.action();
			}
			if (pauseInput)
				input.enabled = true;
			defer.finished();
		}
	}
}
