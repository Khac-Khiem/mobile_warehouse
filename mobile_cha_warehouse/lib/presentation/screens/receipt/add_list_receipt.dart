import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_screen.dart';
import '../../../function.dart';
// trang nay dung de xem lai cac ro da quet QR
List<QRScannedData> listReceiptsChecked = [];

class AddListReceiptScreen extends StatefulWidget {
  @override
  State<AddListReceiptScreen> createState() => _AddListReceiptScreenState();
}

class _AddListReceiptScreenState extends State<AddListReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
                width: 380 * SizeConfig.ratioWidth,
                height: 60 * SizeConfig.ratioHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 120 * SizeConfig.ratioWidth,
                        child: Text(
                          "Mã Rổ",
                          style: TextStyle(
                              fontSize: 21 * SizeConfig.ratioFont,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 60 * SizeConfig.ratioWidth,
                      child: Text(
                        "Mã SP",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(
                        "Thực kiểm",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 80 * SizeConfig.ratioWidth,
                      child: Text(
                        "SL",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                     SizedBox(
                      width: 80 * SizeConfig.ratioWidth,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
          ),
          Column(
              children: listReceiptsChecked.map((e) => RowReceipt(e)).toList()),
          // CustomizedButton(
          //   text: "Quét mã QR",
          //   bgColor: Constants.mainColor,
          //   fgColor: Colors.white,
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/qr_scanner_screen');
          //   },
          // ),
        ],
      ),
    );
  }
}

class RowReceipt extends StatelessWidget {
  QRScannedData goodsReceiptEntryRow;

  RowReceipt(this.goodsReceiptEntryRow);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 60 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 120 * SizeConfig.ratioWidth,
                  child: Text(
                    goodsReceiptEntryRow.containerId,
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 60 * SizeConfig.ratioWidth,
                child: Text(goodsReceiptEntryRow.itemId,
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 100 * SizeConfig.ratioWidth,
                child: Text(
                    goodsReceiptEntryRow.plannedQuantity
                        .toString(),
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 80 * SizeConfig.ratioWidth,
                child: Text(
                    goodsReceiptEntryRow.actualQuantity
                        .toString(),
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 80 * SizeConfig.ratioWidth,
                child: Text(
                    goodsReceiptEntryRow.productionDate
                        .toString(),
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
