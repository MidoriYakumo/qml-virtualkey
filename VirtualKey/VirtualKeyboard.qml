import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

VirtualKeys {
	id: control

	enablePad: false
	enableGameButtons: false

	property int keyWidth: Units.gu// / 2
	property int keySpacing: Units.dp * 3

	modifiers: d.shiftModifier | d.otherModifier

	QtObject {
		id: d

		property int shiftModifier: shiftKey.checked?Qt.ShiftModifier:Qt.NoModifier
		property int otherModifier:
			controlKey.checked?Qt.ControlModifier:Qt.NoModifier |
			alterKey.checked?Qt.AltModifier:Qt.NoModifier
	}

	centerItem: Column {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		spacing: control.keySpacing

		Row {
			id: row0
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"!":"1"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"@":"2"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"#":"3"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"$":"4"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"%":"5"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"^":"6"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"&":"7"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"*":"8"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"(":"9"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?")":"0"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " 🡄 "
				key: Qt.Key_Backspace
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
			}
		}

		Row {
			id: row1
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ↹ "
				key: Qt.Key_Tab
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Q":"q"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"W":"w"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"E":"e"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"R":"r"
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"T":"t"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Y":"y"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"U":"u"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"I":"i"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"O":"o"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"P":"p"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				id: alterKey
				target: control.target
				targetHandler: null
				text: "Alt"
				key: Qt.Key_Alt
				width: control.keyWidth
				checkable: true
				padding: 0
			}
		}

		Row {
			id: row2
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				id: shiftKey
				target: control.target
				targetHandler: null
				text: " ⇧ "
				key: Qt.Key_Shift
				width: control.keyWidth
				checkable: true
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"A":"a"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"S":"s"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"D":"d"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"F":"f"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"G":"g"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"H":"h"
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"J":"j"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"K":"k"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"L":"l"
				modifiers: control.modifiers
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ↵ "
				key: Qt.Key_Enter
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
			}
		}

		Row {
			id: row3
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: parent.spacing

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " ← "
				key: Qt.Key_Left
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}

			VirtualKey {
				id: controlKey
				target: control.target
				targetHandler: null
				text: "Ctl"
				key: Qt.Key_Control
				width: control.keyWidth
				checkable: true
				padding: 0
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"Z":"z"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"X":"x"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"C":"c"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"V":"v"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"B":"b"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"N":"n"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: (control.modifiers&Qt.ShiftModifier)?"M":"m"
				modifiers: d.otherModifier
				width: control.keyWidth
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: "  "
				key: Qt.Key_Space
				modifiers: control.modifiers
				width: control.keyWidth * 2 + parent.spacing
			}

			VirtualKey {
				target: control.target
				targetHandler: null
				text: " → "
				key: Qt.Key_Right
				modifiers: control.modifiers
				width: control.keyWidth
				padding: 0
			}
		}
	}
}
