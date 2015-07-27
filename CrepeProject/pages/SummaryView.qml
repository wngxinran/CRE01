import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
// Grid Layout
import QtQuick.Layouts 1.1

Item {

    property color backgroud_color: "transparent"

    // default users selections
    property var m_selections: { 'gluten_free':   false,
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

    property string m_image_name
    property double m_price
    property double m_base_price: 4
    property double m_unit_item_price: 0.5

    Rectangle {
        id: summary
//        width: parent.width
//        height: parent.height / 2
        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: summary_title
            text: "Review your order"
            style: Text.Raised; styleColor: "#AAAAAA"
            font.italic: true
            font.bold: true
            font.pixelSize: 24
            color: "yellow"
        }


        GridLayout {
            id: summary_grid
            anchors.top: summary_title.bottom
            anchors.margins: 20
            columns: 2
            rowSpacing: 10

            // batter
            Text {
                id: batter_text
                text: qsTr("Batter: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }
            Text {
                id: batter_choice
                text: m_selections.gluten_free ? qsTr("Gluten-free") : qsTr("Regular")
                font.pixelSize: 20
                color: "yellow"
            }

            // crispy
            Text {
                id: crispy_text
                text: qsTr("Crispy: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }
            Text {
                id: crispy_choice
                text: m_selections.extra_crispy ? qsTr("Extra crispy") : qsTr("Regular")
                font.pixelSize: 20
                color: "yellow"
            }

            // eggs
            Text {
                id: eggs_text
                text: qsTr("Eggs: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }
            Text {
                id: eggs_choice
                text: m_selections.number_of_eggs === 0 ?
                          qsTr("0") : (m_selections.number_of_eggs === 1 ?
                                           qsTr("1") : qsTr("2"))
                font.pixelSize: 20
                color: "yellow"
            }

            // toppings
            Text {
                id: toppings_text
                Layout.alignment: Qt.AlignTop
                text: qsTr("Veggies: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }

            ColumnLayout {
                id: toppings_choice
                Text {
                    text: "Green Onion"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: m_selections.onion
                }
                Text {
                    text: "Cilantro"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: m_selections.cilantro
                }
                Text {
                    text: "Sesame"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: m_selections.sesame
                }
                Text {
                    text: "No veggies"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: !(m_selections.onion || m_selections.cilantro || m_selections.sesame)
                }
            }

            // sauces
            Text {
                id: sauces_text
                text: qsTr("Sauce: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }

            Text {
                id: sauces_choice
                text: m_selections.spicy ? qsTr("Spicy") : qsTr("Sweet")
                font.pixelSize: 20
                color: "yellow"
            }

            // fillings
            Text {
                id: fillings_text
                Layout.alignment: Qt.AlignTop
                text: qsTr("Fillings: ")
                font.bold: true
                font.pixelSize: 20
                color: "yellow"
            }

            ColumnLayout {
                id: fillings_choice
                Text {
                    text: "Crispy wonton cracker"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: m_selections.wonton
                }
                Text {
                    text: "All beef hotdog"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: m_selections.hotdog
                }
                Text {
                    text: "No fillings"
                    font.pixelSize: 20
                    color: "yellow"
                    visible: !(m_selections.wonton || m_selections.hotdog)
                }
            }

        }

        RowLayout {
            id: total
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Text{
                id: order_total_text
                text: "Order total:"
                font.italic: true
                font.bold: true
                font.pixelSize: 24
                color: "yellow"
            }

            Text{
                id: order_total
                anchors.right: parent.right
                text: "$ " + m_price.toFixed(2)
                font.bold: false
                font.pixelSize: 24
                color: "yellow"
            }
        }

    }


//    Rectangle {
//        id: preview
//        width: parent.width
//        height: parent.height / 2
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left

//        Image {
//            id: preview_image
//            source: m_image_name
//            anchors.fill: parent
//            fillMode: Image.PreserveAspectCrop
//        }
//    }

    function cal_price() {
        m_price = m_base_price + m_unit_item_price *
                 // eggs
                ((m_selections.number_of_eggs -1) +
                 // wonton
                 (m_selections.wonton ? 1 : 0) +
                 (m_selections.hotdog ? 1: 0)
                 )
        return m_price

    }

    Component.onCompleted: {
        cal_price();
//        show_image();
    }

//    Component {
//        id: header_text_style


//    }


    Component {
        id: radio_button_style

        RadioButtonStyle {
            label: Text
            {
                text: control.text
                font.pixelSize: 20
                anchors.margins: 0
                horizontalAlignment: Text.left
                color: "yellow"
            }

            indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                radius: 9
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    anchors.fill: parent
                    visible: control.checked
                    color: "#555"
                    radius: 9
                    anchors.margins: 4
                }
            }
        }
    }

}


