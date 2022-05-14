import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';

abstract class IssueEvent extends Equatable {}
// sự kiện load tất cả đơn xuất kho về

class LoadIssueEvent extends IssueEvent {
  final String startDate;
  final DateTime timestamp;
  LoadIssueEvent(this.timestamp, this.startDate);
  @override
  List<Object> get props => [timestamp];
}

//sự kiện khi chọn loại đơn xuất kho
class ChooseIssueEvent extends IssueEvent {
  final String goodIssueId;
  final DateTime timestamp;
  ChooseIssueEvent(this.timestamp, this.goodIssueId);
  @override
  List<Object> get props => [timestamp, goodIssueId];
}

class ChosseContainerIssueEvent extends IssueEvent {
  GoodsIssueEntry goodsIssueEntry;
  DateTime timeStamp;
  ChosseContainerIssueEvent(this.goodsIssueEntry, this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [goodsIssueEntry, timeStamp];
}

// sự kiện đánh dấu rổ đã lấy
// class ToggleIssueEvent extends IssueEvent {
//   final int index;
//   final bool entryStatus;
//   ToggleIssueEvent(this.entryStatus, this.index);
//   @override
//   List<Object> get props => [index, entryStatus];
// }
class ToggleIssueEvent extends IssueEvent {
  final int index;
  ToggleIssueEvent(this.index);
  @override
  List<Object> get props => [index];
}

// sự kiện báo lỗi rổ sai thông tin
class ReportInconsistencyIssueEvent extends IssueEvent {
  final int index;
  ReportInconsistencyIssueEvent(this.index);
  @override
  List<Object> get props => [index];
}

//sự kiện nhấn nút xác nhận để gửi lên server
class ConfirmClickedIssueEvent extends IssueEvent {
  final DateTime timestamp;
  ConfirmClickedIssueEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// event load vị trí rổ khi truy xuất container
class FetchLocationIssueEvent extends IssueEvent {
  String id;
  DateTime timeStamp;
  FetchLocationIssueEvent(this.id, this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [id, timeStamp];
}

