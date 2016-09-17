import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

Canvas {
	id: control
	height: Units.gu * 3
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property var keys: [
	]

	property int repeatInterval: 40

	opacity: .7
}
