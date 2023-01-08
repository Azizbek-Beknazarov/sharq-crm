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
import 'package:sharq_crm/features/customers/data/repository/customer_repo_impl.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/get_customers_cubit/get_cus_cubit.dart';

import '../core/network/network_info.dart';
import 'auth/data/repository/manager_auth_repo_impl.dart';
import 'auth/domain/repository/manager_repo.dart';
import 'customers/data/datasourse/add_customer_r_ds.dart';
import 'customers/domain/repository/customer_repo.dart';
import 'customers/domain/usecase/get_all_cus_usecase.dart';
import 'customers/domain/usecase/new_customer_add_usecase.dart';
import 'customers/presentation/bloc/new_customer_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  sl.registerFactory(() => AuthBloc(
      getCurrentManager: sl(),
      loginManager: sl(),
      registerManager: sl(),
      logoutManager: sl()));

  sl.registerFactory(() => CustomerBloc(
        sl(),
      ));
  sl.registerFactory(() => CustomerCubit(getAllCus: sl()));

  // Use cases

  sl.registerLazySingleton(() => GetCurrentManager(sl()));
  sl.registerLazySingleton(() => RegisterManager(sl()));
  sl.registerLazySingleton(() => LoginManager(sl()));
  sl.registerLazySingleton(() => LogoutManager(sl()));

  sl.registerLazySingleton(() => AddNewCustomerUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCustomersUseCase(sl()));
  // Repository

  sl.registerLazySingleton<ManagerAuthRepository>(
    () => ManagerAuthRepositoryImpl(
      localDataSource: sl(),
      info: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(
      remodeDS: sl(), info: sl(), customerRemoteDS: sl()));

  // Data sources

  sl.registerLazySingleton<ManagerAuthRemoteDataSource>(
    () => ManagerAuthRemoteDataSourceImpl(
      auth: sl(),
    ),
  );

  sl.registerLazySingleton<ManagerAuthLocalDataSource>(
    () => ManagerAuthLocalDataSourceImpl(preferences: sl()),
  );

  sl.registerLazySingleton(() => AddCustomerRDS());
  sl.registerLazySingleton<CustomerRemoteDS>(() => CustomerRemoteDSImpl());

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
