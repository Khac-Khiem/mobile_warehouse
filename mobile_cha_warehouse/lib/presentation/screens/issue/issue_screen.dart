import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/datasource/service/login_service.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/global.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/main_app_name.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({Key? key}) : super(key: key);

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
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
            Navigator.pushNamed(context, '///');
          }, //sự kiện mũi tên back
        ),
        backgroundColor: Color(0xff001D37), //màu xanh dương đậm
        //nút bên phải
        title: Text(
          'Xuất kho',
          style: TextStyle(fontSize: 22), //chuẩn
        ),
      ),
      endDrawer: DrawerUser(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainAppName(
              title: "XUẤT KHO",
            ),
            SizedBox(
              height: 50 * SizeConfig.ratioHeight,
            ),
            CustomizedButton(
              text: "Danh sách rổ",
              onPressed: () {
                Navigator.pushNamed(context, '/list_issue_screen');
                AlertDialogOneBtnCustomized(
                        context,
                        'Thông báo',
                        "Bạn đang đăng nhập với ID là " + employeeIdOverall,
                        'Tiếp tục', () {
                  BlocProvider.of<IssueBloc>(context).add(LoadIssueEvent(
                      DateTime.now(),
                      DateFormat("dd-MM-yyyy").format(
                          DateTime.now().subtract(Duration(days: 30)))));
                  //  Navigator.pushNamed(context, '/issue_screen');
                }, 18, 22, () {}, false)
                    .show();
              },
            ),
            SizedBox(
              height: 4 * SizeConfig.ratioHeight,
            ),
            CustomizedButton(
              text: "Điều chỉnh rổ",
              onPressed: () async {
                Navigator.pushNamed(context, '/edit_basket_screen');
                // BlocProvider.of<EditBasketBloc>(context)
                //     .add(EditBasketEventRequest(timestamp: DateTime.now()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
