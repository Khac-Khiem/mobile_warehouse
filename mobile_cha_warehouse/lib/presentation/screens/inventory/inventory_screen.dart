import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../function.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.west,
              color: Colors.white,
            )),
        backgroundColor: Color(0xff001D37),
        title: Text('Kiểm kê',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont)),
      ),
      endDrawer: DrawerUser(),
      body: Column(
        children: [
          Row(
            children: [
              CustomizedButton(onPressed: () {
                Navigator.of(context).pushNamed('');
              })
            ],
          ),
          Row(
              children: labelTextList
                  .map((text) => LabelText(
                        text: text,
                      ))
                  .toList()),

          // Column(
          //     children: textFieldContent
          //         .map((text) => Row(
          //           children: [

          //           ]
          //         ))
          //         .toList()),
          ListView.builder(
              itemCount: textFieldContent.length,
              itemBuilder: (context, index) {
                return Column(
                    children: textFieldContent
                        .map((text) => Row(
                              children: [
                                LabelText(text: text.containerId),
                                LabelText(text: text.itemId),
                                LabelText(
                                    text: text.plannedQuantity.toString()),
                                TextInput(''),
                              ],
                            ))
                        .toList());
              })
        ],
      ),
    );
  }
}

List<String> labelTextList = [
  "Mã QR/Mã rỗ:",
  "Mã sản phẩm:",
  "Khối/số lượng:",
  "Thực kiểm:",
];

class InventoryData {
  String containerId;
  String itemId;
  double plannedQuantity;
  double actualQuantity;
  InventoryData(
      {required this.containerId,
      required this.itemId,
      required this.plannedQuantity,
      this.actualQuantity = 0});
}

//quét mã qr sẽ cộng thêm 1 inventorydata vào list
List<InventoryData> textFieldContent = [];

class LabelText extends StatelessWidget {
  String text;
  LabelText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * SizeConfig.ratioHeight),
      alignment: Alignment.centerRight,

      width: 80 * SizeConfig.ratioWidth,
      height: 55 * SizeConfig.ratioHeight,
      //color: Colors.amber,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  String contentTextField;
  TextInput(this.contentTextField);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.ratioHeight),
        alignment: Alignment.centerRight,
        width: 160 * SizeConfig.ratioWidth,
        height: 55 * SizeConfig.ratioHeight,
        //color: Colors.grey[200],
        child: TextField(
          enabled: true,
          readOnly: true,
          controller: TextEditingController(text: contentTextField),
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20 * SizeConfig.ratioFont),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10 * SizeConfig.ratioHeight),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
          ),
        ));
  }
}
