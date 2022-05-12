import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';

class CheckInfoBloc extends Bloc<CheckInfoEvent, CheckInfoState> {
  ContainerUseCase containerUseCase;
  CheckInfoBloc(this.containerUseCase) : super(CheckInfoStateLoading());
  @override
  Stream<CheckInfoState> mapEventToState(CheckInfoEvent checkInfoEvent) async* {
    if (checkInfoEvent is CheckInfoEventRequested) {
      yield CheckInfoStateLoading();
      //Tất cả các lệnh dùng repository, đều phải có try catch để tránh lỗi crash
      try {
        final ContainerData basketOrErr =
            await containerUseCase.getContainerById(checkInfoEvent.basketID);
        if (basketOrErr is ContainerData) {
          //Trả về view nguyên cái basket, view tự tách ra mà dùng
          yield CheckInfoStateSuccess(basketOrErr);
        } else {
          yield CheckInfoStateFailure(); // Viết vậy để truyền String vô thôi
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
