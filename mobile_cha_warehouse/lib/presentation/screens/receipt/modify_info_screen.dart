import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/add_list_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  "Kế hoạch:",
  "Thực kiểm:",
  "Ngày SX:",
];

class LabelText extends StatelessWidget {
  String text;
  LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * SizeConfig.ratioHeight),
      alignment: Alignment.centerRight,

      width: 150 * SizeConfig.ratioWidth,
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

class QRScannedData {
  String containerId;
  String itemId;
  int plannedQuantity;
  int actualQuantity;
  DateTime productionDate;
  QRScannedData(this.containerId, this.itemId, this.plannedQuantity,
      this.actualQuantity, this.productionDate);
}

// dùng để hiển thị cho người dùng chỉnh sửa
List<QRScannedData> qrScannedData = [];

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

class ModifyInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }, //sự kiện mũi tên back
          ),
          backgroundColor: Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: Text(
            'Nhập kho',
            style: const TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocBuilder<CheckInfoBloc, CheckInfoState>(
            builder: (context, checkInfoState) {
          if (checkInfoState is CheckInfoStateLoading) {
            return CircularLoading();
          } else if (checkInfoState is CheckInfoStateFailure) {
            //lỗi
            return Container();
          }
          //state này là CheckInfoStateSuccess
          else {
            //dùng if nhưng mục đích là để ép kiểu, do không dùng as để ép được
            if (checkInfoState is CheckInfoStateSuccess) {
              qrScannedData.clear();
              qrScannedData[0].itemId = checkInfoState.basket.product.id;
              qrScannedData[0].containerId = checkInfoState.basket.id;
              qrScannedData[0].plannedQuantity =
                  checkInfoState.basket.plannedQuantity;
              qrScannedData[0].actualQuantity = 0;
              qrScannedData[0].productionDate = DateTime.now();
            }

            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 350 * SizeConfig.ratioWidth,
                      child: Row(
                        children: [
                          Column(
                              children: labelTextList
                                  .map((text) => LabelText(
                                        text,
                                      ))
                                  .toList()),
                          SizedBox(
                            width: 15 * SizeConfig.ratioWidth,
                          ),
                          Column(children: [
                            TextInput(qrScannedData[0].containerId),
                            TextInput(qrScannedData[0].itemId),
                            TextInput(
                                qrScannedData[0].plannedQuantity.toString()),
                            TextInput(
                                qrScannedData[0].actualQuantity.toString()),
                            TextInput(DateTime.now().toString()),
                          ])
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    Column(
                      children: [
                        CustomizedButton(
                          text: "Tiếp tục",
                          bgColor: Constants.mainColor,
                          fgColor: Colors.white,
                          onPressed: () {
                            listReceiptsChecked.add(qrScannedData[0]);
                            Navigator.pushNamed(context, '/receipt_screen');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
}
