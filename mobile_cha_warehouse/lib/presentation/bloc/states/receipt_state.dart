import 'package:equatable/equatable.dart';

abstract class ReceiptState extends Equatable {}

class ReceiptInitialState extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptStateFailure extends ReceiptState {
  final DateTime timestamp;
  //final ErrorPackage errorPackage;
  ReceiptStateFailure(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ReceiptStateLoadSuccess extends ReceiptState {
  final DateTime timestamp;
  final List<String> listIssueId;
  ReceiptStateLoadSuccess(this.timestamp, this.listIssueId);
  @override
  List<Object> get props => [timestamp, listIssueId];
}

class ReceiptStateListLoading extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptStateListLoadSuccess extends ReceiptState {
  final DateTime timestamp; //Do mỗi lần book là nó sẽ trả ra state khác nhau
  ReceiptStateListLoadSuccess(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ReceiptStateListRefresh extends ReceiptState {
  
  final DateTime timestamp; //Để có thể cập nhật toggle và toggle inconsistency
  ReceiptStateListRefresh(
      this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
class IssueStateConfirmLoading extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ConfirmSuccessReceiptState extends ReceiptState {
  final DateTime timestamp;
  ConfirmSuccessReceiptState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ConfirmFailureReceiptState extends ReceiptState {
  final DateTime timestamp;

  ConfirmFailureReceiptState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}