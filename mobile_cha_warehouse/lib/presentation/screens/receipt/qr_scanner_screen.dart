import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/list_container_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

String scanQRresult = '-1'; //Scan QR ra

//bb210505141725631
class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#e60000', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      scanQRresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                if (scanQRresult != "-1") {
                  // AlertDialogTwoBtnCustomized(
                  //         context: context,
                  //         title: "Bạn có chắc?",
                  //         desc:
                  //             "Khi nhấn nút Trở về, mọi dữ liệu sẽ không được lưu",
                  //         onPressedBtn1: () {
                  //           Navigator.pop(context);
                  //         },
                  //         onPressedBtn2: () {})
                  //     .show();
                } else {
                  Navigator.of(context).pop();
                }
              }),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Quét mã QR',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        endDrawer: DrawerUser(),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        scanQRresult != '-1'
                            ? 'Kết quả : $scanQRresult\n'
                            : 'Vui lòng quét mã QR',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanQRresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                        scanQRresult = '1';
                        scanQR();
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        onPressed: () {
                          // BlocProvider.of<CheckInfoBloc>(context).add(
                          //     CheckInfoEventRequested(
                          //         timeStamp: DateTime.now(),
                          //         basketID: scanQRresult));
                          // Navigator.pushNamed(context, '/modify_info_screen');
                          //
                          basketReceiptId == 'undefined'
                              ? () {
                                  Navigator.pushNamed(
                                      context, '/modify_info_screen');
                                }
                              : () {
                                  scanQRresult == basketReceiptId
                                      ? () {
                                          AlertDialogTwoBtnCustomized(
                                              context,
                                              "Xác Nhận",
                                              "Bạn đã lấy đúng rổ, nhấn xác nhận để hoàn thành",
                                              "Xác nhận",
                                              "Trở lại", () async {
                                            //add event click toggle container
                                            // BlocProvider.of<ReceiptBloc>(context).add(
                                            //   ToggleReceiptEvent(basketReceiptIndex));
                                            BlocProvider.of<CheckInfoBloc>(
                                                    context)
                                                .add(CheckInfoEventRequested(
                                                    timeStamp: DateTime.now(),
                                                    basketID: scanQRresult));
                                            Navigator.pushNamed(
                                                context, '/modify_info_screen');
                                          }, () {}, 18, 22);
                                        }
                                      : () {
                                          AlertDialogTwoBtnCustomized(
                                              context,
                                              "Xác Nhận",
                                              "Rổ bạn đã lấy không chính xác, nhấn Tiếp tục để quét lại",
                                              "Tiếp tục",
                                              "Trở lại",
                                              () {}, () {
                                            //back to container screen
                                            Navigator.pushNamed(context,
                                                '/list_container_screen');
                                          }, 18, 22);
                                        };
                                };
                        },
                        text: basketReceiptId == 'undefined'
                            ? 'Xác nhận'
                            : (scanQRresult == basketReceiptId
                                ? 'Xác Nhận'
                                : 'Trở lại'))
                  ]));
        }));
  }
}
