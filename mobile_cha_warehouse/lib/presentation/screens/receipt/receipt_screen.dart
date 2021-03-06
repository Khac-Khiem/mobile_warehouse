import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

// nếu quét mã sai item sẽ báo lỗi và cho quét lại
String receiptItemId = '';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  DateTime selectedDate = DateTime.now();
  // TextEditingController _dropdownController = TextEditingController();

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
                      'Bạn có chắc',
                      'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                      'Trở lại',
                      'Tiếp tục', () {
                Navigator.pushNamed(context, '///');
              }, () {}, 18, 22)
                  .show();

              //  Navigator.pop(context);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ngày bắt đầu:    ",
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 180 * SizeConfig.ratioWidth,
                              height: 45 * SizeConfig.ratioHeight,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: CustomizeDatePicker(
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                                initDateTime: selectedDate,
                                okBtnClickedFunction: (pickedTime) {
                                  selectedDate = pickedTime;
                                  print(DateFormat("dd-MM-yyyy")
                                      .format(selectedDate));
                                  BlocProvider.of<ReceiptBloc>(context).add(
                                      LoadAllReceiptEvent(
                                          DateTime.now(),
                                          DateFormat("dd-MM-yyyy")
                                              .format(selectedDate)));
                                },
                              ),
                            ),
                          ],
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
                              width: 180 * SizeConfig.ratioWidth,
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
                                    // prefixText: "    ",
                                    // prefixStyle: TextStyle(
                                    //     fontSize: 18 * SizeConfig.ratioFont),
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
                                  selectedGoodReceiptId = data.toString();
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
                        Builder(builder: (BuildContext context) {
                          if (receiptState is ReceiptStateLoadSuccess) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                receiptState.listIssueId.isNotEmpty
                                    ? ExceptionErrorState(
                                        height: 300,
                                        title: "Đã tìm thấy đơn nhập kho",
                                        message:
                                            "Vui lòng chọn đơn để tiếp tục",
                                        imageDirectory: 'lib/assets/touch.png',
                                        imageHeight: 120,
                                      )
                                    : ExceptionErrorState(
                                        height: 300,
                                        title: "Không tìm thấy đơn nhập kho",
                                        message:
                                            "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                                        imageDirectory:
                                            'lib/assets/sad_face_search.png',
                                        imageHeight: 140,
                                      ),
                              ],
                            );
                          } else if (receiptState is ReceiptStateListLoading) {
                            return CircularLoading();
                          } else if (receiptState is ReceiptStateFailure) {
                            return ExceptionErrorState(
                              height: 300,
                              title: "Không tìm thấy dữ liệu",
                              message:
                                  "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                              imageDirectory: 'lib/assets/sad_face_search.png',
                              imageHeight: 140,
                            );
                          } else {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                //Chú ý có câu selection ở đây
                                children: goodsReceiptEntryData.isNotEmpty
                                    ? [
                                        ColumnHeader(),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: goodsReceiptEntryData
                                                .map((item) => RowReceipt(
                                                      item,
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ]
                                    : [
                                        ExceptionErrorState(
                                          height: 300,
                                          title: "Không tìm thấy dữ liệu",
                                          message:
                                              "Các rổ trong đơn này đã được \nlấy ra khỏi kho, vui lòng \nkiểm tra lại đơn.",
                                          imageDirectory:
                                              'lib/assets/sad_commander.png',
                                          imageHeight: 100,
                                        ),
                                      ]);
                          }
                        }),
                        CustomizedButton(
                            text: 'Xác Nhận',
                            onPressed: () async {
                              BlocProvider.of<ReceiptBloc>(context).add(
                                  ConfirmReceiptEvent(
                                      DateTime.now(), selectedGoodReceiptId));
                              //   AlertDialogTwoBtnCustomized(
                              //         context,
                              //         'Bạn có chắc',
                              //         'Một số entry chưa được nhập?',
                              //         'Xác nhận',
                              //         'Trở lại', () {
                              //   Navigator.pushNamed(context, '/receipt_screen');
                              // }, () {}, 18, 22)
                              //     .show();
                              Navigator.pushNamed(context, '///');
                            })
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
        height: 70 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: goodsReceiptEntryRow.status
                  ? Colors.grey[700]
                  : Colors.grey[300],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),

              // primary: bgColor,
              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            //  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsReceiptEntryRow.goodsReceiptEntry.item.id,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 60 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryRow.goodsReceiptEntry.plannedQuantity
                          .toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 150 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryRow.goodsReceiptEntry.note.toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            // color: goodsReceiptEntryRow.status
            //     ? Colors.grey[700]
            //     : Colors.grey[300],
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              goodsReceiptEntryConainerData.clear();
              for (int i = 0;
                  i < goodsReceiptEntryRow.goodsReceiptEntry.containers.length;
                  i++) {
                goodsReceiptEntryConainerData.add(
                    GoodsReceiptEntryContainerData(
                        goodsReceiptEntryRow
                            .goodsReceiptEntry.containers[i].containerId,
                        goodsReceiptEntryRow.goodsReceiptEntry.item.id,
                        goodsReceiptEntryRow
                            .goodsReceiptEntry.containers[i].planedQuantity,
                        goodsReceiptEntryRow
                            .goodsReceiptEntry.containers[i].actualQuantity,
                        goodsReceiptEntryRow
                            .goodsReceiptEntry.containers[i].productionDate));
              }
              //Sự kiện click vào từng dòng
              // truyền itemid vào trang modyfi để tránh lỗi nhập sai mã sản phẩm
              receiptItemId = goodsReceiptEntryRow.goodsReceiptEntry.item.id;
              Navigator.pushNamed(context, '/list_container_receipt_screen');
            },
          ),
        ),
      ),
    );
  }
}
