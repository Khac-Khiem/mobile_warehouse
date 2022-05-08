import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';

//
List<GoodsIssueEntryData> goodsIssueEntryData = [];
//
List<GoodsIssue> goodsIssueData = [];
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

  IssueBloc(this.issueUseCase) : super(IssueStateInitial()) {
    on<LoadAllIssueEvent>(_onLoadingIssue);
    on<ChooseIssueEvent>(_onChooseIssue);
    on<ToggleIssueEvent>(_onClickToggle);
    //on((ChosseContainerIssueEvent event, emit) => )
  }
  Stream<void> _onLoadingIssue(
      IssueEvent event, Emitter<IssueState> emit) async* {
    if (event is LoadAllIssueEvent) {
      yield IssueStateInitial();
      try {
        listBasketIssueChecked.clear();
        selectedGoodIssueId = '';
        final allIssue = await issueUseCase.getAllIssues();
        if (allIssue is List<GoodsIssue>) {
          for (int i = 0; i < allIssue.length; i++) {
            goodIssueIdsView.add(allIssue[i].id);
          }
          goodsIssueData = allIssue;
          yield IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView);
        } else {
          print('error');
          yield IssueStateFailure(DateTime.now());
        }
      } catch (e) {
        // state fail
      }
    }
  }

  Stream<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async* {
    if (event is ChooseIssueEvent) {
      yield IssueStateListLoading();
      try {
        goodsIssueEntryData.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          goodsIssueEntryData.add(GoodsIssueEntryData(
              index: i, goodsIssueEntry: issue.entries[i], status: false));
        }

        yield IssueStateListLoadSuccess(DateTime.now());
      } catch (e) {
        yield IssueStateFailure(DateTime.now());
      }
    }
  }

  Stream<void> _onClickToggle(
      IssueEvent event, Emitter<IssueState> emit) async* {
    if (event is ToggleIssueEvent) {
      goodsIssueEntryContainerData[basketIssueIndex].status = !goodsIssueEntryContainerData[basketIssueIndex].status;
      yield IssueStateListRefresh(
        basketIssueIndex, goodsIssueEntryContainerData[basketIssueIndex].status, DateTime.now());
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
  bool status;
  GoodsIssueEntryContainerData(
      this.index, this.goodsIssueEntryContainer, this.status);
}
