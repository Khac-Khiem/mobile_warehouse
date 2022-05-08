import 'package:equatable/equatable.dart';

abstract class EditBasketEvent extends Equatable {}

class EditBasketEventRequest extends EditBasketEvent {
  final DateTime timestamp;
  EditBasketEventRequest(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
