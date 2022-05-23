import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_screen.dart';

import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

bool a = true;
List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  "SL kế hoạch:",
  "SL thực tế:",
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

      width: 135 * SizeConfig.ratioWidth,
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
//
String itemId = '';
int actual = 0;
int planned = 0;

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
          onChanged: (value) =>
              {qrScannedData[0].actualQuantity = int.parse(value)},
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
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }, //sự kiện mũi tên back
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Nhập kho',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: SingleChildScrollView(
          //   child: Text('haha'),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                        // TextInput(qrScannedData[0].containerId),
                        // lưu thông tin nhập mã sản phẩm
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              readOnly: true,

                              // onChanged: (value) =>
                              //     {qrScannedData[0].containerId = value},
                              controller:
                                  TextEditingController(text: scanQRresult),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        //
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              //  onChanged: (value) => {itemId = value},
                              readOnly: true,
                              controller: TextEditingController(text: receiptItemId),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        // Container(
                        //   width: 200 * SizeConfig.ratioWidth,
                        //   height: 55 * SizeConfig.ratioHeight,
                        //   padding: const EdgeInsets.all(0),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //         width: 1, color: Constants.mainColor),
                        //     // borderRadius: const BorderRadius.all(
                        //     //     const Radius.circular(10))),
                        //   ),
                        //   child: BlocBuilder<StockCardViewBloc,
                        //           StockCardViewState>(
                        //       builder: (context, stockCardState) {
                        //     if (stockCardState
                        //         is StockCardViewStateLoadingProduct) {
                        //       return const Center(
                        //           child: Text("Chờ tý, đang tải"));
                        //     } else {
                        //       return DropdownSearch(
                        //         dropdownSearchDecoration: InputDecoration(
                        //             contentPadding: SizeConfig.ratioHeight >= 1
                        //                 ? EdgeInsets.fromLTRB(
                        //                     50 * SizeConfig.ratioWidth,
                        //                     14 * SizeConfig.ratioHeight,
                        //                     3 * SizeConfig.ratioWidth,
                        //                     3 * SizeConfig.ratioHeight)
                        //                 : const EdgeInsets.fromLTRB(45, 7, 3,
                        //                     3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                        //             hintText: "Chọn mã",
                        //             hintStyle: TextStyle(
                        //                 fontSize: 16 * SizeConfig.ratioFont),
                        //             border: const UnderlineInputBorder(
                        //                 borderSide: BorderSide.none),
                        //             fillColor: Colors.blue),
                        //         showAsSuffixIcons: true,
                        //         popupTitle: Padding(
                        //           padding: const EdgeInsets.all(20),
                        //           child: Text(
                        //             "Chọn mã sản phẩm",
                        //             style: TextStyle(
                        //                 fontSize: 22 * SizeConfig.ratioFont),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ),
                        //         popupBackgroundColor: Colors.grey[200],
                        //         // popupShape: RoundedRectangleBorder(
                        //         //     borderRadius:
                        //         //         BorderRadius.circular(10)),
                        //         items: allProductIdList,
                        //         //searchBoxDecoration: InputDecoration(),
                        //         onChanged: (String? data) {
                        //           itemId = data.toString();
                        //         },
                        //         showSearchBox: true,
                        //         //  autoFocusSearchBox: true,
                        //       );
                        //     }
                        //   }),
                        // ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              onChanged: (value) =>
                                  {planned = int.parse(value)},
                              //    readOnly: true,
                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              onChanged: (value) => {actual = int.parse(value)},
                              //    readOnly: true,
                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        //TextInput(DateTime.now().toString()),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: DateTime.now().toString()),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
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
                        //
                        a = !a;
                        // add để gửi lên server
                        BlocProvider.of<ReceiptBloc>(context).add(
                            AddcontainerScanned(GoodsReceiptEntryContainerData(
                                scanQRresult,
                                receiptItemId,
                                planned,
                                actual,
                                DateTime.now().toString())));
                        print(goodsReceiptEntryConainerData);
                        BlocProvider.of<ReceiptBloc>(context).add(
                            AddContainerEvent(
                                DateTime.now(),
                                GoodsReceiptEntryContainerData(
                                    scanQRresult,
                                    receiptItemId,
                                    planned,
                                    actual,
                                    DateTime.now().toString()),
                                selectedGoodReceiptId));
                        Navigator.pushNamed(
                            context, '/list_container_receipt_screen');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
