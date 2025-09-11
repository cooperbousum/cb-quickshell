import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects

PanelWindow {
  id: root
  property int marginSize
  property int rightMarginSize
  property int cornerRadius

  WlrLayershell.exclusionMode: ExclusionMode.Ignore

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  mask: Region {
    item: region

    intersection: Intersection.Xor
  }

  Rectangle {
    id: region
    anchors.fill: parent
    color: "transparent"
  }

  color: "transparent"

  Rectangle {
    id: rect
    anchors.fill: parent
    color: "black"

    layer.enabled: true
    layer.effect: MultiEffect {
      maskSource: mask
      maskEnabled: true
      maskInverted: true
      maskThresholdMin: 0.5
      maskSpreadAtMin: 1
    }
  }

  Item {
    id: mask

    anchors.fill: parent
    layer.enabled: true
    visible: false

    Rectangle {
        anchors.fill: parent
        anchors.margins: root.marginSize
        anchors.rightMargin: root.rightMarginSize
        radius: root.cornerRadius
    }
  }

  /*Rectangle {
    id: dumb
    anchors.centerIn: parent
    width: 100
    height: 100
    color: "transparent"
    layer.enabled: true

    Rectangle {
      id: maskdumb
      layer.enabled: true
      anchors.fill: parent
      color: "black"
      radius: 15
      anchors.margins: 15
      visible: false
    }

    layer.enabled: true
    layer.effect: MultiEffect {
      maskSource: maskdumb
      maskEnabled: true
      maskInverted: true
      maskThresholdMin: 0.5
      maskSpreadAtMin: 1
    }
  }

  DropShadow {
    anchors.fill: dumb
    horizontalOffset: 3
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: dumb
  }*/
}

