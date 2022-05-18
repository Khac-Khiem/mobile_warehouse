import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/add_list_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/list_container_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  "Tồn tại:",
  "SL xuất:",
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

      width: 100 * SizeConfig.ratioWidth,
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
        width: 200 * SizeConfig.ratioWidth,
        height: 55 * SizeConfig.ratioHeight,
        //color: Colors.grey[200],
        child: TextField(
          enabled: true,
          onChanged: (value) => {
            qrScannedData[0].actualQuantity=int.parse(value)
          },
          //    readOnly: true,
          controller: contentTextField == ''
              ? TextEditingController()
              : TextEditingController(text: contentTextField),
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
              qrScannedData.add(QRScannedData(
                  checkInfoState.basket.id,
                  checkInfoState.basket.product.id,
                  checkInfoState.basket.plannedQuantity,
                  0,
                  DateTime.now()));
            }

            return SingleChildScrollView(
              //   child: Text('haha'),
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
                            TextInput(''),
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
                          text: "Xác nhận",
                          bgColor: Constants.mainColor,
                          fgColor: Colors.white,
                          onPressed: () async {
                            //add container on server
                            // BlocProvider.of<CheckInfoBloc>(context).add(
                            //     AddContainerEvent(
                            //         DateTime.now(),qrScannedData[0].containerId,qrScannedData[0].actualQuantity));
                             BlocProvider.of<ReceiptBloc>(context).add(
                               ToggleReceiptEvent(basketReceiptIndex)
                              );
                            
                            Navigator.pushNamed(
                                context, '/list_container_receipt_screen');
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
