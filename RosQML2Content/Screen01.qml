

/*
This is a UI file (.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import QtQuick.VirtualKeyboard 6.7
// import QtQuick.VirtualKeyboard.Components 6.7
// import backendqt 1.0
Page {
    id: page1
    visible: true
    width: 1720
    height: 980

    // color: "#FAFAFA"
    property double batteryPercentage: 0
    property double batteryVoltage: 0
    property double batteryCurrent: 0
    property int popup_mode: 0
    property string state_system: ""
    property string status_system: ""
    property string reset_mode: "RESET"
    property string homing_mode: "HOMING"
    property string stop_mode: "STOP"
    property string control_mode: "RUNNING"
    property string mode_mode: "MANUAL"
    property string status_mode: "INITIATING"
    property string state_mute: "qrc:/content/asset/sound.svg"
    property double vel_linear: 0
    property double vel_angular: 0
    property int volume_current: 80
    property int volume_: 80
    property string ip_agf: ""
    property string ready_icon_source: "qrc:/content/asset/svg.svg"
    property string color_state: ""
    property bool state_panel_edit: false
    property bool state_panel_queue: false
    property bool popup_confirm_visible: true
    property int state_edit: 0 // 0 -> buffer | 1 -> queue 
    property int  width_current: 100
    property string header_layout_text: "Trạng thái"
    property string model_data: ""
    property string count_data: ""
    property int  item_count: loadConfig()
    property var model_pallet_: getListModel()
    // property var count_pallet: []
    // Khi cần khôi phục cấu hình
    function loadConfig() {
        var config = 
        configManager.loadConfig("config.json")
        if (config.item_count !== undefined) {
            item_count = config.item_count
        }
        return item_count
    }
    function saveConfig(value_) {
            var config = {
                "item_count": value_
            }
            configManager.saveConfig(config, "config.json")
        }
    function getListCount() {
        backend.getDataComboBox2()
        var item = backend.getListCount()
        return item
    }
    function getListModel() {
        backend.getDataComboBox()
        var item = backend.getListModel()
        return item
    }

    function clearDataQueue() {
        uuid_queue.text = "-----"
        _Id_.text = "-----"
        _PalletInfo_.text = "-----"
        _Merchandise_.text = "-----"
        _NameModel_.text = "-----"
        _Destination_.text = "-----"
        _ZoneId_.text = "-----"
        _ColumnId_.text = "-----"
        _LocationId_.text = "-----"
        _queue_.text = "-----"
        _Model_.text = "-----"
        _Count_.text = "-----"
        _height_.text = "-----"
        _width_.text = "-----"
        _length_.text = "-----"
        _pallet_type_.text = "-----"

    }

    function popup_close() {
            header_layout_text = "Trạng thái"
            pop_up_2.close()
            backend.set_color()
        }
    // Component.onCompleted: loadConfig()

    // onClosing: {
    //         saveConfig()
    //     }
    Popup {
        id: popup
        x: page1.width * 0.15
        y: page1.height * 0.1
        width: page1.width * 0.7
        height: page1.height * 0.8
        visible: false
        font.italic: true
        font.pointSize: 50
        font.family: "Ubuntu"
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "#F0F8FF"
            radius: 20
            border.color: "#F0F8FF"
            border.width: 1
        }
        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: 64
                }
                NumberAnimation {
                    properties: "scale"
                    from: 0.75
                    to: 1
                    duration: 64
                }
            }
        }
        exit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 64
                }
                NumberAnimation {
                    properties: "scale"
                    from: 1
                    to: 0.75
                    duration: 64
                }
            }
        }
        Text {
            id: status_popup
            text: qsTr("Loading...")
            height: popup.height * 0.6
            anchors.top: header_popup.bottom
            anchors.left: popup.left
            anchors.right: popup.right
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 10
            font.pixelSize: 45 * popup.width / 884
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
        }
        Text {
            id: header_popup
            text: qsTr("Message")
            height: popup.height * 0.2
            anchors.top: popup.top
            anchors.left: popup.left
            anchors.right: popup.right
            anchors.rightMargin: 20
            font.pixelSize: 45 * popup.width / 884
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
        }
        Button {
            id: confirm_button_popup
            text: qsTr("Confirm")
            width: popup.width * 0.25
            anchors.top: status_popup.bottom
            anchors.bottom: parent.bottom
            anchors.right: close_button_popup.left
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 0
            anchors.bottomMargin: 10
            visible: popup_confirm_visible
            font.pixelSize: 40 * popup.width / 884
            background: Rectangle {
                color: "white"
                radius: 15
                border.color: "blue"
                border.width: 2
            }
            onClicked: {
                if (popup_mode === 1) {

                    if (mode_mode === "MANUAL") {
                        // mode_mode ="AUTO"
                        backend.requestMode("AUTO")
                    } else if (mode_mode === "AUTO") {
                        // mode_mode =  "MANUAL"
                        backend.requestMode("MANUAL")
                    }
                } else if (popup_mode === 0) {
                    confirm_button_popup.text = qsTr("Reset")
                    backend.resetError()
                }
                else if (popup_mode === 2) {
                    confirm_button_popup.text = qsTr("Reset")
                    backend.requestReset("request_reset")
                }

                popup.close()
            }
        }
        Button {
            id: close_button_popup
            text: qsTr("Close")
            width: popup.width * 0.25
            anchors.top: status_popup.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            anchors.topMargin: 0
            anchors.bottomMargin: 10

            font.pixelSize: 40 * popup.width / 884
            background: Rectangle {
                color: "white"
                radius: 15
                border.color: "red"
                border.width: 2
            }
            onClicked: popup.close()
        }

    }


    Popup {
        id: pop_up_2
        x: 0
        y: - page1.height * 0.08
        width: page1.width * 0.9
        height: page1.height * 0.65
        opacity: 1
        visible: false
        closePolicy: Popup.NoAutoClose
        // closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            color: "#ddffffff"
            border.color: "#db000000"
            border.width: 5  // Đặt nền trong suốt
            radius: 5
        }

        RowLayout {
            id: header_layout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.1
            Text {

                text: header_layout_text
                // text: " Trạng thái"
                anchors.fill: parent
                font.pointSize: 30 * parent.height / 50
            }
        }
        RowLayout {
            id: footer_layout
            anchors.top: stackLayout.bottom
            anchors.bottom: parent.bottom
            layoutDirection: Qt.RightToLeft
            spacing: 10
            width: parent.width * 0.6
            anchors.right: parent.right
            anchors.topMargin: 10

            
            Button {
                id: view_button
                // height: parent.height * 0.12
                text: "Trở về"
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true


                font.pointSize: 25 * view_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 10
                    border.color: "#607D8B"
                    border.width: 5
                }
                onClicked: {
                    
                    popup_close()
                }
                //     animation_goout.start();
                //     animation_forward.start();
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#607D8B"
                    } else {
                        background.color = "#FFFFFF"
                    }
                }
            }
            Button {
                id: del_button
                // height: parent.height * 0.12
                text: "Xóa"
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true

                font.pointSize: 25 * del_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 10
                    border.color: "#F44336"
                    border.width: 5
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#F44336"
                    } else {
                        background.color = "#FFFFFF"
                    }
                }
                onClicked: {

                    if (state_edit === 0) {
                        if (___id.text != "-----") {
                            var jsonObject = {
                            
                                "_id": ___id.text,
                                "id": _id.text,
                                "id_hang": _id_hang.text,
                                "status": _status.text,
                                "stt": _stt.text,
                                "type": _type.text,

                                "height": _height.text,
                                "width": _width.text,
                                "length": _length.text,
                                "zone_id": _zone_id.text,
                                "column_id": _column_id.text,
                                "location_id": _location_id.text,
                                
                            
                            };
                            backend.deleteDataBuffer(JSON.stringify(jsonObject, null, 2))
                        } else {
                            header_layout_text = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có"
                        }
                    } else if (state_edit === 1) {
                        if (uuid_queue.text != "-----") {
                            backend.deleteDataQueue(uuid_queue.text)
                            clearDataQueue()
                        } else {
                            header_layout_text = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có"
                        }
                    } else if (state_edit === 2) {
                        if (__id__.text != "-----") {

                        
                            var jsonObject = {
                                "_id": __id__.text,
                                "Merchandise": list_model.editText,
                                "Count": list_count.editText,
                                "height": _height__.text,
                                "width": _width__.text,
                                "length": _length__.text,
                                "pallet_type": _pallet_type__.text,
                                };
                            backend.deleteDataModel(JSON.stringify(jsonObject, null, 2))
                            header_layout_text = " Thành công"
                        }
                        else {
                            header_layout_text = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có"
                        }
                        
                        
                        
                        
                    }
                    
                }
        
            }
            Button {
                id: save_button
                // height: parent.height * 0.12
                text: "Lưu"
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                

                font.pointSize: 25 * save_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 10
                    border.color: "#4CAF50"
                    border.width: 5
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#4CAF50"
                    } else {
                        background.color = "#FFFFFF"
                    }
                }
                onClicked: {

                    if (state_edit === 0) {
                        if (___id.text != "-----") {
                            var jsonObject = {
                                "_id": ___id.text,
                                "id": _id.text,
                                "id_hang": _id_hang.text,
                                "status": _status.text,
                                "stt": _stt.text,
                                "type": _type.text,

                                "height": _height.text,
                                "width": _width.text,
                                "length": _length.text,
                                "zone_id": _zone_id.text,
                                "column_id": _column_id.text,
                                "location_id": _location_id.text,
                                
                            
                            };
                            backend.saveDataBuffer(JSON.stringify(jsonObject, null, 2))
                        } else {
                            header_layout_text  = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có"
                        }
                    } else if (state_edit === 1) {
                        if (uuid_queue.text != "-----") {
                            var jsonObject = {
                                "_id": uuid_queue.text,
                                "Id": _Id_.text,
                                "PalletInfo": _PalletInfo_.text,
                                "Model": _Model_.text,
                                "Merchandise": _Merchandise_.text,
                                "NameModel": _NameModel_.text,
                                "Destination": _Destination_.text,
                                "Count": _Count_.text,
                                "ZoneId": _ZoneId_.text,
                                "ColumnId": _ColumnId_.text,
                                "LocationId": _LocationId_.text,

                                "queue": _queue_.text,
                            
                            };
                            // console.log(JSON.stringify(jsonObject, null, 2))
                            
                            backend.saveDataQueue(JSON.stringify(jsonObject, null, 2))
                            // backend.setDataQueue(parseInt(_queue_.text))
                        } else {
                            header_layout_text  = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có"
                        }
                    } else if (state_edit === 2) {
                        if (__id__.text != "-----") {
                            var jsonObject = {
                                "_id": __id__.text,
                                "Merchandise": list_model.editText,
                                "Count": list_count.editText,
                                "height": _height__.text,
                                "width": _width__.text,
                                "length": _length__.text,
                                "pallet_type": _pallet_type__.text,
                                };

                                backend.saveDataModel(JSON.stringify(jsonObject, null, 2))
                                header_layout_text = "Thành công"
                        } else {
                            header_layout_text  = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có"
                        }
                        
                        
                        
                        
                    }
                }
    
            }
            Button {
                id: add_button
                // height: parent.height * 0.12
                text: "Thêm"

                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true

                font.pointSize: 25 * add_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 10
                    border.color: "#9E9E9E"
                    border.width: 5
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#9E9E9E"
                    } else {
                        background.color = "#FFFFFF"
                    }
                }
                onClicked: {

                    if ( state_edit === 2) {
                        if (__id__.text == "-----") {
                            var jsonObject = {
                                "_id": __id__.text,
                                "Merchandise": list_model.editText,
                                "Count": list_count.editText,
                                "height": _height__.text,
                                "width": _width__.text,
                                "length": _length__.text,
                                "pallet_type": _pallet_type__.text,
                                }; 
                                backend.addDataModel(JSON.stringify(jsonObject, null, 2))
                                header_layout_text = " Thành công"
                        } else {
                            header_layout_text  = " Mục đã tồn tại - hãy ấn sửa "
                        }
                        
                    } else if ( state_edit === 1) {
                        if (uuid_queue.text == "-----") {
                            var jsonObject = {
                                "_id": uuid_queue.text,
                                "Id": _Id_.text,
                                "PalletInfo": _PalletInfo_.text,
                                "Model": _Model_.text,
                                "Merchandise": _Merchandise_.text,
                                "NameModel": _NameModel_.text,
                                "Destination": _Destination_.text,
                                "Count": _Count_.text,
                                "ZoneId": _ZoneId_.text,
                                "ColumnId": _ColumnId_.text,
                                "LocationId": _LocationId_.text,

                                "queue": _queue_.text,
                            
                            };
                            // console.log(JSON.stringify(jsonObject, null, 2))
                            
                            backend.addDataQueue(JSON.stringify(jsonObject, null, 2))
                        } else {
                            header_layout_text  = " Mục đã tồn tại - hãy ấn sửa "
                        }
                    } else if (state_edit === 0) {
                        if (___id.text == "-----") {
                            var jsonObject = {
                                "_id": ___id.text,
                                "id": _id.text,
                                "id_hang": _id_hang.text,
                                "status": _status.text,
                                "stt": _stt.text,
                                "type": _type.text,

                                "height": _height.text,
                                "width": _width.text,
                                "length": _length.text,
                                "zone_id": _zone_id.text,
                                "column_id": _column_id.text,
                                "location_id": _location_id.text,
                                
                            
                            };
                        backend.addDataBuffer(JSON.stringify(jsonObject, null, 2))
                        } else {
                            header_layout_text  = " Mục đã tồn tại - hãy ấn sửa "
                        }
                    }
                }

            }

            Button {
                id: model_button
                // height: parent.height * 0.12
                text: "Model"
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true


                font.pointSize: 25 * view_button.height / 118
                font.family: "ubuntu"
                font.bold: true
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 10
                    border.color: "#607D8B"
                    border.width: 5
                }
                onClicked: {
                    backend.getDataComboBox()
                    backend.getDataComboBox2()
                    state_edit = 2
                    // pop_up_2.close()
                }
                onPressedChanged: {
                    if (pressed) {
                        background.color = "#607D8B"
                    } else {
                        background.color = "#FFFFFF"
                    }
                }
            }
        }
    
        
        StackLayout {
            id: stackLayout
            anchors.top: header_layout.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.73
            anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: 10
            currentIndex: state_edit
            Item {
                id: buffer_item
                GridLayout {
                    id: main_layout
                    anchors.top: parent.top
                    rowSpacing: 15
                    columnSpacing: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    rows: 4
                    columns: 6
                    Text {
                        text: qsTr("Unique ID: ")
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        font.pointSize: 20 *  main_layout.height / 364
                        Layout.column: 0
                        Layout.row: 0
                    }
                    Text {
                        text: qsTr("ID: ")
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.column: 2
                        Layout.row: 0
                    }
                    Text {
                        text: qsTr("ID Hàng: ")
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        font.pointSize: 15 * main_layout.height / 364
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.column: 4
                        Layout.row: 0
                    }
                    Text {
                        text: qsTr("Trạng thái: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 0
                        Layout.row: 1
                    }
                    Text {
                        text: qsTr("Số thứ tự: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 2
                        Layout.row: 1
                    }
                    Text {
                        text: qsTr("type: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 4
                        Layout.row: 1
                    }
                    Text {
                        text: qsTr("height")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 0
                        Layout.row: 2
                    }
                    Text {
                        text: qsTr("width: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 2
                        Layout.row: 2
                    }
                    Text {
                        text: qsTr("length: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 4
                        Layout.row: 2
                    }
                    Text {
                        text: qsTr("zone_id: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 0
                        Layout.row: 3
                    }
                    Text {
                        text: qsTr("column_id: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 2
                        Layout.row: 3
                    }
                    Text {
                        text: qsTr("location_id: ")
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.preferredWidth: parent.width * 0.15
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        Layout.column: 4
                        Layout.row: 3
                    }

                    TextField {
                        id: ___id
                        font.pixelSize: 25 * _id.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        readOnly: true
                        objectName: "____id"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.column: 1
                        Layout.row: 0
                        width: 150

                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            radius: 5
                            border.color: "#3850ff"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    TextField {
                        id: _id
                        objectName: "___id"
                        font.pixelSize: 25 * _id.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.column: 3
                        Layout.row: 0
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _id_hang
                        objectName: "___id_hang"
                        font.pixelSize: 25 * _id_hang.height / 45

                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 5
                        Layout.row: 0
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _status
                        objectName: "___status"
                        font.pixelSize: 25 * _status.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 1
                        Layout.row: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _stt
                        objectName: "___stt"
                        font.pixelSize: 25 * _stt.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 3
                        Layout.row: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _type
                        objectName: "___type"
                        font.pixelSize: 25 * _type.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 5
                        Layout.row: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _height
                        objectName: "___height"
                        font.pixelSize: 25 * _height.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 1
                        Layout.row: 2
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _width
                        objectName: "___width"
                        font.pixelSize: 25 * _width.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 3
                        Layout.row: 2
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _length
                        objectName: "___length"
                        font.pixelSize: 25 * _length.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 5
                        Layout.row: 2
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _zone_id
                        objectName: "___zone_id"
                        font.pixelSize: 25 * _zone_id.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 1
                        Layout.row: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _column_id
                        objectName: "___column_id"
                        font.pixelSize: 25 * _column_id.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 3
                        Layout.row: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _location_id
                        objectName: "___location_id"
                        font.pixelSize: 25 * _location_id.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        
                        onActiveFocusChanged: {
                            if(activeFocus) {
                                console.log("jomphere");
                                Qt.inputMethod.update(Qt.ImQueryInput)
                            }
                        }
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        property bool isBold: false
                        property real radius: 5
                        Layout.column: 5
                        Layout.row: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                }
            }
            Item {
                id: grid_queue
                GridLayout {
                    id: main_layout_queue
                    anchors.top: parent.top
                    rowSpacing: 15
                    columnSpacing: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    rows: 5
                    columns: 6

                    Text {
                        text: qsTr("Unique ID")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        Layout.row: 0
                        Layout.column: 0
                    }
                    Text {
                        text: qsTr("ID")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        Layout.row: 1
                        Layout.column: 0
                    }
                    Text {
                        text: qsTr("PalletInfo")
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.pointSize: 15 * main_layout.height / 364
                        Layout.row: 2
                        Layout.column: 0
                    }
                    
                    Text {
                        text: qsTr("Merchandise")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 0
                        Layout.column: 4
                    }

                    Text {
                        text: qsTr("NameModel")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 4
                        Layout.column: 0
                    }

                    Text {
                        text: qsTr("Barcode")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 5
                        Layout.column: 0
                    }

                    Text {
                        text: qsTr("Destination")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 0
                        Layout.column: 2
                    }
                    
                    Text {
                        text: qsTr("ZoneId")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 1
                        Layout.column: 2
                    }
                    Text {
                        text: qsTr("ColumnId")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 2
                        Layout.column: 2
                    }
                    Text {
                        text: qsTr("LocationId")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 3
                        Layout.column: 2
                    }

                    Text {
                        text: qsTr("Time")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 4
                        Layout.column: 2
                    }

                    Text {
                        text: qsTr("queue")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 5
                        Layout.column: 2
                    }
                    Text {
                        text: qsTr("Model")
                        font.pointSize: 15 * main_layout.height / 364
                        font.bold: true
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.family: "Ubuntu"
                        Layout.row: 3
                        Layout.column: 0
                    }
                    Text {
                        text: qsTr("Count")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 1
                        Layout.column: 4
                    }
                    Text {
                        text: qsTr("height")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 2
                        Layout.column: 4

                    }
                    Text {
                        text: qsTr("width")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 3
                        Layout.column: 4
                    }
                    Text {
                        text: qsTr("length")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 4
                        Layout.column: 4
                    }
                    Text {
                        text: qsTr("pallet_type")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.fillHeight: true
                        font.bold: true
                        Layout.row: 5
                        Layout.column: 4
                    }
                    

                    TextField {
                        id: uuid_queue
                        objectName: "uuid_queue"
                        font.pixelSize: 25 * uuid_queue.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        readOnly: true
                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 0
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _Id_
                        objectName: "_Id"
                        font.pixelSize: 25 * _Id_.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 1
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _PalletInfo_
                        objectName: "_PalletInfo"
                        font.pixelSize: 25 * _PalletInfo_.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 2
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    

                    TextField {
                        id: _Merchandise_
                        objectName: "_Merchandise"
                        font.pixelSize: 25 * _Merchandise_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 0
                        Layout.column: 5
                        
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _NameModel_
                        objectName: "_NameModel"
                        font.pixelSize: 25 * _NameModel_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 4
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _Barcode_
                        objectName: "_Barcode"
                        font.pixelSize: 25 * _Barcode_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 5
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _Destination_
                        objectName: "_Destination"
                        font.pixelSize: 25 * _Destination_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 0
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    

                    TextField {
                        id: _ZoneId_
                        objectName: "_ZoneId"
                        font.pixelSize: 25 * _ZoneId_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 1
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _ColumnId_
                        objectName: "_ColumnId"
                        font.pixelSize: 25 * _ColumnId_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 2
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _LocationId_
                        objectName: "_LocationId"
                        font.pixelSize: 25 * _LocationId_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 3
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }

                    TextField {
                        id: _Time_
                        objectName: "_Time"
                        font.pixelSize: 25 * _Time_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 4
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }


                    TextField {
                        id: _queue_
                        objectName: "_queue"
                        font.pixelSize: 25 * _queue_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 5
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _Model_
                        objectName: "_Model"
                        font.pixelSize: 25 * _Model_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 3
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _Count_
                        objectName: "_Count"
                        font.pixelSize: 25 * _Count_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 1
                        Layout.column: 5
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _height_
                        objectName: "_height"
                        font.pixelSize: 25 * _height_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 2
                        Layout.column: 5
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor
                        readOnly: true
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _width_
                        objectName: "_width"
                        font.pixelSize: 25 * _width_.height / 45
                        Layout.fillWidth: true
                        text: "-----"

                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 3
                        Layout.column: 5
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor
                        readOnly: true
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _length_
                        objectName: "_length"
                        font.pixelSize: 25 * _length_.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        readOnly: true
                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 4
                        Layout.column: 5
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _pallet_type_
                        objectName: "_pallet_type"
                        font.pixelSize: 25 * _pallet_type_.height / 45
                        Layout.fillWidth: true
                        text: "-----"
                        readOnly: true
                        property bool isBold: false
                        property real radius: 5
                        width: 150
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.fillHeight: true
                        Layout.row: 5
                        Layout.column: 5
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                }
            }

            Item {
                id: model_pallet
                GridLayout {
                    anchors.top: parent.top
                    rowSpacing: 15
                    columnSpacing: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    rows: 4
                    columns: 4

                    Text {
                        text: qsTr("Unique ID")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.width * 0.25
                        Layout.row: 0
                        Layout.column: 0
                    }
                    Text {
                        text: qsTr("Merchandise")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.row: 1
                        Layout.column: 0
                    }

                    Text {
                        text: qsTr("Count")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.width * 0.25
                        Layout.row: 2
                        Layout.column: 0
                    }
                    Text {
                        text: qsTr("height")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.width * 0.25
                        Layout.row: 0
                        Layout.column: 2
                    }
                    Text {
                        text: qsTr("width")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.width * 0.25
                        Layout.row: 1
                        Layout.column: 2
                    }
                    Text {
                        text: qsTr("length")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.row: 2
                        Layout.column: 2
                    }

                    Text {
                        text: qsTr("pallet_type")
                        font.pointSize: 15 * main_layout.height / 364
                        font.family: "Ubuntu"
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.width * 0.25
                        Layout.row: 3
                        Layout.column: 2
                    }
                    
                    TextField {
                        id: __id__
                        objectName: "__id__"
                        font.pixelSize: 20 * _height__.height / 45
                        text: "-----"
                        
                        readOnly: true
                        property bool isBold: false
                        property real radius: 5
                        // width: 150
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.preferredWidth: parent.width * 0.35
                        Layout.row: 0
                        Layout.column: 1
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    ComboBox {
                        id: list_model
                        editable: true
                        font.pixelSize: 20 * _height__.height / 45
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.preferredWidth: parent.width * 0.35
                        Layout.row: 1
                        Layout.column: 1
                        currentIndex: 0

                        // property var model_pallet_: backend.getListModel()
                        model: ListModel {
                            id: list_model_pallet
                        }

                        delegate: ItemDelegate {
                            text: model.text
                        }

                        Component.onCompleted: {
                            // Khởi tạo danh sách ban đầu
                            for (var i = 0; i < model_pallet_.length; i++) {
                                list_model_pallet.append({
                                                            "text": model_pallet_[i]
                                                        })
                            }
                        }
                        onEditTextChanged: {
                            model_data = editText
                            __id__.text = "-----"
                            _height__.text = "-----"
                            _width__.text = "-----"
                            _length__.text = "-----"
                            _pallet_type__.text = "-----"
                            backend.updateComboBox(model_data,count_data)
                            console.log("Selected fruit: " + editText)
                        }
                    }
                    ComboBox {
                        id: list_count
                        editable: true
                        font.pixelSize: 20 * _height__.height / 45
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.preferredWidth: parent.width * 0.35
                        Layout.row: 2
                        Layout.column: 1
                        currentIndex: 0

                        property var count_pallet: [6,8,10,12,14,16,18]
                        model: ListModel {
                            id: list_count_pallet
                        }

                        delegate: ItemDelegate {
                            text: model.text
                        }

                        Component.onCompleted: {
                            // Khởi tạo danh sách ban đầu
                            for (var i = 0; i < count_pallet.length; i++) {
                                list_count_pallet.append({
                                                            "text": count_pallet[i]
                                                        })
                            }
                        }
                        onEditTextChanged: {
                            count_data = editText
                            
                            __id__.text = "-----"
                            _height__.text = "-----"
                            _width__.text = "-----"
                            _length__.text = "-----"
                            _pallet_type__.text = "-----"
                            console.log("Selected fruit: " + editText)
                            backend.updateComboBox(model_data,count_data)
                            
                        }
                    }
                    TextField {
                        id: _height__
                        objectName: "_height__"
                        font.pixelSize: 25 * _height__.height / 45
                        
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        // width: 150
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.row: 0
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        } 
                        
                    }
                    TextField {
                        id: _width__
                        objectName: "_width__"
                        font.pixelSize: 25 * _width__.height / 45
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        // width: 150
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.row: 1
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _length__
                        objectName: "_length__"
                        font.pixelSize: 25 * _length__.height / 45
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        // width: 150
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.row: 2
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                    TextField {
                        id: _pallet_type__
                        objectName: "_pallet_type__"
                        font.pixelSize: 25 * _length__.height / 45
                        text: "-----"
                        focus: true
                        property bool isBold: false
                        property real radius: 5
                        // width: 150
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: parent.height * 0.25
                        Layout.row: 3
                        Layout.column: 3
                        placeholderTextColor: "#F44336" //AppStyle.placeholderColor

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            border.color: "#3850ff"
                        }
                    }
                }
            }

        }

    }

    Page {
        id: down_panel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: (parent.height) * 0.45
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: header
            height: page1.height * 0.1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.topMargin: 10
            background: Rectangle {

                color: "#90CAF9"
                radius: 25 * header.height / 94
            }

            Text {
                id: status_header
                text: qsTr("Initializing")
                anchors.fill: parent
                font.pixelSize: 30 * parent.height / 48
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: true
            }
        }

        ColumnLayout {
            id: may_cuon_phim
            width: parent.width * 0.075
            Rectangle {
                anchors.fill: parent
                color: "#F9A825"
                radius: 30 * parent.width / 100
                border.width: 1
            }
            anchors.left: parent.left
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 75 * down_panel.height / 445
            anchors.bottomMargin: 75 * down_panel.height / 445
            Text {
                text: qsTr("Máy") + '\n' + qsTr("cuốn") + '\n' + qsTr("phim")
                anchors.fill: parent
                font.pixelSize: 40 * parent.width / 125
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: false
            }
        }

        RowLayout {
            id: bang_tai
            anchors.left: may_cuon_phim.right
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 78 * down_panel.height / 445
            anchors.bottomMargin: 78 * down_panel.height / 445
            spacing: 0
            layoutDirection: Qt.LeftToRight

            Rectangle {
                Layout.preferredWidth: parent.width * 0.4
                Layout.preferredHeight:  parent.height 
                color: "#64B5F6"
                border.color: "#607D8B"
                border.width: 2
                Text {
                    anchors.fill: parent
                    text: "Băng tải chủ động"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 20

                }

            }
            Rectangle {
                Layout.preferredWidth: parent.width * 0.6
                Layout.preferredHeight:  parent.height
                color: "#B3E5FC"
                border.color: "#607D8B"
                border.width: 2
                Text {
                    anchors.fill: parent
                    text: "Băng tải free"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 20

                }

            }

        }

        RowLayout {
            id: bang_tai_
            anchors.fill: bang_tai
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            spacing: 2

            layoutDirection: Qt.RightToLeft
            // Rectangle {
            //     color: "#ae0808"
            //     anchors.fill: parent

            // }

            Button {
                id: palet_1

                text: qsTr("1")
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_1_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(1)
                    
                }

            }
            Button {
                id: palet_2
                
                text: qsTr("2")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_2_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(2)
                }

            }
            Button {
                id: palet_3
                
                text: qsTr("3")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_3_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(3)
                }
            }
            Button {
                id: palet_4
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("4")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_4_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(4)
                }
            }
            Button {
                id: palet_5
                
                text: qsTr("5")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_5_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(5)
                }
            }
            Button {
                id: palet_6
                
                text: qsTr("6")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: true
                background: Rectangle {
                    objectName: "zone_6_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(6)
                }
            }
            Button {
                id: palet_7
                
                text: qsTr("7")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                visible: true

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_7_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(7)
                }
            }
            Button {
                id: palet_8
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("8")


                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_8_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(8)
                }
            }
            Button {
                id: palet_9
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("9")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 8
                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_9_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(9)
                }
            }

            Button {
                id: palet_10
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("10")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                

                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 9
                background: Rectangle {
                    objectName: "zone_10_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(10)
                }
            }

            Button {
                id: palet_11
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("11")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 10
                background: Rectangle {
                    objectName: "zone_11_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(11)
                }
            }

            Button {
                id: palet_12
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("12")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 11

                font.bold: true
                font.pointSize: 30 * parent.height / 155

                background: Rectangle {
                    objectName: "zone_12_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(12)
                }
            }

            Button {
                id: palet_13
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("13")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                visible: item_count > 12
                background: Rectangle {
                    objectName: "zone_13_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(13)
                }
            }
            Button {
                id: palet_14
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("14")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 13
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                background: Rectangle {
                    objectName: "zone_14_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(14)
                }
            }
            Button {
                id: palet_15
                Layout.preferredHeight: width_current * parent.height / 167
                Layout.preferredWidth: width_current * parent.height / 167
                text: qsTr("15")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: item_count > 14
                font.bold: true
                font.pointSize: 30 * parent.height / 155
                background: Rectangle {
                    objectName: "zone_14_queue"
                    color: "#CFD8DC"
                    border.color: "#FF9800"
                    border.width: 2
                }
                onClicked: {
                    state_edit = 1
                    pop_up_2.open()
                    clearDataQueue()
                    backend.setDataQueue(15)
                }
            }


        }
        // Image {
        //     id: ready_icon
        //     x: palet_1.x + palet_1.width * 0.25
        //     y: palet_1.y - palet_1.width * 0.75
        //     source: ready_icon_source
        //     rotation: -180
        //     fillMode: Image.PreserveAspectFit
        //     visible: true
        //     height: palet_1.height * 0.5
        //     width: height
        // }
    }

    Page {
        id: up_panel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: down_panel.bottom
        anchors.bottom: parent.bottom

        RowLayout {
            id: waiting
            height: waiting.width / 6.5
            width: parent.width * 0.45
            anchors.left: parent.left
            anchors.top: parent.top

            anchors.leftMargin: 20
            anchors.topMargin: 25
            // anchors.rightMargin: 230
            spacing: 10

            Rectangle {
                id: none
                anchors.fill: parent
                Text {
                    text: qsTr("Hàng ") + qsTr("chờ")
                    anchors.bottom: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 40 * parent.width / 800
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.italic: false
                }
            }
            Button {

                text: qsTr("1")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_1"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()

                    backend.setDataBuffer("zone_1")
                }
            }

            Button {

                text: qsTr("2")
                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_2"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()
                    backend.setDataBuffer("zone_2")
                }
            }
            Button {

                text: qsTr("3")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_3"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()
                    backend.setDataBuffer("zone_3")
                }
            }
            Button {

                text: qsTr("4")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_4"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()
                    backend.setDataBuffer("zone_4")
                }
            }

            Button {

                text: qsTr("5")

                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_5"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()
                    backend.setDataBuffer("zone_5")
                }
            }

            Button {

                text: qsTr("6")


                Layout.fillHeight: true
                Layout.preferredWidth: waiting.height
                font.bold: true
                font.pointSize: 40 * parent.height / 150

                background: Rectangle {
                    objectName: "zone_6"
                    color: "#CFD8DC"
                }
                onClicked: {
                    state_edit = 0
                    pop_up_2.open()
                    backend.setDataBuffer("zone_6")
                }
            }
        }
        GridLayout {
            id: note

            width: parent.width * 0.15
            // anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            // anchors.bottom: waiting.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            // anchors.bottomMargin: 0
            ColumnLayout {
                id: layout_note_1
                width: 50
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 5
                Rectangle {
                    color: "#CFD8DC"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#FFEB3B"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#FF9800"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#4CAF50"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
                Rectangle {
                    color: "#2196F3"
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                }
            }
            ColumnLayout {

                id: layout_note_2
                anchors.left: layout_note_1.right
                anchors.right: parent.right 
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                // anchors.rightMargin: -150
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                spacing: 5
                Text {
                    height: 50
                    text: "Trống "
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    height: 50
                    text: "Pallet thấp"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    height: 50
                    text: "Pallet cao"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {

                    height: 50
                    text: "Pallet kép"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                Text {

                    height: 50
                    text: "Pallet đơn"
                    font.pixelSize: 35 * up_panel.height / 588
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }

        Slider {
            id: slider

            width: parent.width * 0.2
            height: parent.height * 0.1
            value: item_count
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.bottomMargin: 10
            live: true
            stepSize: 1
            to: 15
            from: 8
            onValueChanged: {
                item_count = value
                width_current = 140 - (value -8) * 7
                saveConfig(value)

            }
        }


    }

    ColumnLayout {
        width: parent.width * 0.15
        height: parent.height * 0.3
        visible: true
        anchors.right: parent.right
        anchors.top: up_panel.top
        // anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 10
        // rows: 3
        // columns: 2

        Button {
            id: stop_button
            text: stop_mode
            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#AB47BC"
                radius: 30 * parent.height / 120
                border.color: stop_button.background.color
                border.width: 1
            }
            onClicked: {
                if (stop_mode === "STOP") {
                    backend.requestStop("STOP")
                } else if (stop_mode === "PAUSED") {
                    backend.requestStop("RUN")
                }
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#E1BEE7";
                } else {
                    background.color = "#AB47BC";
                }
            }
        }

        Button {
            id: reset_button
            text: reset_mode

            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#4CAF50"
                radius: 30 * parent.height / 120
                border.color: reset_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 2
                status_popup.text = state_system
                
                popup_confirm_visible = true
                
                popup.open()
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#4CAF50";
                }
            }
        }

        Button {
            id: homming_button
            text: homing_mode
            
            Layout.fillWidth: true
            Layout.fillHeight: true
            highlighted: false
            font.bold: true
            font.pointSize: 45 * parent.height / 420

            background: Rectangle {
                color: "#FFFFFF"
                radius: 30 * parent.height / 120
                border.color: "#607D8B"
                border.width: 2
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#FFFFFF";
                }
            }
            // onClicked: {
            //     state_edit = 2
            //     pop_up_2.open()
            // }

        }


        


    }
    RowLayout {
        width: parent.width * 0.5
        height: 25 + 75 * parent.height / 1200
        visible: true
        anchors.left: parent.left
        anchors.bottom: down_panel.top
        // anchors.bottom: parent.bottom
        // anchors.rightMargin: 10
        anchors.leftMargin: parent.width * 0.25
        anchors.bottomMargin: 0
        spacing: 10
        // rows: 3
        // columns: 2

        Button {
            id: control_button
            text: qsTr(control_mode)
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200
            
            background: Rectangle {
                color: "#2196F3"
                radius: 30 * parent.height / 104
                border.color: control_button.background.color
                border.width: 1
            }
            onClicked: {
                if (control_mode === "RUNNING") {
                    backend.requestControl("STOP")
                } else if (control_mode === "PAUSED") {
                    backend.requestControl("RUN")
                }
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#A5D6A7";
                } else {
                    background.color = "#4CAF50";
                }
            }
        }
        Button {
            id: status_button
            text: status_mode

            

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200
            background: Rectangle {
                color: "white"
                radius: 30 * parent.height / 104
                border.color: status_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 0
                if (status_mode === "ERROR") {
                    status_popup.text = backend.robotError
                    popup_confirm_visible = true
                } else {
                    status_popup.text = backend.robotDetail
                    popup_confirm_visible = false
                }
                    

                popup.open()
            }
            
        }
        Button {
            id: mode_button
            text: qsTr(mode_mode)

            

            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            highlighted: false
            font.bold: true
            font.pointSize: 40 * parent.height / 200
            background: Rectangle {
                color: "#4CAF50"
                radius: 30 * parent.height / 104
                border.color: mode_button.background.color
                border.width: 1
            }
            onClicked: {
                popup_mode = 1
                popup_confirm_visible = true
                if (mode_mode === "MANUAL") {
                    // mode_mode ="AUTO"
                    status_popup.text = qsTr(
                                "Change robot mode to AUTO")
                    mode_button.background.color = "#4CAF50"
                } else if (mode_mode === "AUTO") {
                    // mode_mode =  "MANUAL"
                    status_popup.text = qsTr(
                                "Change robot mode to MANUAL")
                    mode_button.background.color = "#03A9F4"
                } else
                    status_popup.text = qsTr("Data false")
                popup.open()
            }
        }
    }
 
    // Thêm bàn phím ảo
    Keyboard {
        id: inputPanel
        height: parent.height * 0.25
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.15
        anchors.rightMargin: parent.width * 0.15
        visible: Qt.inputMethod.visible
        anchors.left: parent.left
        anchors.right: parent.right
        parent: Overlay.overlay

        
    }

    // Hiển thị bàn phím khi TextField nhận focus
    // Component.onCompleted: {
    //     inputPanel.active = inputField.hasActiveFocus
    // }
    Connections {
        target: backend
        onBatteryPercentageChanged: {
            batteryPercentage = backend.batteryPercentage
        }
        onBatteryVoltageChanged: {
            batteryVoltage = backend.batteryVoltage
        }
        onBatteryCurrentChanged: {
            batteryCurrent = backend.batteryCurrent
        }
        onRobotDetailChanged: {
            if (status_mode === "ERROR") {
                status_header.text = backend.robotError
            } else {
                status_header.text = backend.robotDetail
            }
        }
        onRobotModeChanged: {
            mode_mode = backend.robotMode
            if (mode_mode === "MANUAL") {
                mode_button.background.color = "#03A9F4"
            } else if (mode_mode === "AUTO") {
                mode_button.background.color = "#4CAF50"
            } else
                mode_button.background.color = "#FF9800"
        }
        onRobotStatusChanged: {
            status_mode = backend.robotStatus

            if ((status_mode === "ERROR") || (status_mode === "EMG")) {
                status_button.background.color = "#F44336"
            } else if (status_mode === "WAITING_INIT_POSE") {
                status_button.background.color = "#FFFFFF"
            } else if (status_mode === "NORMAL") {
                status_button.background.color = "#4CAF50"
            } else if (status_mode === "WAITING") {
                status_button.background.color = "#FFEB3B"
            } else {
                status_button.background.color = "#FF9800"
            }
        }
        onGetControlChanged: {
            control_mode = backend.getControl
            if (mode_mode === "AUTO" && control_mode === "RUNNING") {
                if (status_mode === "WAITING") {
                    control_button.background.color = "#2196F3"
                } else {
                    control_button.background.color = "#4CAF50"
                }
            } else if (mode_mode === "MANUAL" && control_mode === "RUNNING") {
                control_button.background.color = "#2196F3"
            } else if (control_mode === "PAUSE") {
                control_button.background.color = "#FFEB3B"
            } else
                control_button.background.color = "#FFEB3B"
        }
        onSystemStatusChanged: {
            state_system = "State AGF: " + backend.getStateSystem()
            
            status_system = backend.systemStatus
            reset_mode = backend.systemStatus
            if (backend.systemStatus === "ERROR") {
                reset_button.background.color = "#F44336"
                
                
                
            }
            else if (backend.systemStatus === "NORMAL") {
                reset_button.background.color = "#4CAF50"
            }
            
        }
    }

   
}
