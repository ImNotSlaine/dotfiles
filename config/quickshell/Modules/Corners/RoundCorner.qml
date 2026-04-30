import QtQuick

Item {
	id: root

	enum CornerEnum {
		TopLeft
	}

	property int corner: RoundCorner.CornerEnum.TopLeft
	property int size: 25
	property color color: "#000000"

	onColorChanged: {
		canvas.requestPaint();
	}

	implicitWidth: size
	implicitHeight: size

	Canvas {
		id: canvas

		anchors.fill: parent
		antialiasing: true
		onPaint: {
			var ctx = getContext("2d");
			var r = root.size;
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.beginPath();
			switch (root.corner) {
				case RoundCorner.CornerEnum.TopLeft:
					ctx.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
					ctx.lineTo(0, 0);
					break;
			}
			ctx.closePath();
			ctx.fillStyle = root.color;
			ctx.fill();

		}
	}
}
