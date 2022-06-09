import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class ListContainerReceiptScreen extends StatelessWidget {
  // List<GoodsIssueEntryContainerData> goodsIssueEntryContainerData;
  ListContainerReceiptScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              AlertDialogTwoBtnCustomized(
                      context,
                      'Ban co chac',
                      'Khi nhan tro lai, moi du lieu se khong duoc luu',
                      'Tro lai',
                      'Tiep tuc', () {
                Navigator.pushNamed(context, '///');
              }, () {}, 18, 22)
                  .show();
            },
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Danh sách các rổ đã nhập',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<ReceiptBloc, ReceiptState>(
            listener: (context, receiptState) {},
            builder: (context, receiptState) {
              if (receiptState is ReceiptStateListLoading) {
                return CircularLoading();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: 380 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          // ignore: deprecated_member_use
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 80 * SizeConfig.ratioWidth,
                                  child: Text(
                                    "Mã Rổ",
                                    style: TextStyle(
                                        fontSize: 21 * SizeConfig.ratioFont,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                width: 100 * SizeConfig.ratioWidth,
                                child: Text(
                                  "SL",
                                  style: TextStyle(
                                      fontSize: 21 * SizeConfig.ratioFont,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 120 * SizeConfig.ratioWidth,
                                child: Text(
                                  "Ngày SX",
                                  style: TextStyle(
                                      fontSize: 21 * SizeConfig.ratioFont,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                      goodsReceiptEntryConainerData.isEmpty
                          ? ExceptionErrorState(
                              height: 300,
                              title: "Chưa có rổ được nhập",
                              message: "Quét mã để tiến hành nhập kho",
                              imageDirectory: 'lib/assets/sad_face_search.png',
                              imageHeight: 140,
                            )
                          : Column(
                              children: goodsReceiptEntryConainerData
                                  .map((item) => RowContainer(item))
                                  .toList(),
                            ),
                    
                      CustomizedButton(
                          text: 'Quét mã',
                          onPressed: () {
                            scanQRresult = '-1';
                            //   Navigator.pushNamed(context, '/modify_info_screen');
                            Navigator.pushNamed(context, '/qr_scanner_screen');
                          }),
                      CustomizedButton(
                          text: 'Xác nhận',
                          onPressed: () async {
                            AlertDialogTwoBtnCustomized(
                                    context,
                                    'Bạn có chắc',
                                    'Xác nhận bạn đã nhập đủ số lượng?',
                                    'Xác nhận',
                                    'Trở lại', () async {
                              // add container event
                              // BlocProvider.of<ReceiptBloc>(context).add(
                              //     AddContainerEvent(
                              //         DateTime.now(),
                              //         goodsReceiptEntryConainerData,
                              //         selectedGoodReceiptId));
                              Navigator.pushNamed(context, '/receipt_screen');
                            }, () {}, 18, 22)
                                .show();
                          })
                    ],
                  ),
                );
              }
            }));
  }
}

class RowContainer extends StatelessWidget {
  GoodsReceiptEntryContainerData goodsReceiptEntryContainerData;
  RowContainer(this.goodsReceiptEntryContainerData);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 80 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
               style: ElevatedButton.styleFrom(
              primary:
                 
                   Colors.grey[300],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),

              // primary: bgColor,
              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
           // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 140 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsReceiptEntryContainerData.containerId,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 120 * SizeConfig.ratioWidth,
                  child: Text(goodsReceiptEntryContainerData.itemId,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryContainerData.plannedQuantity.toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            // color: Colors.grey[300],
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              // Navigator.pushNamed(context, '/qr_scanner_screen');
            },
          ),
        ),
      ),
    );
  }
}
