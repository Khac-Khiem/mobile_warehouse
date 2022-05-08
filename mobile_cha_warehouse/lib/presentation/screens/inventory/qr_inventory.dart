import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';


String scanQRInventoryresult = '-1'; //Scan QR ra

//bb210505141725631
class QRScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScreen> {
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
      scanQRInventoryresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                if (scanQRInventoryresult!= "-1") {
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
                        scanQRInventoryresult != '-1'
                            ? 'Kết quả : $scanQRInventoryresult\n'
                            : 'Vui lòng quét mã QR',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanQRInventoryresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                      scanQR();
                 
                      Navigator.of(context)
                                  .popAndPushNamed("");
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: scanQRInventoryresult != '-1'
                          ? () {
                              Navigator.of(context)
                                  .popAndPushNamed("/inventory_screen");
                                  // tra thong tin basket sau do cong vao textfieldcontent 
                              // BlocProvider.of<CheckInfoBloc>(context).add(
                              //     CheckInfoEventRequested(
                              //         timeStamp: DateTime.now(),
                              //         basketID: scanQRresult));
                            }
                          : (){},
                      text: "Tiếp tục",
                    ),
                  
                    
                  ]));
        }));
  }
}
