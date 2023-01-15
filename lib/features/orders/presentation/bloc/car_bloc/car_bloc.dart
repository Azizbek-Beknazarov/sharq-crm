import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/orders/domain/usecase/car_usecase/add_new_car.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_event.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_state.dart';

import '../../../domain/usecase/car_usecase/get_all_cars.dart';

class CarBloc extends Bloc<CarEvents, CarStates> {
  final AddNewCarUseCase _newCarUseCase;
  final GetAllCarsUseCase _getAllCarsUseCase;

  CarBloc(this._newCarUseCase,this._getAllCarsUseCase) : super(CarInitialState()) {
    //1
    on<CarAddNewEvent>((event, emit) async {
      if (event is CarAddNewEvent) {
        emit(CarLoadingState());
        await _newCarUseCase
            .call(params: CarParams(event.newCar, ))
            .then((value) => emit(CarAddedState()))
            .catchError((error) => emit(CarErrorState(error: error)));
      }
    });
    //2
    on<CarGetAllEvent>((event, emit) async{
      if(event is CarGetAllEvent){
        emit(CarLoadingState());
        final failOrCar=await _getAllCarsUseCase.call(NoParams());
        failOrCar.fold((l) => emit(CarErrorState(error: 'CarGetAllEvent error in CarBloc')),
                (r) => emit(CarLoadedState(cars: r)));
      }
    });
  }
}
