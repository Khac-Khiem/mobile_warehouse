import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

//to check info basket with QRcode
String basketReceiptId = '';
int basketReceiptIndex = 0;

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
              // BlocProvider.of<CheckListBloc>(context)
              //     .add(CheckListEventBackClicked(timestamp: DateTime.now()));
              // AlertDialogTwoBtnCustomized(
              //   context: context,
              //   title: "Bạn có chắc?",
              //   desc: "Khi nhấn nút Trở về, mọi dữ liệu sẽ không được lưu",
              //   onPressedBtn1: () {
              //     Navigator.pop(context);
              //   },
              // ).show();
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Danh sách các rổ cần nhập',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<ReceiptBloc, ReceiptState>(
            listener: (context, issueState) {},
            builder: (context, issueState) {
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
                    Column(
                      children: goodsReceiptEntryConainerData
                          .map((item) => RowContainer(item))
                          .toList(),
                    ),
                   CustomizedButton(
                      text: 'Xác nhận',
                      onPressed: () async {
                        for (var item in goodsReceiptEntryConainerData ) {
                          if (item.status == false) {
                            AlertDialogTwoBtnCustomized(
                                    context,
                                    'Bạn có chắc',
                                    'Một số rổ chưa được xuất?',
                                    'Xác nhận',
                                    'Trở lại', () {
                              Navigator.pushNamed(context, '/receipt_screen');
                            }, () {}, 18, 22)
                                .show();
                          }
                        }
                      }
                      // hiển thị thông báo
                      // gửi dữ liệu rổ lên server
                      // Navigator.pushNamed(context, '/list_issue_screen')
                      )
                  ],
                ),
              );
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
        height: 60 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: RaisedButton(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 80 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsReceiptEntryContainerData
                          .goodsReceiptEntryContainer.containerId,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryContainerData
                          .goodsReceiptEntryContainer.planedQuantity
                          .toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 120 * SizeConfig.ratioWidth,
                  child: Text(
                      DateFormat("dd-MM-yyyy").format(DateTime.parse(
                          goodsReceiptEntryContainerData
                              .goodsReceiptEntryContainer.productionDate)),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            color: goodsReceiptEntryContainerData.status
                ? Colors.grey[700]
                : Colors.grey[300],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              basketReceiptId = goodsReceiptEntryContainerData
                  .goodsReceiptEntryContainer.containerId;
              basketReceiptIndex = goodsReceiptEntryContainerData.index;

              //Sự kiện click vào từng dòng
              //trang vi tri => tiep tuc quet ma
                // BlocProvider.of<CheckInfoBloc>(context).add(
                //                     CheckInfoEventRequested(
                //                         timeStamp: DateTime.now(),
                //                         basketID: basketReceiptId));
              Navigator.pushNamed(context, '/qr_scanner_issue_screen');

                 //     Navigator.pushNamed(context, '/modify_info_screen');

            },
          ),
        ),
      ),
    );
  }
}
