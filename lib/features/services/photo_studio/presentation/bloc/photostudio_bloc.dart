import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_event.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_state.dart';

import '../../domain/usecase/delete_photo_studio_usecase.dart';
import '../../domain/usecase/get_datetime_orders_usecase.dart';
import '../../domain/usecase/get_photostudio_usecase.dart';
import '../../domain/usecase/getphotostudio_for_customer_usecase.dart';
import '../../domain/usecase/add_photostudio_usecase.dart';
import '../../domain/usecase/update_photostudio_usecase.dart';

class PhotoStudioBloc extends Bloc<PhotoStudioEvents, PhotoStudioStates> {
  final GetPhotoStudioUseCase getPhotoStudioUseCase;
  final AddPhotoStudioUseCase addPhotoStudioUseCase;
  final GetPhotoStudioForCustomerUseCase getPhotoStudioForCustomerUseCase;
  final DeletePhotoStudioUsecase deletePhotoStudioUsecase;
  final UpdatePhotoStudioUseCase updatePhotoStudioUseCase;
  final PhotoGetDateTimeOrdersUsecase getDateTimeOrdersUsecase;

  PhotoStudioBloc(
      this.getPhotoStudioUseCase,
      this.addPhotoStudioUseCase,
      this.getPhotoStudioForCustomerUseCase,
      this.deletePhotoStudioUsecase,
      this.updatePhotoStudioUseCase,this.getDateTimeOrdersUsecase)
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
            .call(params: PhotoStudioParams(event.addEvent, event.customerId))
            .then((value) => emit(PhotoStudioAddedState()))
            .catchError((error) => emit(PhotoStudioErrorState(message: error)));
      }
    });
    //3
    on<PhotoStudioGetForCustomerEvent>((event, emit) async {
      if (event is PhotoStudioGetForCustomerEvent) {
        emit(PhotoStudioLoadingState());
        final failOrPhoto = await getPhotoStudioForCustomerUseCase
            .call(PhotoStudioGetParams(customerId: event.customerId));
        failOrPhoto.fold(
            (l) => emit(PhotoStudioErrorState(message: l.toString())),
            (photo) => emit(PhotoStudioLoadedForCustomerState(loaded: photo)));
      }
    });
    //4
    on<PhotoStudioDeleteEvent>((event, emit) async {
      if (event is PhotoStudioDeleteEvent) {
        emit(PhotoStudioLoadingState());
        await deletePhotoStudioUsecase
            .call(
                params: PhotoStudioDeleteParams(
                    customerId: event.customerId,
                    photoStudioID: event.photoStudioId))
            .then((value) => emit(PhotoStudioDeletedState()))
            .catchError((error) => emit(PhotoStudioErrorState(message: error)));
      }
    });
    //5
    on<PhotoStudioUpdateEvent>((event, emit) async {
      if (event is PhotoStudioUpdateEvent) {
        emit(PhotoStudioLoadingState());

        await updatePhotoStudioUseCase
            .call(
                params: PhotoStudioUpdateParams(
                    event.photostudioId, event.customerId))
            .then((value) => emit(PhotoStudioUpdatedState()))
            .catchError((error) =>
                emit(PhotoStudioErrorState(message: error.toString())));
      }
    });

    //6
    on<PhotoStudioGetDateTimeOrdersEvent>((event, emit) async{

      if (event is PhotoStudioGetDateTimeOrdersEvent) {
        emit(PhotoStudioLoadingState());

        await getDateTimeOrdersUsecase
            .call(
            params: GetDateTimeOrdersParam(event.dateTime))
            .then((value) => emit(PhotoStudioLoadedDateTimeState(value)))
            .catchError((error) =>
            emit(PhotoStudioErrorState(message: error.toString())));
      }
    });

    //
  }
}
