import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';
import 'package:mobile_cha_warehouse/domain/usecases/inconsistency_container_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_basket_state.dart';

class EditBasketBloc extends Bloc<EditBasketEvent, EditBasketState> {
  InconsistencyContainerUseCase inconsistencyContainerUseCase;
  EditBasketBloc(this.inconsistencyContainerUseCase)
      : super(EditBasketStateRefreshLoading()) {
    on<EditBasketEventRequest>(_onLoading);
  }
  Stream<void> _onLoading(
      EditBasketEvent event, Emitter<EditBasketState> emit) async* {
    yield EditBasketStateRefreshLoading();
    try {
      final inconsistencyContainer =
          await inconsistencyContainerUseCase.getInconsistencyContainers();
      if (inconsistencyContainer.length == 0 ||
          inconsistencyContainer is List<ContainerInconsistency>) {
        yield EditBasketStateRefreshSuccess(inconsistencyContainer);
      } else {
        print('error');
      }
    } catch (e) {
      // state fail
    }
  }
}
