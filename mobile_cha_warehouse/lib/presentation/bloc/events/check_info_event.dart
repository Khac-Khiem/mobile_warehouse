import 'package:equatable/equatable.dart';

abstract class CheckInfoEvent extends Equatable {}

class CheckInfoEventRequested extends CheckInfoEvent {
  String basketID;
  DateTime timeStamp; //Tạo timeStamp để lần nào click cũng khác nhau
  CheckInfoEventRequested({required this.timeStamp, required this.basketID});
  @override
  List<Object> get props =>
      [timeStamp, basketID]; //Với mỗi basket ID thì sẽ refresh lại
}

class AddContainerEvent extends CheckInfoEvent {
  DateTime timeStamp;
  int quantity;
  String containerId;
  AddContainerEvent(this.timeStamp, this.containerId, this.quantity);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp, containerId];
}
