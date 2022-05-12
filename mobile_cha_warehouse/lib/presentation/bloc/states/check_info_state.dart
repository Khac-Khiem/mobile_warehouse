import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

abstract class CheckInfoState extends Equatable {}

class CheckInfoStateLoading extends CheckInfoState {
  @override
  List<Object> get props => [];
}

class CheckInfoStateSuccess extends CheckInfoState {
  ContainerData basket;
  CheckInfoStateSuccess(this.basket);
  @override
  List<Object> get props => [basket];
}

// class CheckInfoStateFailure extends CheckInfoState {
//   ErrorPackage errorPackage;
//   CheckInfoStateFailure({this.errorPackage});
//   @override
//   List<Object> get props => [];
// }
class CheckInfoStateFailure extends CheckInfoState {
  CheckInfoStateFailure();
  @override
  List<Object> get props => [];
}