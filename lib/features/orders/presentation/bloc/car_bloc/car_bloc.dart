import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/orders/domain/usecase/car_usecase/add_new_car.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

class CarBloc extends Bloc<CarEvents, CarStates> {
  final AddNewCarUseCase _newCarUseCase;

  CarBloc(this._newCarUseCase) : super(CarInitialState()) {
    //1
    on<CarAddNewEvent>((event, emit) async {
      if (event is CarAddNewEvent) {
        emit(CarLoadingState());
        await _newCarUseCase
            .call(params: CarParams(event.newCar, event.customerID))
            .then((value) => emit(CarLoadedState()))
            .catchError((error) => emit(CarErrorState(error: error)));
      }
    });
  }
}
