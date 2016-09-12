import QtQuick 2.7
import QtQuick.Controls 2.0

import "."

Button {
	id: control

	text: "Unkown"

	property int key: Qt.Key_unknown
	property int modifiers: Qt.NoModifier
	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	focusPolicy: Qt.NoFocus

	onClicked: {
		if (!target)
			return;

		target.focus = true

		var done = false
		if (text) {
			if (targetHandler) {
				var t = text
				t = t.setCharAt(0, t[0].toLowerCase())
				if (targetHandler[t+"Pressed"]) {
					var keyEvent = {
						"key": key,
						"modifiers": modifiers,
						"text": text
					}
					targetHandler[t+"Pressed"](keyEvent)
					done = true
				}
			}
			if (!done && text.length == 1) {
				InputEventSource.keyClickChar(text, modifiers, -1)
				done = true
			}
		}
		if (!done)
			InputEventSource.keyClick(key, modifiers, -1)
	}

//	onPressed: {
//		posX = mouseX
//		posY = mouseY
//		trigger.start()
//	}

	Component.onCompleted: { // minimal size
		height = contentItem.height + topPadding + bottomPadding
		width = contentItem.paintedWidth + leftPadding + rightPadding
	}
}
