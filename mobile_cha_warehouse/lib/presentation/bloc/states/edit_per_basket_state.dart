import 'package:equatable/equatable.dart';

abstract class EditPerBasketState extends Equatable {}

class EditPerBasketStateRefresh extends EditPerBasketState {
  final double mass;
  final int quantity;
  final String note;
  EditPerBasketStateRefresh({required this.mass, required this.quantity, required this.note});
  @override
  List<Object> get props => [mass, quantity, note];
}

class EditPerBasketStateRefreshFailed extends EditPerBasketState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  // final ErrorPackage errorPackage;
  // EditPerBasketStateRefreshFailed({this.errorPackage});
  // @override
  // List<Object> get props => [errorPackage];
}

class EditPerBasketStateUploadLoading extends EditPerBasketState {
  @override
  List<Object> get props => [];
}

class EditPerBasketStateUploadSuccess extends EditPerBasketState {
  @override
  List<Object> get props => [];
}

class EditPerBasketStateUploadFailed extends EditPerBasketState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  // final ErrorPackage errorPackage;
  // EditPerBasketStateUploadFailed({this.errorPackage});
  // @override
  // List<Object> get props => [errorPackage];
}
