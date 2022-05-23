import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

int issueIndex = 0;
List<String> listBasketIdConfirm = [];

class ListIssueScreen extends StatefulWidget {
  const ListIssueScreen({Key? key}) : super(key: key);

  @override
  State<ListIssueScreen> createState() => _ListIssueScreenState();
}

class _ListIssueScreenState extends State<ListIssueScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _dropdownController = TextEditingController();

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
              // khong cho phep thoat khoi giao dien khi ddang lamf viec, chi thoat khi da xac nhan
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
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Danh sách hàng hóa cần xuất',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {
          if (issueState is IssueStateListLoadSuccess) {
            goodsIssueEntryData = issueState.goodsIssueEntryData;
            print(goodsIssueEntryData);
          }
        }, builder: (context, issueState) {
          if (issueState is IssueStateInitial) {
            return CircularLoading();
          }
          // else if (issueState is IssueStateFailure) {
          //   return ExceptionErrorState(
          //     height: 300,
          //     title: "Đã có lỗi xảy ra",
          //     message: "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
          //     imageDirectory: 'lib/assets/sad_face_search.png',
          //     imageHeight: 140,
          //   );
          // }
          else {
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: CustomizeDatePicker(
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            initDateTime: selectedDate,
                            okBtnClickedFunction: (pickedTime) {
                              selectedDate = pickedTime;
                              // print(DateFormat("dd-MM-yyyy")
                              //     .format(selectedDate));
                              BlocProvider.of<IssueBloc>(context).add(
                                  LoadIssueEvent(
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
                                  const Radius.circular(10))),
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
                              padding:
                                  EdgeInsets.all(20 * SizeConfig.ratioRadius),
                              child: Text(
                                "Chọn đơn xuất kho",
                                style: TextStyle(
                                    fontSize: 20 * SizeConfig.ratioFont),
                              ),
                            ),
                            popupBackgroundColor: Colors.grey[200],
                            popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            items: goodIssueIdsView,
                            selectedItem: selectedGoodIssueId,
                            onChanged: (String? data) {
                              selectedGoodIssueId = data.toString();
                              BlocProvider.of<IssueBloc>(context).add(
                                  ChooseIssueEvent(
                                      DateTime.now(), selectedGoodIssueId));
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
                      if (issueState is IssueStateLoadSuccess) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            issueState.listIssueId.isNotEmpty
                                ? ExceptionErrorState(
                                    height: 300,
                                    title: "Đã tìm thấy đơn xuất kho",
                                    message: "Vui lòng chọn đơn để tiếp tục",
                                    imageDirectory: 'lib/assets/touch.png',
                                    imageHeight: 120,
                                  )
                                : ExceptionErrorState(
                                    height: 300,
                                    title: "Không tìm thấy đơn xuất kho",
                                    message:
                                        "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                                    imageDirectory:
                                        'lib/assets/sad_face_search.png',
                                    imageHeight: 140,
                                  ),
                          ],
                        );
                      } else if (issueState is IssueStateListLoading) {
                        return CircularLoading();
                      } else if (issueState is IssueStateFailure) {
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
                            children: goodsIssueEntryData.isNotEmpty
                                ? [
                                    ColumnHeaderIssue(),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: goodsIssueEntryData
                                            .map((item) => RowIssue(
                                                  item,
                                                ))
                                            .toList(),
                                      ),
                                    )
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
                    goodsIssueEntryData.isNotEmpty
                        ? CustomizedButton(
                            text: 'Xác nhận',
                            onPressed: () {
                              // confirm exporting container
                              // BlocProvider.of<IssueBloc>(context).add(
                              //     ConfirmClickedIssueEvent(DateTime.now()));
                              Navigator.pushNamed(context, '///');
                            })
                        : CustomizedButton(
                            text: "Trở lại",
                            onPressed: () =>
                                Navigator.pushNamed(context, '///')),
                    SizedBox(
                      height: 30 * SizeConfig.ratioHeight,
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

class RowIssue extends StatelessWidget {
  GoodsIssueEntryData goodsIssueEntryRow;

  RowIssue(this.goodsIssueEntryRow);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 70 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: RaisedButton(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsIssueEntryRow.goodsIssueEntry.item.id,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 60 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsIssueEntryRow.goodsIssueEntry.totalQuantity
                          .toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 150 * SizeConfig.ratioWidth,
                  child:
                      Text(goodsIssueEntryRow.goodsIssueEntry.note.toString(),
                          style: TextStyle(
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                ),
              ],
            ),
            color:
                goodsIssueEntryRow.status ? Colors.grey[700] : Colors.grey[300],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              //clear mỗi khi vào 1 entry issue mới
              listBasketIdConfirm.clear();
              // dùng để try xuất entry
              issueIndex = goodsIssueEntryRow.index;
              // xóa dữ liệu container trước đó
              goodsIssueEntryContainerData.clear();
              //Sự kiện click vào từng dòng
              for (int i = 0;
                  i < goodsIssueEntryRow.goodsIssueEntry.container.length;
                  i++) {
                goodsIssueEntryContainerData.add(GoodsIssueEntryContainerData(
                  i,
                  goodsIssueEntryRow.goodsIssueEntry.container[i],
                ));
              }
              Navigator.pushNamed(context, '/list_container_screen');
            },
          ),
        ),
      ),
    );
  }
}

class ColumnHeaderIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  width: 150 * SizeConfig.ratioWidth,
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
                  "KL",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 150 * SizeConfig.ratioWidth,
                child: Text(
                  "Note",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
