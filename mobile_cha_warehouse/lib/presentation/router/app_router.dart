
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/injector.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/qr_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/home_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/login_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/main_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/add_list_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/stockcard/stockcard_screen.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '//':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '///':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                    BlocProvider<StockCardViewBloc>(create: (context) => injector()),
                ], child: const MainScreen()));
      case '/issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  // BlocProvider<IssueBloc>(create: (context) => injector()),
                ], child: const IssueScreen()));
      case '/list_issue_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<IssueBloc>(
                create: (context) => injector(),
                child: const ListIssueScreen()));
      case '/list_container_screen':
        return MaterialPageRoute(builder: (_) => ListContainerScreen());
      case '/qr_issue_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<IssueBloc>(
                create: (context) => injector(),
                child: QRScannerIssueScreen()));
      case '/receipt_screen':
       return MaterialPageRoute(
            builder: (context) => BlocProvider<IssueBloc>(
                create: (context) => injector(),
                child: const ReceiptScreen()));
        
      // case '/add_list_receipt':
      //   return MaterialPageRoute(builder: (_) => AddListReceiptScreen());
      case '/qr_scanner_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<CheckInfoBloc>(
                create: (context) => injector(),
                child: QRScannerScreen()));
      case '/modify_info_screen':
        return MaterialPageRoute(builder: (_) => ModifyInfoScreen());
      case '/stockcard_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<StockCardViewBloc>(
                create: (context) => injector(),
                child: StockCardScreen()));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
