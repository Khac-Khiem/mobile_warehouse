import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../../injector.dart';

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
            'Danh sách hàng hóa cần xuất',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {},
            builder: (context, issueState) {
              if (issueState is IssueStateInitial) {
                return CircularLoading();
              } else if (issueState is IssueStateFailure) {
                return ExceptionErrorState(
                  height: 300,
                  title: "Đã có lỗi xảy ra",
                  message:
                      "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                  imageDirectory: 'lib/assets/sad_face_search.png',
                  imageHeight: 140,
                );
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
                                  },
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
                              width: 180 * SizeConfig.ratioWidth,
                              height: 45 * SizeConfig.ratioHeight,
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
                                  padding: EdgeInsets.all(
                                      20 * SizeConfig.ratioRadius),
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
                                  selectedGoodIssueId = data!;
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
                                issueState.listIssueId.length != 0
                                    ? ExceptionErrorState(
                                        height: 300,
                                        title: "Đã tìm thấy đơn xuất kho",
                                        message:
                                            "Vui lòng chọn đơn để tiếp tục",
                                        imageDirectory: 'lib/assets/touch.png',
                                        imageHeight: 120,
                                      )
                                    : ExceptionErrorState(
                                        height: 300,
                                        title: "Không tìm thấy dữ liệu",
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
                          } else {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                //Chú ý có câu selection ở đây
                                children: goodsIssueEntryData.length != 0
                                    ? [
                                        ColumnHeader(),
                                        Column(
                                          children: goodsIssueEntryData
                                              .map((item) => RowIssue(
                                                    item,
                                                  ))
                                              .toList(),
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
                        goodsIssueEntryData.length != 0
                            ? CustomizedButton(
                                text: 'Xác nhận',
                                onPressed: () => Navigator.pop(context),
                              )
                            : CustomizedButton(
                                text: "Trở lại",
                                onPressed: () => Navigator.pop(context),
                              ),
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
                      goodsIssueEntryRow.goodsIssueEntry.item.id,
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
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
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(goodsIssueEntryRow.goodsIssueEntry.note,
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
