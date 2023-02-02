import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';

import '../../domain/usecase/delete_album_usecase.dart';
import '../../domain/usecase/get_album_for_customer_usecase.dart';
import '../../domain/usecase/get_album_usecase.dart';
import '../../domain/usecase/add_album_usecase.dart';

part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvents, AlbumStates> {
  final DeleteAlbumClubUsecase _deleteAlbumClubUsecase;
  final GetAlbumForCustomerUseCase _getAlbumForCustomerUseCase;
  final GetAlbumUseCase _getAlbumUseCase;
  final AddAlbumUseCase _addAlbumUseCase;

  AlbumBloc(this._addAlbumUseCase, this._deleteAlbumClubUsecase,
      this._getAlbumUseCase, this._getAlbumForCustomerUseCase)
      : super(AlbumInitialState()) {
    //1
    on<AlbumGetEvent>((event, emit) async {
      if (event is AlbumGetEvent) {
        emit(AlbumLoadingState());
        final failOrAlbum = await _getAlbumUseCase.call(NoParams());
        failOrAlbum.fold((l) => emit(AlbumErrorState(message: l.toString())),
            (album) => emit(AlbumLoadedState(loaded: album)));
      }
    });

    //2
    on<AlbumAddEvent>((event, emit) async {
      if (event is AlbumAddEvent) {
        emit(AlbumLoadingState());

        await _addAlbumUseCase
            .call(params: AlbumParams(event.addEvent, event.customerId))
            .then((value) => emit(AlbumAddedState()))
            .catchError((error) => emit(AlbumErrorState(message: error)));
      }
    });
    //3
    on<AlbumGetForCustomerEvent>((event, emit) async {
      if (event is AlbumGetForCustomerEvent) {
        emit(AlbumLoadingState());
        final failOrAlbum = await _getAlbumForCustomerUseCase
            .call(AlbumGetParams(customerId: event.customerId));
        failOrAlbum.fold((l) => emit(AlbumErrorState(message: l.toString())),
            (album) => emit(AlbumLoadedForCustomerState(loaded: album)));
      }
    });
    //4
    on<AlbumDeleteEvent>((event, emit) async {
      if (event is AlbumDeleteEvent) {
        emit(AlbumLoadingState());
        await _deleteAlbumClubUsecase
            .call(
                params: AlbumDeleteParams(
                    customerId: event.customerId, albumID: event.albumId))
            .then((value) => emit(AlbumDeletedState()))
            .catchError((error) => emit(AlbumErrorState(message: error)));
      }
    });

    //
  }
}
