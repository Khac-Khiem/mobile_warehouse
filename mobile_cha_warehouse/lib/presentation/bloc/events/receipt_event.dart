import 'package:equatable/equatable.dart';

class ReceiptEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  LoadAllReceiptEvent(this.timestamp);
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
