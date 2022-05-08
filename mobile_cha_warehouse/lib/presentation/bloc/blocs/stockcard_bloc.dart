import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/stockcard_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';

List<Item> allProductList = [];
List<String> allProductIdList = [];

class StockCardViewBloc extends Bloc<StockCardViewEvent, StockCardViewState> {
  StockCardsUseCase stockCardsUseCase;
  ItemUseCase itemUseCase;
  StockCardViewBloc(this.stockCardsUseCase, this.itemUseCase)
      : super(StockCardViewStateLoadingProduct());
  @override
  Stream<StockCardViewState> mapEventToState(StockCardViewEvent event) async* {
    if (event is StockCardViewEventLoadAllProductID) {
      yield StockCardViewStateLoadingProduct();
      try {
        allProductIdList.clear();
        final productOrErr = await itemUseCase.getAllItem();
        allProductList = productOrErr;
        if (productOrErr.isNotEmpty) {
          // allProductIdList =
          //     allProductList.select((product, index) => product.id).toList();
          for (int i = 0; i < allProductIdList.length; i++) {
           
                allProductIdList.add(allProductList[i].id);
              
            
          }
          yield StockCardViewStateLoadProductSuccess();
        } 
        else {
      //     yield StockCardViewStateLoadFailed(errorPackage: productOrErr);
         }
      // } on SocketException {
      //   yield StockCardViewStateLoadFailed(
      //       errorPackage: ErrorPackage(
      //           errorCode: "SocketException",
      //           message: "Lost connection to the server",
      //           detail: ""));
     } catch (e) {
      //   yield StockCardViewStateLoadFailed(
      //       errorPackage: new ErrorPackage(
      //           errorCode: "Exception", message: "", detail: ""));
       }
    }
    else if (event is StockCardViewEventSelectProductId)  {
      try {
        final productSelected = allProductList
            .where((element) => element.id == event.productId)
            .toList()
            .first;
      yield StockCardViewStateSelectedProductID(productSelected.id);
      }
       catch (e) {
        // yield StockCardViewStateLoadFailed(
        //     errorPackage: new ErrorPackage(
        //         errorCode: "Exception", message: "", detail: ""));
      }

    } 
    //else if (event is StockCardViewEventLoad) {
    //   if (event.endDate.compareTo(event.startDate) != 1) {
    //     yield StockCardViewStateLoadFailed(
    //         errorPackage: ErrorPackage(errorCode: "WrongDate"));
    //   } else {
    //     yield StockCardViewStateLoading();
    //     try {
    //       final stockCardOrErr = await stockCardsUseCase.(
    //           event.productId,
    //           DateFormat('yyyy-MM-dd').format(event.startDate),
    //           DateFormat('yyyy-MM-dd').format(event.endDate));
    //       if (stockCardOrErr is StockCard) {
    //         yield StockCardViewStateLoadSuccess(
    //             timestamp: event.timestamp, stockCard: stockCardOrErr);
    //       } else {
    //         yield StockCardViewStateLoadFailed(
    //             errorPackage: stockCardOrErr); //đưa ra Something went wrong
    //       }
    //     } on SocketException {
    //       yield StockCardViewStateLoadFailed(
    //           errorPackage: ErrorPackage(
    //               errorCode: "SocketException",
    //               message: "Lost connection to the server",
    //               detail: ""));
    //     } catch (e) {
    //       yield StockCardViewStateLoadFailed(
    //           errorPackage: new ErrorPackage(
    //               errorCode: "Exception", message: "", detail: ""));
    //     }
    //   }
    // }
  }
}
