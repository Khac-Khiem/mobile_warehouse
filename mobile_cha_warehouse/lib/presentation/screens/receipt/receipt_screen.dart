import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

String basketReceiptId = '';
int basketReceiptIndex = 0;

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  DateTime selectedDate = DateTime.now();
  // TextEditingController _dropdownController = TextEditingController();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
          backgroundColor: Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Danh sách hàng hóa cần nhập',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<ReceiptBloc, ReceiptState>(
            listener: (context, receiptState) {},
            builder: (context, receiptState) {
              if (receiptState is ReceiptInitialState) {
                return CircularLoading();
              } else {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30 * SizeConfig.ratioHeight,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ngày bắt đầu:    ",
                                style: TextStyle(
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  width: 210 * SizeConfig.ratioWidth,
                                  height: 50 * SizeConfig.ratioHeight,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Constants.mainColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(DateFormat('dd-MM-yyyy')
                                          .format(selectedDate)),
                                      Icon(Icons.calendar_today)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.ratioHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "      Chọn đơn:    ",
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 210 * SizeConfig.ratioWidth,
                              height: 50 * SizeConfig.ratioHeight,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              //Dropdown
                              child: DropdownSearch<String>(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: "Chọn đơn",
                                    hintStyle: TextStyle(
                                        fontSize: 18 * SizeConfig.ratioFont),
                                    prefixText: "    ",
                                    prefixStyle: TextStyle(
                                        fontSize: 18 * SizeConfig.ratioFont),
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none)),
                                showAsSuffixIcons: true,
                                popupTitle: Padding(
                                  padding: EdgeInsets.all(
                                      20 * SizeConfig.ratioRadius),
                                  child: Text(
                                    "Chọn đơn nhập kho",
                                    style: TextStyle(
                                        fontSize: 20 * SizeConfig.ratioFont),
                                  ),
                                ),
                                popupBackgroundColor: Colors.grey[200],
                                popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                items: goodReceiptIdsView,
                                selectedItem: selectedGoodReceiptId,
                                onChanged: (String? data) {
                                  selectedGoodReceiptId = data!;
                                  BlocProvider.of<ReceiptBloc>(context).add(
                                      ChooseReceiptEvent(
                                          selectedGoodReceiptId));
                                 
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.ratioHeight,
                        ),
                        Divider(
                          indent: 50,
                          endIndent: 50,
                          thickness: 1,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.ratioHeight,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: SizedBox(
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
                                        "Mã SP",
                                        style: TextStyle(
                                            fontSize: 21 * SizeConfig.ratioFont,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                  SizedBox(
                                    width: 80 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "Mã Rổ",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "Ngày SX",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "SL/KL",
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
                          children: goodsReceiptEntryData
                              .map((item) => RowReceipt(
                                    item,
                                  ))
                              .toList(),
                        ),
                     
                      ],
                    ),
                  ),
                );
              }
            }));
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
          child: RaisedButton(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsReceiptEntryRow.goodsReceiptEntry.containerId,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
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
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryRow.goodsReceiptEntry.plannedQuantity
                          .toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            color: goodsReceiptEntryRow.status
                ? Colors.grey[700]
                : Colors.grey[300],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              goodsIssueEntryContainerData.clear();
              //Sự kiện click vào từng dòng
              basketReceiptId =
                  goodsReceiptEntryRow.goodsReceiptEntry.containerId;
              basketReceiptIndex = goodsReceiptEntryRow.index;
              Navigator.pushNamed(context, '/qr_scanner_screen');
            },
          ),
        ),
      ),
    );
  }
}