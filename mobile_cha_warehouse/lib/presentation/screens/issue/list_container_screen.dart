import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

//to check info basket with QRcode
String basketIssueId = '';
int basketIssueIndex = 0;

class ListContainerScreen extends StatelessWidget {
  ListContainerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () async {
              AlertDialogTwoBtnCustomized(
                      context,
                      'Bạn có chắc',
                      'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                      'Trở lại',
                      'Tiếp tục', () {
                Navigator.pushNamed(context, '/list_issue_screen');
              }, () {}, 18, 22)
                  .show();
            },
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          title: const Text(
            'Danh sách các rổ cần xuất',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {},
            builder: (context, issueState) {
              return Column(
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
                              width: 140 * SizeConfig.ratioWidth,
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
                              "SL",
                              style: TextStyle(
                                  fontSize: 21 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 140 * SizeConfig.ratioWidth,
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
                  Container(
                    height: 400,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: goodsIssueEntryContainerData
                            .map((item) => RowContainer(item))
                            .toList(),
                      ),
                    ),
                  ),
                  CustomizedButton(
                      text: 'Xác nhận',
                      onPressed: () async {
                        for (var item in goodsIssueEntryContainerData) {
                          if (item.goodsIssueEntryContainer.isTaken == false) {
                            AlertDialogTwoBtnCustomized(
                                    context,
                                    'Bạn có chắc',
                                    'Một số rổ chưa được xuất?',
                                    'Xác nhận',
                                    'Trở lại', () async {
                              BlocProvider.of<IssueBloc>(context).add(
                                  ConFirmExportingContainer(selectedGoodIssueId,
                                      listBasketIdConfirm));
                              Navigator.pushNamed(
                                  context, '/list_issue_screen');
                            }, () {}, 18, 22)
                                .show();
                          } else {
                            BlocProvider.of<IssueBloc>(context).add(
                                ConFirmExportingContainer(
                                    selectedGoodIssueId, listBasketIdConfirm));
                            Navigator.pushNamed(context, '/list_issue_screen');
                          }
                        }
                      })
                ],
              );
            }));
  }
}

class RowContainer extends StatelessWidget {
  GoodsIssueEntryContainerData goodsIssueEntryContainer;
  RowContainer(this.goodsIssueEntryContainer);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 80 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                primary:goodsIssueEntryContainer.goodsIssueEntryContainer.isTaken
                 ? Colors.grey[700]
                 : Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 150 * SizeConfig.ratioWidth,
                      child: Text(
                        goodsIssueEntryContainer
                            .goodsIssueEntryContainer.containerId,
                        style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    width: 60 * SizeConfig.ratioWidth,
                    child: Text(
                        goodsIssueEntryContainer
                            .goodsIssueEntryContainer.quantity
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
                        DateFormat("dd-MM-yyyy").format(DateTime.parse(
                            goodsIssueEntryContainer
                                .goodsIssueEntryContainer.productionDate)),
                        style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              // color: goodsIssueEntryContainer.goodsIssueEntryContainer.isTaken
              //     ? Colors.grey[700]
              //     : Colors.grey[300],
              // shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(8))),
              onPressed:
                  //nếu rổ đã được taken thì không cho phép ấn vào
                  goodsIssueEntryContainer.goodsIssueEntryContainer.isTaken
                      ? () {}
                      : () {
                          basketIssueId = goodsIssueEntryContainer
                              .goodsIssueEntryContainer.containerId;
                          basketIssueIndex = goodsIssueEntryContainer.index;
                          print(basketIssueId);
                          //Sự kiện click vào từng dòng
                          //trang vi tri => tiep tuc quet ma
                          BlocProvider.of<IssueBloc>(context).add(
                              FetchLocationIssueEvent(
                                  basketIssueId, DateTime.now()));
                          //  print(locationContainer);
                          Navigator.pushNamed(context, '/location_screen');
                        }),
        ),
      ),
    );
  }
}
