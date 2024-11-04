import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import RosQML2

Rectangle {
    id: userPopup
    width: 600
    height: 400
    color: Constants.surfaceColor

    
    property int  state: 0
    
    property string _headerLayoutText: "Trạng thái"
    
    
    
    RowLayout {
        id: header_layout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.1
        Text {
            color: Constants.textColorPrimary
            text: qsTr(_headerLayoutText)
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
                popup_close();
            }
            //     animation_goout.start();
            //     animation_forward.start();
            onPressedChanged: {
                if (pressed) {
                    background.color = "#607D8B";
                } else {
                    background.color = "#FFFFFF";
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
                    background.color = "#F44336";
                } else {
                    background.color = "#FFFFFF";
                }
            }
            onClicked: {
                if (state === 0) {
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
                            "location_id": _location_id.text
                        };
                        backend.deleteDataBuffer(JSON.stringify(jsonObject, null, 2));
                    } else {
                        _headerLayoutText = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có";
                    }
                } else if (state === 1) {
                    if (uuid_queue.text != "-----") {
                        backend.deleteDataQueue(uuid_queue.text);
                        clearDataQueue();
                    } else {
                        _headerLayoutText = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có";
                    }
                } else if (state === 2) {
                    if (__id__.text != "-----") {
                        var jsonObject = {
                            "_id": __id__.text,
                            "Merchandise": list_model.editText,
                            "Count": list_count.editText,
                            "height": _height__.text,
                            "width": _width__.text,
                            "length": _length__.text,
                            "pallet_type": _pallet_type__.text
                        };
                        backend.deleteDataModel(JSON.stringify(jsonObject, null, 2));
                        _headerLayoutText = " Thành công";
                    } else {
                        _headerLayoutText = " Mục không tồn tại - xóa chỉ khả dụng trên mục đã có";
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
                    background.color = "#4CAF50";
                } else {
                    background.color = "#FFFFFF";
                }
            }
            onClicked: {
                if (state === 0) {
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
                            "location_id": _location_id.text
                        };
                        backend.saveDataBuffer(JSON.stringify(jsonObject, null, 2));
                    } else {
                        _headerLayoutText = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có";
                    }
                } else if (state === 1) {
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
                            "Barcode": _Barcode_.text,
                            "Time": _Time_.text,
                            "queue": _queue_.text
                        };
                        // console.log(JSON.stringify(jsonObject, null, 2))

                        backend.saveDataQueue(JSON.stringify(jsonObject, null, 2));
                        // backend.setDataQueue(parseInt(_queue_.text))
                    } else {
                        _headerLayoutText = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có";
                    }
                } else if (state === 2) {
                    if (__id__.text != "-----") {
                        var jsonObject = {
                            "_id": __id__.text,
                            "Merchandise": list_model.editText,
                            "Count": list_count.editText,
                            "height": _height__.text,
                            "width": _width__.text,
                            "length": _length__.text,
                            "pallet_type": _pallet_type__.text
                        };

                        backend.saveDataModel(JSON.stringify(jsonObject, null, 2));
                        _headerLayoutText = "Thành công";
                    } else {
                        _headerLayoutText = " Mục không tồn tại - sửa và lưu chỉ khả dụng với mục đã có";
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
                    background.color = "#9E9E9E";
                } else {
                    background.color = "#FFFFFF";
                }
            }
            onClicked: {
                if (state === 2) {
                    if (__id__.text == "-----") {
                        var jsonObject = {
                            "_id": __id__.text,
                            "Merchandise": list_model.editText,
                            "Count": list_count.editText,
                            "height": _height__.text,
                            "width": _width__.text,
                            "length": _length__.text,
                            "pallet_type": _pallet_type__.text
                        };
                        backend.addDataModel(JSON.stringify(jsonObject, null, 2));
                        _headerLayoutText = " Thành công";
                    } else {
                        _headerLayoutText = " Mục đã tồn tại - hãy ấn sửa ";
                    }
                } else if (state === 1) {
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
                            "Barcode": _Barcode_.text,
                            "Time": _Time_.text,
                            "queue": _queue_.text
                        };
                        // console.log(JSON.stringify(jsonObject, null, 2))

                        backend.addDataQueue(JSON.stringify(jsonObject, null, 2));
                    } else {
                        _headerLayoutText = " Mục đã tồn tại - hãy ấn sửa ";
                    }
                } else if (state === 0) {
                    if (___id.text === "-----") {
                        jsonObject = {
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
                            "location_id": _location_id.text
                        };
                        backend.addDataBuffer(JSON.stringify(jsonObject, null, 2));
                    } else {
                        _headerLayoutText = " Mục đã tồn tại - hãy ấn sửa ";
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
                backend.getDataComboBox();
                backend.getDataComboBox2();
                state = 2;
                // pop_up_2.close()
            }
            onPressedChanged: {
                if (pressed) {
                    background.color = "#607D8B";
                } else {
                    background.color = "#FFFFFF";
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
        currentIndex: userPopup.state
        MyBuffer_item {
            id: buffer_item
        }
        MyGrid_queue {
            id: grid_queue
        }

        MyModel_pallet {
            id: model_pallet
        }
    }
}
