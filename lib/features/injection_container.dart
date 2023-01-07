
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharq_crm/features/auth/data/datasourse/manager_auth_lds.dart';
import 'package:sharq_crm/features/auth/data/datasourse/manager_auth_rds.dart';
import 'package:sharq_crm/features/auth/domain/usecase/get_current_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/login_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/logout_manager.dart';
import 'package:sharq_crm/features/auth/domain/usecase/register_manager.dart';
import 'package:sharq_crm/features/auth/presentation/bloc/m_auth_bloc.dart';

import '../core/network/network_info.dart';
import 'auth/data/repository/manager_auth_repo_impl.dart';
import 'auth/domain/repository/manager_repo.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  sl.registerFactory(() =>
      AuthBloc(getCurrentManager: sl(), loginManager: sl(), registerManager: sl(), logoutManager: sl()));




  // Use cases

  sl.registerLazySingleton(() => GetCurrentManager(sl()));
  sl.registerLazySingleton(() => RegisterManager(sl()));
  sl.registerLazySingleton(() => LoginManager(sl()));
  sl.registerLazySingleton(() => LogoutManager(sl()));

  // Repository

  sl.registerLazySingleton<ManagerAuthRepository>(
        () =>
            ManagerAuthRepositoryImpl(
          localDataSource: sl(),
          info: sl(),
          remoteDataSource: sl(),
        ),
  );


  // Data sources

  sl.registerLazySingleton<ManagerAuthRemoteDataSource>(
        () => ManagerAuthRemoteDataSourceImpl(auth: sl(),),
  );

  sl.registerLazySingleton<ManagerAuthLocalDataSource>(
        () => ManagerAuthLocalDataSourceImpl(preferences: sl()),
  );


  final sharedPreferences = await SharedPreferences.getInstance();



  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
