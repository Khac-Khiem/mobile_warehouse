import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

abstract class EditBasketState extends Equatable {}

class EditBasketStateRefreshLoading extends EditBasketState {
  @override
  List<Object> get props => [];
}

class EditBasketStateRefreshSuccess extends EditBasketState {
  final List<ContainerInconsistency> inconsistencyContainers;
  EditBasketStateRefreshSuccess(this.inconsistencyContainers);
  @override
  List<Object> get props => [inconsistencyContainers];
}

class EditBasketStateRefreshFailed extends EditBasketState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
//   final ErrorPackage errorPackage;
//   EditBasketStateRefreshFailed({this.errorPackage});
//   @override
//   List<Object> get props => [errorPackage];
}
