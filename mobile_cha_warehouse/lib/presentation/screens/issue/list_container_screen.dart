import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

//to check info basket with QRcode
String basketIssueId = '';
int basketIssueIndex = 0;

class ListContainerScreen extends StatelessWidget {
  // List<GoodsIssueEntryContainerData> goodsIssueEntryContainerData;
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
                  ColumnHeader(),
                  Column(
                    children: goodsIssueEntryContainerData
                        .map((item) => RowContainer(item))
                        .toList(),
                  )
                ],
              );
            }));
  }
}

class RowContainer extends StatelessWidget {
  GoodsIssueEntryContainerData goodsIssueEntryContainerData;
  RowContainer(this.goodsIssueEntryContainerData);
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
                    width: 120 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsIssueEntryContainerData
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
                      goodsIssueEntryContainerData
                          .goodsIssueEntryContainer.productionDate
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
                      goodsIssueEntryContainerData
                          .goodsIssueEntryContainer.quantity
                          .toString(),
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 80 * SizeConfig.ratioWidth,
                  child: Text("",
                      style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            color: goodsIssueEntryContainerData.status
                ? Colors.grey[700]
                : Colors.grey[300],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () async {
              
              basketIssueId = goodsIssueEntryContainerData
                  .goodsIssueEntryContainer.containerId;
              basketIssueIndex = goodsIssueEntryContainerData.index;

              //Sự kiện click vào từng dòng
              //trang vi tri => tiep tuc quet ma
              Navigator.pushNamed(context, '/qr_scanner_issue_screen');
            },
          ),
        ),
      ),
    );
  }
}