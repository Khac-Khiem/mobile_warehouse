import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../function.dart';
//bỏ qua
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
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              // AlertDialogTwoBtnCustomized(
              //         context,
              //         'Ban co chac',
              //         'Khi nhan tro lai, moi du lieu se khong duoc luu',
              //         'Tro lai',
              //         'Tiep tuc', () {
              //   Navigator.pushNamed(context, '/list_container_receipt_screen');
              // }, () {}, 18, 22)
              //     .show();
              Navigator.pushNamed(context, '/list_container_receipt_screen');

            },
          ),
          backgroundColor: Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Danh sách hàng hóa cần nhập',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
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
                        width: 80 * SizeConfig.ratioWidth,
                        child: Text(
                          "Mã Rổ",
                          style: TextStyle(
                              fontSize: 21 * SizeConfig.ratioFont,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 80 * SizeConfig.ratioWidth,
                      child: Text(
                        "Mã SP",
                        style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 80 * SizeConfig.ratioWidth,
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
