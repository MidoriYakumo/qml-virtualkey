// Not work!

import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Window {
	id: window

	visible: true
	width: 800
	height: 600

	MouseArea {
		id: mouseArea
		anchors.fill: parent

		onClicked: {
			console.log(mouseX, mouseY)
			InputEventSource.mouseClick(mouseArea, 100, 100,
										Qt.LeftButton, Qt.NoModifier, 200)

		}

		onPressed: {
			console.log(mouseX, mouseY)
		}
	}

	TestCase {
	Button {
		id: gg
		text: "GG"
		onClicked: {
			console.log(oo.pressed)
			event.mousePress(oo, oo.width/2, oo.height/2,
				Qt.LeftButton, Qt.NoModifier, -1)
			console.log(oo.pressed)
		}
	}
	}

	Button {
		id: oo
		x: 90
		y: 90
		text: "OO"
		checkable: true
		onClicked: console.log("OO")
	}

}
