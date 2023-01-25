import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';

import '../../domain/usecase/delete_club_usecase.dart';
import '../../domain/usecase/get_club_for_customer_usecase.dart';
import '../../domain/usecase/get_club_usecase.dart';
import '../../domain/usecase/update_club_usecase.dart';
part  'club_event.dart';
part  'club_state.dart';

class ClubBloc extends Bloc<ClubEvents, ClubStates> {
  final DeleteClubUsecase _deleteClubUsecase;
  final GetClubForCustomerUseCase _clubForCustomerUseCase;
  final GetClubUseCase _clubUseCase;
  final AddClubUseCase _addClubUseCase;

  ClubBloc(this._clubUseCase, this._addClubUseCase,
      this._clubForCustomerUseCase, this._deleteClubUsecase)
      : super(ClubInitialState()) {
    //1
    on<ClubGetEvent>((event, emit) async {
      if (event is ClubGetEvent) {
        emit(ClubLoadingState());
        final failOrPhoto = await _clubUseCase.call(NoParams());
        failOrPhoto.fold(
            (l) => emit(ClubErrorState(message: l.toString())),
            (club) => emit(ClubLoadedState(loaded: club)));
      }
    });

    //2
    on<ClubAddEvent>((event, emit) async {
      if (event is ClubAddEvent) {
        emit(ClubLoadingState());

        await _addClubUseCase
            .call(params: ClubParams(event.addEvent, event.customerId))
            .then((value) => emit(ClubAddedState()))
            .catchError((error) => emit(ClubErrorState(message: error)));
      }
    });
    //3
    on<ClubGetForCustomerEvent>((event, emit) async {
      if (event is ClubGetForCustomerEvent) {
        emit(ClubLoadingState());
        final failOrPhoto = await _clubForCustomerUseCase
            .call(ClubGetParams(customerId: event.customerId));
        failOrPhoto.fold(
            (l) => emit(ClubErrorState(message: l.toString())),
            (club) => emit(ClubLoadedForCustomerState(loaded: club)));
      }
    });
    //4
    on<ClubDeleteEvent>((event, emit) async {
      if (event is ClubDeleteEvent) {
        emit(ClubLoadingState());
        await _deleteClubUsecase
            .call(
                params: ClubDeleteParams(
                    customerId: event.customerId,
                    clubID: event.clubId))
            .then((value) => emit(ClubDeletedState()))
            .catchError((error) => emit(ClubErrorState(message: error)));
      }
    });

    //
  }
}
