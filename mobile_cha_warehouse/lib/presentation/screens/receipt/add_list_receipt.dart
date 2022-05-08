import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';
import '../../../function.dart';
// trang nay dung de xem lai cac ro da quet QR
List<GoodsReceiptEntryData> listReceiptsChecked = [];
int counter = 0;

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
                          "Mã SP",
                          style: TextStyle(
                              fontSize: 21 * SizeConfig.ratioFont,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 60 * SizeConfig.ratioWidth,
                      child: Text(
                        "Mã Rổ",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(
                        "Ngày SX",
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
                  ],
                )),
          ),
          Column(
              children: listReceiptsChecked.map((e) => RowReceipt(e)).toList()),
          CustomizedButton(
            text: "Quét mã QR",
            bgColor: Constants.mainColor,
            fgColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/qr_scanner_screen');
            },
          ),
        ],
      ),
    );
  }
}

class RowReceipt extends StatelessWidget {
  GoodsReceiptEntryData goodsReceiptEntryRow;

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
                    goodsReceiptEntryRow.goodsReceiptEntry.containerId,
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 60 * SizeConfig.ratioWidth,
                child: Text(goodsReceiptEntryRow.goodsReceiptEntry.item.name,
                    style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                width: 100 * SizeConfig.ratioWidth,
                child: Text(
                    goodsReceiptEntryRow.goodsReceiptEntry.productionDate
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
                    goodsReceiptEntryRow.goodsReceiptEntry.actualQuantity
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
