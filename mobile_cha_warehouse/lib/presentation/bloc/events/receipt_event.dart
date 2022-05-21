import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';

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
  GoodsReceiptEntryContainerData data;
  String receiptId;
  AddContainerEvent(this.timeStamp, this.data, this.receiptId);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp, receiptId];
}

class ConfirmReceiptEvent extends ReceiptEvent {
  DateTime timeStamp;
  String receiptId;
  ConfirmReceiptEvent(this.timeStamp, this.receiptId);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp, receiptId];
}

class AddcontainerScanned extends ReceiptEvent {
  GoodsReceiptEntryContainerData goodsReceiptEntryContainerData;
  AddcontainerScanned(this.goodsReceiptEntryContainerData);
   @override
  // TODO: implement props
  List<Object?> get props => [goodsReceiptEntryContainerData];
}
