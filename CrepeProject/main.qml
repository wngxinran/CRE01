import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1


ApplicationWindow {
    title: qsTr("Crepe Shop")
    width: 480
    height: 640
    visible: true

    property color backgroud_color: "#242327"

    // default users selections
    property var selections: { 'gluten_free':   false,
                               'extra_crispy':  false,
                               'number_of_eggs': 1,
                               'onion':         true,
                               'cilantro':      true,
                               'sesame':        true,
                               'wonton':        true,
                               'hotdog':        true,
                               'sweet':         false,
                               'spicy':         true

    }

    color: backgroud_color

    toolBar: BorderImage {
        border.bottom: 8
        source: "../images/toolbar.png"
        width: parent.width
        height: 50
        visible: stack.depth > 1 ? 1: 0

        Rectangle {
            id: backButton
            width: opacity ? 40 : 0
            anchors.left: parent.left
            anchors.leftMargin: 10
            opacity: stack.depth > 2 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 40
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    if (stack.depth > 2) {
                        update_selections();
                        // display_choices();
                        stack.pop();
                    }
                }
            }
        }
        Text {
            font.pixelSize: 32
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: stack.depth > 2 ? "Back": ""//"Crepe Shop"
        }
        Text {
            font.pixelSize: 32
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: next_button.x - next_button.width - 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: stack.depth > 1 ? "Next": ""
        }

        Image {
            id: next_button
            source: "../images/navigation_next_item.png"
            anchors {right: parent.right; verticalCenter: parent.verticalCenter; margins: 24 }
            opacity: 1 //stack.depth > 1 ? 0 : 1
            scale: nav_ma.pressed ? 1.2 : 1
            MouseArea {
                id: nav_ma;
                anchors.fill: parent;
                onClicked: {
                    // if welcome_page, go to CrepeSelectView
                    if (stack.depth == 1) {
                        stack.push({item:Qt.resolvedUrl("../pages/CrepeSelectView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "CrepeSelect",
                                           m_selections: selections
                                       }})
                    }
                    // if CrepeSelectView, go to eggs
                    else if (stack.depth == 2) {
                        var crepe_item = stack.find(function(item, index) { return item.objectName === "CrepeSelect" })
                        selections.gluten_free = crepe_item.is_gluten_free();
                        selections.extra_crispy = crepe_item.is_extra_crispy();
                        // debug
//                        display_choices();

                        stack.push({item:Qt.resolvedUrl("../pages/EggsSelectView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "EggsSelect",
                                           m_selections: selections
                                       }})
                    }
                    // if EggsSelectView, go to toppings
                    else if (stack.depth == 3) {
                        var eggs_item = stack.find(function(item, index) { return item.objectName === "EggsSelect" })
                        selections.number_of_eggs = eggs_item.number_of_eggs();
                        // debug
//                        display_choices();

                        stack.push({item:Qt.resolvedUrl("../pages/ToppingsSelectView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "ToppingsSelect",
                                           m_selections: selections
                                       }})
                    }
                    // if ToppingsSelectView, go to sauces
                    else if (stack.depth == 4) {
                        var toppings_item = stack.find(function(item, index) { return item.objectName === "ToppingsSelect" })
                        selections.onion = toppings_item.is_onion();
                        selections.cilantro = toppings_item.is_cilantro();
                        selections.sesame = toppings_item.is_sesame();
                        // debug
//                        display_choices();

                        stack.push({item:Qt.resolvedUrl("../pages/SaucesSelectView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "SaucesSelect",
                                           m_selections: selections
                                       }})
                    }
                    // if SaucesSelectView, go to fillings
                    else if (stack.depth == 5) {
                        var sauces_item = stack.find(function(item, index) { return item.objectName === "SaucesSelect" })
                        selections.spicy = sauces_item.is_spicy();
                        selections.sweet = sauces_item.is_sweet();
                        // debug
//                        display_choices();

                        stack.push({item:Qt.resolvedUrl("../pages/FillingsSelectView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "FillingsSelect",
                                           m_selections: selections
                                       }})
                    }
                    // if FillingsSelectView, go to summary
                    else if (stack.depth == 6) {
                        var fillings_item = stack.find(function(item, index) { return item.objectName === "FillingsSelect" })
                        selections.wonton = fillings_item.is_wonton();
                        selections.hotdog = fillings_item.is_hotdog();
                        // debug
//                        display_choices();

                        stack.push({item:Qt.resolvedUrl("../pages/SummaryView.qml"),
                                       immediate: false, replace: false,
                                       properties: {objectName: "Summary",
                                           m_selections: selections
                                       }})
                    }
                }
                smooth: true
            }
        }
    }

    // test
    StackView {
        id: stack
        initialItem: view

        Component {
            id: view
            MouseArea {
                Image {
                    id: welcome_image
                    source: "qrc:/images/welcome.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                }

                onClicked: {
                    launch_screen_timer.stop();
                    stack.push({item:Qt.resolvedUrl("../pages/CrepeSelectView.qml"),
                                          immediate: false, replace: false,
                                          properties: {objectName: "CrepeSelect",
                                              m_selections: selections
                                          }})
                }
            }
        }
    }


    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    Timer {
        id: launch_screen_timer
        interval: 2000
        running: true
        repeat: false

        onTriggered: {
            stack.push({item:Qt.resolvedUrl("../pages/CrepeSelectView.qml"),
                                                      immediate: false, replace: false,
                                                      properties: {objectName: "CrepeSelect",
                                                          m_selections: selections
                                                      }})
        }
    }

    function update_selections() {
        if (stack.depth > 1) {
            var current_item = stack.currentItem;
            selections = current_item.m_selections;
        }
    }

    // debug functions
    function display_choices() {
        console.log("~~~~~~~~~~~~~ ", stack.currentItem, " ~~~~~~~~~~~~~",
                    "\ngluten: ", selections.gluten_free,
                    ", extra_crispy: ", selections.extra_crispy,
                    "\neggs: ",selections.number_of_eggs,
                    "\nG/C/S: ", selections.onion, "/", selections.cilantro, "/", selections.sesame,
                    "\nspicy: " , selections.spicy, ", sweet: ", selections.sweet,
                    "\nwonton: " , selections.wonton, ", hotdog: ", selections.hotdog);
    }
}
