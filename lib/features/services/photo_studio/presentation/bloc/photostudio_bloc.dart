import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';

import '../../domain/usecase/get_photostudio_usecase.dart';
import '../../domain/usecase/getphotostudio_for_customer_usecase.dart';
import '../../domain/usecase/update_photostudio_usecase.dart';

class PhotoStudioBloc extends Bloc<PhotoStudioEvents, PhotoStudioStates> {
  final GetPhotoStudioUseCase getPhotoStudioUseCase;
  final AddPhotoStudioUseCase addPhotoStudioUseCase;
  final GetPhotoStudioForCustomerUseCase getPhotoStudioForCustomerUseCase;

  PhotoStudioBloc(this.getPhotoStudioUseCase, this.addPhotoStudioUseCase,this.getPhotoStudioForCustomerUseCase)
      : super(PhotoStudioInitialState()) {
    //1
    on<PhotoStudioGetEvent>((event, emit) async {
      if (event is PhotoStudioGetEvent) {
        emit(PhotoStudioLoadingState());
        final failOrPhoto = await getPhotoStudioUseCase.call(NoParams());
        failOrPhoto.fold(
            (l) => emit(PhotoStudioErrorState(message: l.toString())),
            (photo) => emit(PhotoStudioLoadedState(loaded: photo)));
      }
    });

    //2
    on<PhotoStudioAddEvent>((event, emit) async {
      if (event is PhotoStudioAddEvent) {
        emit(PhotoStudioLoadingState());

        await addPhotoStudioUseCase
            .call(params: PhotoStudioParams(event.addEvent,event.customerId))
            .then((value) => emit(PhotoStudioAddedState()))
            .catchError((error) => emit(PhotoStudioErrorState(message: error)));
      }
    });
    //3
    on<PhotoStudioGetForCustomerEvent>((event, emit) async {
      if (event is PhotoStudioGetForCustomerEvent) {
        emit(PhotoStudioLoadingState());
        final failOrPhoto = await  getPhotoStudioForCustomerUseCase.call(PhotoStudioGetParams(customerId: event.customerId));
        failOrPhoto.fold(
                (l) => emit(PhotoStudioErrorState(message: l.toString())),
                (photo) => emit(PhotoStudioLoadedState(loaded: photo)));
      }
    });

    //
  }
}
