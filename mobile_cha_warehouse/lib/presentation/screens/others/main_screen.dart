import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/main_app_name.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AlertDialogTwoBtnCustomized(context, 'Bạn có chắc?', 'Đăng xuất khỏi hệ thống','Đăng xuất', 'Trở lại',(){logout(context);} ,(){
           Navigator.pushNamed(context, '/list_receipt');
        }, 18, 22).show();
        // AlertDialogTwoBtnCustomized(
        //     context: context,
        //     title: "Bạn có chắc?",
        //     desc: "Đăng xuất khỏi hệ thống.",
        //     bgBtn1: Colors.white,
        //     fgBtn1: Constants.mainColor,
        //     textBtn1: "Đăng xuất",
        //     textBtn2: "Trở lại",
        //     onPressedBtn1: () {
        //       logout(context);
        //     }).show();
        return true;
      },
      child: Scaffold(
        endDrawer: DrawerUser(),
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          title: Text(
            'Quản lý kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             MainAppName(),
              SizedBox(
                height: 50 * SizeConfig.ratioHeight,
              ),
              CustomizedButton(
                text: "Nhập kho",
                onPressed: () {
                  Navigator.pushNamed(context, '/receipt_screen');
                  scanQRresult = "-1";
                  //scanQRresult = "bb210611150004035";
                },
              ),
              SizedBox(
                height: 4 * SizeConfig.ratioHeight,
              ),
              CustomizedButton(
                text: "Xuất kho",
                onPressed: () async {
                  Navigator.pushNamed(context, '/issue_screen');
                },
              ),
              SizedBox(
                height: 4 * SizeConfig.ratioHeight,
              ),
              CustomizedButton(
                text: "Thẻ kho",
                onPressed: () {
                  BlocProvider.of<StockCardViewBloc>(context).add(StockCardViewEventLoadAllProductID(DateTime.now()));
                Navigator.pushNamed(context, '/stockcard_screen');
                },
              ),
               SizedBox(
                height: 4 * SizeConfig.ratioHeight,
              ),
              CustomizedButton(
                text: "Kiểm kê",
                onPressed: () {
            //      Navigator.pushNamed(context, '/stock_card_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}