import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
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
int xAxis = 0;
int yAxis = 0;
int zAxis = 0;

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueUseCase issueUseCase;
  ContainerUseCase containerUseCase;
  SlotUseCase slotUseCase;
  IssueBloc(this.issueUseCase, this.containerUseCase, this.slotUseCase)
      : super(IssueStateInitial()) {
    on<LoadIssueEvent>(_onLoadingIssue);
    on<ChooseIssueEvent>(_onChooseIssue);
    on<ToggleContainerIssueEvent>(_onClickContainerToggle);
    on<FetchLocationIssueEvent>(_onLoadLocation);
    on<ConFirmExportingContainer>(_onConfirm);
    on<TestIssueEvent>(_onRefresh);
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

  Future<void> _onLoadLocation(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is FetchLocationIssueEvent) {
      emit(LoadingLocationState());
      try {
        print('a');
        //
        final cell = await slotUseCase.getCellById(event.id);
        xAxis = cell.slices!.length;
        for (int i = 0; i < cell.slices!.length; i++) {
          for (int j = 1; j < cell.slices![i].slots!.length; j++) {
            if (cell.slices![i].slots![j].levelId! >
                cell.slices![i].slots![j - 1].levelId!) {
              yAxis = cell.slices![i].slots![j].levelId!;
            }
            if (cell.slices![i].slots![j].id! >
                cell.slices![i].slots![j - 1].id!) {
              zAxis = cell.slices![i].slots![j].id!;
            }
          }
        }

        locationContainer.clear();
        final container = await containerUseCase.getContainerById(event.id);
        locationContainer.add(container.storageSlot);
        // print(
        //     locationContainer[0].shelfId + locationContainer[0].id.toString());
        emit(LoadLocationContainerSuccess(DateTime.now()));
      } catch (e) {
        print('b');
        emit(LoadLocationFailState(DateTime.now()));
      }
    }
  }

  Future<void> _onConfirm(IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ConFirmExportingContainer) {
      emit(IssueStateConfirmLoading());
      try {
        final confirm = issueUseCase.patchConfirmIssueEntry(
            event.issueId, event.containerId);
        emit(ConfirmSuccessIssueState(DateTime.now()));
      } catch (e) {
        print('fail');
        emit(ConfirmFailureIssueState(DateTime.now()));
      }
    }
  }

  Future<void> _onRefresh(IssueEvent event, Emitter<IssueState> emit) async {
    if (event is TestIssueEvent) {
      print('aaaa');
      emit(IssueStateListRefresh(
          basketIssueIndex,
          goodsIssueEntryContainerData[basketIssueIndex]
              .goodsIssueEntryContainer
              .isTaken,
          DateTime.now()));
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
