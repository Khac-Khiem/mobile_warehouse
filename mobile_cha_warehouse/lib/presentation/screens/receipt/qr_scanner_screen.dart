import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
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
                  //         title: "B???n c?? ch???c?",
                  //         desc:
                  //             "Khi nh???n n??t Tr??? v???, m???i d??? li???u s??? kh??ng ???????c l??u",
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
            'Qu??t m?? QR',
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
                            ? 'K???t qu??? : $scanQRresult\n'
                            : 'Vui l??ng qu??t m?? QR',
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
                      text: "Qu??t m?? QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        onPressed: scanQRresult == '-1'
                            ? () {
                                // AlertDialogTwoBtnCustomized(
                                //         context,
                                //         'B???n c?? ch???c',
                                //         'Ch??a c?? r??? ???????c qu??t?',
                                //         'X??c nh???n',
                                //         'Tr??? l???i',
                                //         () async {},
                                //         () {},
                                //         18,
                                //         22)
                                //     .show();
                                // test
                                // BlocProvider.of<StockCardViewBloc>(context).add(
                                //     StockCardViewEventLoadAllProductID(
                                //         DateTime.now()));

                                // Navigator.pushNamed(
                                //     context, '/modify_info_screen');
                              }
                            : () {
                                // load itemId
                                BlocProvider.of<StockCardViewBloc>(context).add(
                                    StockCardViewEventLoadAllProductID(
                                        DateTime.now()));
                                // BlocProvider.of<CheckInfoBloc>(context).add(
                                //     CheckInfoEventRequested(
                                //         timeStamp: DateTime.now(),
                                //         basketID: scanQRresult));
                                Navigator.pushNamed(
                                    context, '/modify_info_screen');
                              },
                        text: 'X??c nh???n')
                  ]));
        }));
  }
}
