import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_screen.dart';

//
List<GoodsIssueEntryData> goodsIssueEntryData = [];
//
List<Location> locationContainer = [];
//
List<GoodsIssueEntryContainerData> goodsIssueEntryContainerData = [];
//Lấy list các Basket đã được checked, để sau này Confirm isTaken
List<String> listBasketIssueChecked = [];
//Lấy all goodIssueId mà nhân công đó có, để đưa vô Dropdown Picker
List<String> goodIssueIdsView = [];
//các Note sẽ được add thành List, căn cứ vô index, để gán vô GIEntry trong GIItemList
List<String> listNoteIssueEntry = [];
//Good Issue mà dropdown chọn
String selectedGoodIssueId = '';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueUseCase issueUseCase;
  ContainerUseCase containerUseCase;
  IssueBloc(this.issueUseCase, this.containerUseCase)
      : super(IssueStateInitial()) {
    on<LoadIssueEvent>(_onLoadingIssue);
    on<ChooseIssueEvent>(_onChooseIssue);
    on<ToggleContainerIssueEvent>(_onClickContainerToggle);
   // on<ToggleIssueEvent>(_onClickToggle);
    on<FetchLocationIssueEvent>(_onLoadLocation);
    on<AddContainerEvent>(_onAddContainer);

    //on((ChosseContainerIssueEvent event, emit) => )
  }
  Future<void> _onLoadingIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is LoadIssueEvent) {
      emit(IssueStateInitial());
      try {
        listBasketIssueChecked.clear();
        selectedGoodIssueId = '';
        goodsIssueEntryContainerData = [];
        goodIssueIdsView = [];
        goodsIssueEntryData = [];
        final allIssue = await issueUseCase.getAllIssues(event.startDate);
        if (allIssue.isNotEmpty) {
          for (int i = 0; i < allIssue.length; i++) {
            if (allIssue[i].isConfirmed == false) {
              goodIssueIdsView.add(allIssue[i].id);
            }
          }
          emit(IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView));
        } else {
          print('error');
          emit(IssueStateLoadSuccess(DateTime.now(), []));
        }
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
        // state fail
      }
    }
  }

// pros goodsIssueEntryData đưa vào State IssueStateListloadSuccess
  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryData.clear();
        listBasketIdConfirm.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          goodsIssueEntryData.add(GoodsIssueEntryData(
              index: i,
              goodsIssueEntry: issue.entries[i],
              status: false,
              actualQuantity: 0));
        }

        emit(IssueStateListLoadSuccess(DateTime.now(), goodsIssueEntryData));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onClickContainerToggle(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ToggleContainerIssueEvent) {
      goodsIssueEntryContainerData[basketIssueIndex]
              .goodsIssueEntryContainer
              .isTaken =
          !goodsIssueEntryContainerData[basketIssueIndex]
              .goodsIssueEntryContainer
              .isTaken;
      emit(IssueStateListRefresh(
          basketIssueIndex,
          goodsIssueEntryContainerData[basketIssueIndex]
              .goodsIssueEntryContainer
              .isTaken,
          DateTime.now()));
    }
  }

  // Future<void> _onClickToggle(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is ToggleIssueEvent) {
  //     goodsIssueEntryData[issueIndex].status =
  //         !goodsIssueEntryData[issueIndex].status;
  //     emit(IssueStateListRefresh(
  //         issueIndex, goodsIssueEntryData[issueIndex].status, DateTime.now()));
  //   }
  // }

  Future<void> _onLoadLocation(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is FetchLocationIssueEvent) {
      emit(LoadingLocationState());
      try {
        //
        locationContainer.clear();
        final container = await containerUseCase.getContainerById(event.id);
        locationContainer.add(container.storageSlot);
        print(
            locationContainer[0].shelfId + locationContainer[0].id.toString());
        emit(LoadLocationContainerSuccess(DateTime.now()));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onAddContainer(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is AddContainerEvent) {
      emit(IssueStateConfirmLoading());
      try {
        final statusRequest = await issueUseCase.confirmContainer(
            event.containerId, event.quantity, event.issueId);
        if (statusRequest == 200) {
        } else {
          //
        }
      } catch (e) {
        print(e);
        //  emit(IssueStateFailure(DateTime.now()));
      }
    }
  }
}

class GoodsIssueEntryData {
  int index;
  GoodsIssueEntry goodsIssueEntry;
  bool status;
  int actualQuantity;
  GoodsIssueEntryData(
      {required this.index,
      required this.goodsIssueEntry,
      required this.status,
      required this.actualQuantity});
}

class GoodsIssueEntryContainerData {
  int index;
  GoodsIssueEntryContainer goodsIssueEntryContainer;

  GoodsIssueEntryContainerData(this.index, this.goodsIssueEntryContainer);
}
