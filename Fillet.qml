import QtQuick
import QtQuick.Shapes
import Quickshell
import QtQuick.Effects
import qs
 
Item {
  id: root
  property int arcSize: 30

  Behavior on x {
    NumberAnimation {
      duration: 600
      easing.type: Easing.InOutQuad
      easing.amplitude: Globals.animAmp
      easing.period: Globals.animPeriod
      easing.overshoot: 0
    }
  } 

  Behavior on anchors.topMargin {
    NumberAnimation {
      duration: 600
      easing.type: Easing.InOutQuad
      easing.amplitude: Globals.animAmp
      easing.period: Globals.animPeriod
      easing.overshoot: 0
    }
  }

  Shape {
    id: fillet

    width: root.arcSize
    height: root.arcSize

    ShapePath {
      fillColor: Globals.primaryColor
      strokeColor: Globals.tertiaryColor
      strokeWidth: 0

      startX: root.arcSize
      startY: 0

      PathLine {x: root.arcSize; y: 0}
      PathLine {x: root.arcSize; y: root.arcSize}
      PathLine {x: 0; y: root.arcSize} 

      PathArc {
        x: root.arcSize
        y: 0
        radiusX: root.arcSize
        radiusY: root.arcSize
        direction: PathArc.Counterclockwise
      }
    }

    layer.enabled: true
    layer.samples: 6
  } 
}




