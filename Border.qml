import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Layouts
import qs
import Quickshell.Services.UPower

PanelWindow {
  id: root
  property int marginSize
  property int holeMargin: Globals.marginSize
  property int bottomMarginSize
  property int cornerRadius
  property int barHeight: Globals.barHeight
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Top

  
  color: "transparent"
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  mask: Region {
      item: region
      intersection: Intersection.Xor
  }

  Rectangle {
    id: region
    anchors.fill: parent
    anchors.bottomMargin: root.barHeight + bottomMarginSize
    anchors.rightMargin: volbright.volbrightHover.hovered ? Globals.marginSize + volbright.volbrightPopout.width : Globals.marginSize
    color: "transparent"
  }
  
  Item {
    anchors.fill: parent

    Rectangle {
      id: shadow
      anchors.fill: parent
      anchors.leftMargin: root.holeMargin - 15
      anchors.rightMargin: root.holeMargin - 15
      anchors.topMargin: root.holeMargin - 15
      anchors.bottomMargin: bottomMarginSize + root.barHeight - 14
      radius: root.cornerRadius * 1.5
      color: "transparent"
      border.color: Globals.primaryColor
      border.width: 15
      layer.enabled: true
      layer.effect: MultiEffect {
        shadowEnabled: true
        shadowScale: 1
        shadowColor: Globals.shadowColor
        autoPaddingEnabled: true
        shadowBlur: 1
        shadowHorizontalOffset: 0
      }
    }

    Item {
      anchors.fill: parent

      Rectangle {
        id: border
        anchors.fill: parent
        anchors.bottomMargin: root.barHeight
        color: Globals.primaryColor
        visible: false
      }

      Item {
        id: maskSource
        anchors.fill: parent
        visible: false
        layer.enabled: true

        Rectangle {
          id: mask
          color: "blue"
          anchors.fill: parent
          anchors.leftMargin: root.holeMargin
          anchors.rightMargin: root.holeMargin
          anchors.topMargin: root.holeMargin
          anchors.bottomMargin: (bottomMarginSize) + root.barHeight
          radius: root.cornerRadius
        }
      } 

      OpacityMask {
        anchors.fill: parent
        invert: true
        source: border
        maskSource: maskSource
        visible: true
        layer.effect: MultiEffect {
          shadowEnabled: true
        }
      }
    }
  }
  
  Volbright {
    id: volbright
  }

  Bar {
    id: bar
  }

}
