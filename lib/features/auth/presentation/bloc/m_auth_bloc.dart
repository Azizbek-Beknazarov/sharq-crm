import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/util/constants.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';
import 'package:sharq_crm/features/auth/domain/usecase/get_current_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/login_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/logout_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/register_manager.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

part 'm_auth_event.dart';
part 'm_auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentManager getCurrentManager;
  final LoginManager loginManager;
  final RegisterManager registerManager;
  final LogoutManager logoutManager;

  AuthBloc({
    required this.getCurrentManager,
    required this.loginManager,
    required this.registerManager,
    required this.logoutManager,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginManagerEvent) {
        emit(AuthLoadingState());
        final failureOr = await loginManager(
          event.authData,
        );
        emit(_eitherFailureOrManager(failureOr));
      } else if (event is RegisterManagerEvent) {
        emit(AuthLoadingState());
        final failureOr = await registerManager(
          event.authData,
        );
        emit(_eitherFailureOrManager(failureOr));
      } else  if (event is GetCurrentManagerEvent) {
        emit(AuthLoadingState());
        final failureOr = await getCurrentManager(NoParams());
        emit(failureOr.fold(
              (_) => AuthInitial(),
              (manager) => LoadedManagerState(managerEntity: manager),
        ));
      } else if (event is LogoutEvent) {
        emit(AuthLoadingState());
        final failureOrDone = await logoutManager(NoParams());
        emit(failureOrDone.fold(
              (failure) => AuthErrorState(message: _mapFailureToMessage(failure)),
              (isDone) => const MessageState(message: LOGOUT_MESSAGE),
        ));
      }
    });
  }
}

AuthState _eitherFailureOrManager(Either<Failure, ManagerEntity> either) {
  return either.fold(
        (failure) => AuthErrorState(message: _mapFailureToMessage(failure)),
        (manager) => LoadedManagerState(managerEntity: manager),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE;
    case CanceledByUserFailure:
      return CANCELED_BY_USER_FAILURE_MESSAGE;
    case InvalidDataFailure:
      return INVALID_DATA_FAILURE_MESSAGE;
    case FirebaseDataFailure:
      final FirebaseDataFailure _firebaseFailure =
      failure as FirebaseDataFailure;
      return _firebaseFailure.message;
    default:
      return 'Unexpected Error, Please try again later .';
  }
}
