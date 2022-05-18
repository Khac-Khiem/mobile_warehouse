import 'package:equatable/equatable.dart';

class ReceiptEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllReceiptEvent extends ReceiptEvent {
  String startDate;
  DateTime timestamp;
  LoadAllReceiptEvent(this.timestamp, this.startDate);
  @override
  List<Object> get props => [timestamp];
}

class ChooseReceiptEvent extends ReceiptEvent {
  String receiptId;
  ChooseReceiptEvent(this.receiptId);
  @override
  List<Object> get props => [receiptId];
}

class ToggleReceiptEvent extends ReceiptEvent {
  int index;
  ToggleReceiptEvent(this.index);
  @override
  List<Object> get props => [index];
}
class AddContainerEvent extends ReceiptEvent {
  DateTime timeStamp;
  int quantity;
  String containerId;
  AddContainerEvent(this.timeStamp, this.containerId, this.quantity);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp, containerId];
}
