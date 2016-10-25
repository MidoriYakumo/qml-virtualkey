/*
  Add input event into eventloop asynchronously
*/

import QtQuick 2.7

Item {
	id: defer

	property Item input: parent

	signal finished()

	QtObject {
		id: d

		property var queue: []
	}

	Timer {
		id: timer

		interval: 0
		repeat: false

		onTriggered: {
			input.enabled = false
			while (d.queue.length) {
				var event = d.queue.shift()
				event.act()
			}
			input.enabled = true
			defer.finished()
		}
	}

	function push(event) {
		if (event["act"])
			d.queue.push(event)
		else
			console.warn("Event %1 has no 'act' method".arg(event))
	}

	function start(){
		timer.start()
	}
}
