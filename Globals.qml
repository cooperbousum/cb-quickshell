pragma Singleton

import QtQuick
import Quickshell

Singleton {

  Behavior on marginSize {
    NumberAnimation {
      duration: Globals.animDuration
      easing.type: Globals.animType
      easing.amplitude: Globals.animAmp
      easing.period: Globals.animPeriod
      easing.overshoot: Globals.animOvershoot
    }
  }

  property string wallpaper: "/home/cooperb/Downloads/default.jpg"
  property color primaryColor: "#DEDDD1"
  // property color primaryColor: "#E76B44"
  // property color primaryColor: "#0F151B"
  // property color secondaryColor: "#203448"
  property color secondaryColor: "#DFDED2"
  // property color secondaryColor: "#E17A59"
  property color tertiaryColor: "#E17A59"
  property color textColor: "black"
  property color shadowColor: "black"
  property color highlightColor: "black"
  property bool mouseOverBar: false
  property bool noWindows: true
  property bool fullHeight: false
  property int barHeight: 40
  property int marginSize: 10
  property int animType: Easing.OutElastic
  property int animDuration: 600
  property real animAmp: 0.5
  property real animOvershoot: 0.1
  property real animPeriod: 0.8
}
