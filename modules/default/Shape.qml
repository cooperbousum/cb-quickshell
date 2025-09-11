
pragma ComponentBehavior: Bound

import "battery"
import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import QtQuick.Shapes

ShapePath {
  id: root

  readonly property real rounding: 20
  readonly property bool flatten: 60 < rounding * 2
  readonly property real roundingX: flatten ? 60 / 2 : rounding

  strokeWidth: -1
  fillColor: "black"

  PathArc {
      relativeX: -root.roundingX
      relativeY: root.rounding
      radiusX: Math.min(root.rounding, 60)
      radiusY: root.rounding
  }
  PathLine {
      relativeX: -(root.wrapper.width - root.roundingX * 2)
      relativeY: 0
  }
  PathArc {
      relativeX: -root.roundingX
      relativeY: root.rounding
      radiusX: Math.min(root.rounding, 60)
      radiusY: root.rounding
      direction: PathArc.Counterclockwise
  }
  PathLine {
      relativeX: 0
      relativeY: root.wrapper.height - root.rounding * 2
  }
  PathArc {
      relativeX: root.roundingX
      relativeY: root.rounding
      radiusX: Math.min(root.rounding, 60)
      radiusY: root.rounding
      direction: PathArc.Counterclockwise
  }
  PathLine {
      relativeX: 60 - root.roundingX * 2
      relativeY: 0
  }
  PathArc {
      relativeX: root.roundingX
      relativeY: root.rounding
      radiusX: Math.min(root.rounding, 60)
      radiusY: root.rounding
  }
}

