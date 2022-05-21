import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';

List<GoodsReceiptEntryData> goodsReceiptEntryData = [];
//
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerData = [];
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
    on<AddcontainerScanned>(_onAddContainerUi);
    on<AddContainerEvent>(_onAddContainer);
    on<ConfirmReceiptEvent>(_onConfirm);
  }
//  if (allIssue.isNotEmpty) {
//           for (int i = 0; i < allIssue.length; i++) {
//             if (allIssue[i].isConfirmed == false) {
//               goodIssueIdsView.add(allIssue[i].id);
//             }
//           }
//           emit(IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView));
//         }


  Future<void> _onLoadingReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is LoadAllReceiptEvent) {
      emit(ReceiptInitialState());
      try {
        goodReceiptIdsView = [];
        goodsReceiptEntryData.clear();
        goodsIssueEntryContainerData = [];
        selectedGoodReceiptId = '';
        final allReceipt = await receiptUseCase.getAllReceipts(event.startDate);
        if (allReceipt.isNotEmpty) {
          for (int i = 0; i < allReceipt.length; i++) {
            if(allReceipt[i].confirmed == false){
              goodReceiptIdsView.add(allReceipt[i].goodsReceiptId);
            }
          }
          //  goodsReceipt = allReceipt;
          emit(ReceiptStateLoadSuccess(DateTime.now(), goodReceiptIdsView));
        } else {
          emit(ReceiptStateLoadSuccess(DateTime.now(), []));
          print('error');
        }
      } catch (e) {
        emit(ReceiptStateFailure(DateTime.now()));
        // state fail
      }
    }
  }

  Future<void> _onChooseReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is ChooseReceiptEvent) {
      emit(ReceiptStateListLoading());
      try {
        goodsReceiptEntryData.clear();
        final receipt = await receiptUseCase.getReceiptsById(event.receiptId);
        // print(receipt.entries[1]);
        for (int i = 0; i < receipt.entries.length; i++) {
          goodsReceiptEntryData
              .add(GoodsReceiptEntryData(i, receipt.entries[i], false));
          print(goodsReceiptEntryData);
          print(i);
        }
        //test lỗi

        emit(ReceiptStateListLoadSuccess(DateTime.now()));
      } catch (e) {
        // state fail
        emit(ReceiptStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onAddContainer(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is AddContainerEvent) {
      try {
        final containerconfirm =
            receiptUseCase.addContainerReceipt(event.receiptId, event.data);
     //   emit(ConfirmSuccessReceiptState(DateTime.now()));
      } catch (e) {
        print('fail');
     //   emit(ConfirmFailureReceiptState(DateTime.now()));
      }
    }
  }

  Future<void> _onAddContainerUi(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is AddcontainerScanned) {
      emit(ReceiptStateListLoading());
      try {
        goodsReceiptEntryConainerData.add(event.goodsReceiptEntryContainerData);
        emit(ReceiptStateListRefresh(DateTime.now()));
      } catch (e) {
        print('fail');
        emit(ConfirmFailureReceiptState(DateTime.now()));
      }
    }
  }
  Future<void> _onConfirm(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is ConfirmReceiptEvent) {
      try {
        final confirm =
            receiptUseCase.confirmContainer(event.receiptId);
        emit(ConfirmSuccessReceiptState(DateTime.now()));
      } catch (e) {
        print('fail');
        emit(ConfirmFailureReceiptState(DateTime.now()));
      }
    }
  }
}

class GoodsReceiptEntryData {
  int index;
  GoodsReceiptEntry goodsReceiptEntry;
  bool status;
  GoodsReceiptEntryData(this.index, this.goodsReceiptEntry, this.status);
}

// dùng để add container lên server
class GoodsReceiptEntryContainerData {
  String containerId;
  String itemId;
  int actualQuantity;
  int plannedQuantity;
  String productionDate;
  GoodsReceiptEntryContainerData(this.containerId, this.itemId,
      this.plannedQuantity, this.actualQuantity, this.productionDate);
  Map<String, dynamic> toJson() => {
        "containerId": containerId,
        "itemId": itemId,
        "plannedQuantity": plannedQuantity,
        "actualQuantity": actualQuantity,
        "productionDate": productionDate
      };
}
