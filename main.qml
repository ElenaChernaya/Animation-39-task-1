import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: "Animation"

    Rectangle {
        id: scene
        anchors.fill: parent
        state: "LeftState"


        Rectangle {
            id: leftRectangle
            x: 100
            y: 300
            width: 100
            height: 100
            color: "lightblue"
            border.color: "#a200ff"
            border.width: 1

            //
            MouseArea {
                anchors.fill: parent
                onClicked:
                {
                    circle.x += 30
                    circle.y -= 30

                    /* change the color of the right rectangle and the circle itself,
                    when the circle touches the border of the right rectangle */
                    if(circle.x + circle.width >= rightRectangle.x
                            || circle.y <= rightRectangle.y + rightRectangle.height)
                    {
                        rightRectangle.color = "lightblue"
                        leftRectangle.color = "#c796df"
                        circle.color = "#851ba2"
                        circle.border.color = "black"
                        scene.state = "RightState"

                    }

                    else scene.state = "CurrentState"
                }
            }
        }


        Rectangle {
            id: rightRectangle
            x: 400
            y: 0
            width: 100
            height: 100
            color: "#c796df"
            border.color: "#a200ff"
            border.width: 1

            //
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    /* When you click on the right square, we change the colors of all the shapes to the original ones,
                    and return the circle to its original position, i.e. to the left square */

                    scene.state = "RightState"
                    rightRectangle.color = "#c796df"
                    leftRectangle.color = "lightblue"
                    circle.color = "#d42aff"
                    circle.border.color = "#851ba2"
                }
            }
        }


        Rectangle {
            id: circle
            x: leftRectangle.x+5
            y: leftRectangle.y+5
            width: leftRectangle.width - 10
            height: leftRectangle.height - 10
            radius: width/2
            color: "#d42aff"
            border.color: "#851ba2"
            border.width: 1

        }

        states: [
            State {
                name: "LeftState"
                PropertyChanges {
                    target: circle
                    x: leftRectangle.x+5
                    y: leftRectangle.y+5
                }
            },

            State {
                name: "CurrentState"
                PropertyChanges {
                    target: circle
                    x: circle.x
                    y: circle.y
                }
            },

            State {
                name: "RightState"
                PropertyChanges {
                    target: circle
                    x: leftRectangle.x+5
                    y: leftRectangle.y+5
                }
            }
        ]


        transitions:
            Transition {
                from: "CurrentState"
                to: "RightState"
                NumberAnimation {
                    properties: "x,y"
                    duration: 1000
                    easing.type: Easing.OutBounce
                }
            }
    }
}
