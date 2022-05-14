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
    on<ToggleIssueEvent>(_onClickToggle);
    on<FetchLocationIssueEvent>(_onLoadLocation);

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
        goodsIssueEntryData = [];
        final allIssue = await issueUseCase.getAllIssues(event.startDate);
        if (allIssue is List<GoodsIssue>) {
          for (int i = 0; i < allIssue.length; i++) {
            if(allIssue[i].isConfirmed ==false){
                          goodIssueIdsView.add(allIssue[i].id);

            }
          }
          emit(IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView));
        } else {
          print('error');
          emit(IssueStateFailure(DateTime.now()));
        }
      } catch (e) {
        // state fail
      }
    }
  }

  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryData.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          goodsIssueEntryData.add(GoodsIssueEntryData(
              index: i, goodsIssueEntry: issue.entries[i], status: false));
        }

        emit(IssueStateListLoadSuccess(DateTime.now()));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onClickToggle(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ToggleIssueEvent) {
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
        //
        locationContainer.clear();
        final container = await containerUseCase.getContainerById(event.id);
        locationContainer.add(container.storageSlot);
           print(locationContainer[0].shelfId + locationContainer[0].id.toString());
        emit(LoadLocationContainerSuccess(DateTime.now()));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }
}

class GoodsIssueEntryData {
  int index;
  GoodsIssueEntry goodsIssueEntry;
  bool status;
  GoodsIssueEntryData(
      {required this.index,
      required this.goodsIssueEntry,
      required this.status});
}

class GoodsIssueEntryContainerData {
  int index;
  GoodsIssueEntryContainer goodsIssueEntryContainer;

  GoodsIssueEntryContainerData(this.index, this.goodsIssueEntryContainer);
}
