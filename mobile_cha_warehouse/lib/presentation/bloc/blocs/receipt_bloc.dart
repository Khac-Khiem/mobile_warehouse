import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/add_list_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_screen.dart';

List<GoodsReceiptEntryData> goodsReceiptEntryData = [];
//
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerData = [];
List<GoodsReceipt> goodsReceipt = [];
//Lấy all goodIssueId mà nhân công đó có, để đưa vô Dropdown Picker
List<String> goodReceiptIdsView = [];
//các Note sẽ được add thành List, căn cứ vô index, để gán vô GIEntry trong GIItemList
List<String> listNoteEntry = [];
//Good Issue mà dropdown chọn
String selectedGoodReceiptId = '';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptUseCase receiptUseCase;

  ReceiptBloc(this.receiptUseCase) : super(ReceiptInitialState()) {
    on<LoadAllReceiptEvent>(_onLoadingReceipt);
    on<ChooseReceiptEvent>(_onChooseReceipt);
  }
  Future<void> _onLoadingReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is LoadAllReceiptEvent) {
      emit(ReceiptInitialState());
      try {
        selectedGoodReceiptId = '';
        final allReceipt = await receiptUseCase.getAllReceipts();
        if (allReceipt.isNotEmpty) {
          for (int i = 0; i < allReceipt.length; i++) {
            goodReceiptIdsView.add(allReceipt[i].goodsReceiptId);
          }
          goodsReceipt = allReceipt;
          emit(ReceiptStateLoadSuccess(DateTime.now(), goodReceiptIdsView));
        } else {
          print('error');
        }
      } catch (e) {
        // state fail
      }
    }
  }

  Future<void> _onChooseReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is ChooseReceiptEvent) {
      emit(ReceiptStateListLoading());
      try {
        listBasketIssueChecked.clear();
        goodsReceiptEntryData.clear();
        final receipt = await receiptUseCase.getReceiptsById(event.receiptId);
        for (int i = 0; i < receipt.entries.length; i++) {
          goodsReceiptEntryData
              .add(GoodsReceiptEntryData(i, receipt.entries[i], false));
        }
        emit(ReceiptStateListLoadSuccess(DateTime.now()));
      } catch (e) {
        // state fail
        emit(ReceiptStateFailure(DateTime.now()));
      }
    }
  }

  // Future<void> _onClickToggle(
  //     ReceiptEvent event, Emitter<IssueState> emit) async {
  //   if (event is ToggleReceiptEvent) {
  //     goodsReceiptEntryData[basketReceiptIndex].status =
  //         !goodsIssueEntryData[basketReceiptIndex].status;
  //     emit(IssueStateListRefresh(basketReceiptIndex,
  //         goodsReceiptEntryData[basketReceiptIndex].status, DateTime.now()));
  //   }
  // }
}

class GoodsReceiptEntryData {
  int index;
  GoodsReceiptEntry goodsReceiptEntry;
  bool status;
  GoodsReceiptEntryData(this.index, this.goodsReceiptEntry, this.status);
}

class GoodsReceiptEntryContainerData {
  int index;
  bool status;
  GoodsReceiptEntryContainer goodsReceiptEntryContainer;
  GoodsReceiptEntryContainerData(
      this.index, this.status, this.goodsReceiptEntryContainer);
}
