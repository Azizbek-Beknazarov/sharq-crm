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
import 'package:sharq_crm/features/customers/domain/usecase/delete_customer.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/orders/data/datasourse/car_datasource.dart';
import 'package:sharq_crm/features/orders/data/repository/car_repo_impl.dart';
import 'package:sharq_crm/features/orders/domain/repository/car_repo.dart';
import 'package:sharq_crm/features/orders/domain/usecase/car_usecase/add_new_car.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/data/datasourse/photostudio_remote_ds.dart';
import 'package:sharq_crm/features/services/photo_studio/data/repository/photostudio_repo_impl.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/get_photostudio_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';

import '../core/network/network_info.dart';
import 'auth/data/repository/manager_auth_repo_impl.dart';
import 'auth/domain/repository/manager_repo.dart';
import 'customers/data/datasourse/add_customer_r_ds.dart';
import 'customers/domain/repository/customer_repo.dart';
import 'customers/domain/usecase/get_all_cus_usecase.dart';
import 'customers/domain/usecase/new_customer_add_usecase.dart';

import 'customers/domain/usecase/update_customer_usecase.dart';

import 'orders/domain/usecase/car_usecase/get_all_cars.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  //
  //1
  sl.registerFactory(() => AuthBloc(
      getCurrentManager: sl(),
      loginManager: sl(),
      registerManager: sl(),
      logoutManager: sl()));

  //2
  sl.registerFactory(
      () => CustomerCubit(getAllCus: sl(), deleteCus: sl(), updateCus: sl(), addNewCus: sl()));

  //3
  sl.registerFactory(() => CarBloc(sl(),sl()));

  //4
  sl.registerFactory(() => PhotoStudioBloc(sl()));

  //
  // Use cases
  //
  //1
  sl.registerLazySingleton(() => GetCurrentManager(sl()));
  sl.registerLazySingleton(() => RegisterManager(sl()));
  sl.registerLazySingleton(() => LoginManager(sl()));
  sl.registerLazySingleton(() => LogoutManager(sl()));

  //2
  sl.registerLazySingleton(() => AddNewCustomerUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCustomersUseCase(sl()));
  sl.registerLazySingleton(
      () => CustomerDeleteUseCase(customerRepository: sl()));
  sl.registerLazySingleton(() => UpdateCustomerUseCase(repository: sl()));

  //3
  sl.registerLazySingleton(() => AddNewCarUseCase(carRepo: sl()));
  sl.registerLazySingleton(() => GetAllCarsUseCase(repo: sl()));

  //4
  sl.registerLazySingleton(() => GetPhotoStudioUseCase(repo: sl()));

  //
  // Repository
  //
  //1
  sl.registerLazySingleton<ManagerAuthRepository>(
    () => ManagerAuthRepositoryImpl(
      localDataSource: sl(),
      info: sl(),
      remoteDataSource: sl(),
    ),
  );

  //2
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(
      info: sl(), customerRemoteDS: sl()));

  //3
  sl.registerLazySingleton<CarRepo>(() => CarRepoImpl(carRemoteDataSource: sl(), info: sl()));

  //4
  sl.registerLazySingleton<PhotoStudioRepo>(() => PhotoStudioRepoImpl(remoteDS: sl(), info: sl()));

  //
  // Data sources
  //
  //1
  sl.registerLazySingleton<ManagerAuthRemoteDataSource>(
    () => ManagerAuthRemoteDataSourceImpl(
      auth: sl(),
    ),
  );
  //
  sl.registerLazySingleton<ManagerAuthLocalDataSource>(
    () => ManagerAuthLocalDataSourceImpl(preferences: sl()),
  );

  //2
  sl.registerLazySingleton<CustomerRemoteDS>(() => CustomerRemoteDSImpl());

  //3
  sl.registerLazySingleton<CarRemoteDataSource>(() => CarRemoteDataSourceImpl());

  //4
  sl.registerLazySingleton<PhotoStudioRemoteDS>(() => PhotoStudioRemoteDSImpl());


  //
  final sharedPreferences = await SharedPreferences.getInstance();

  //
  //! Core
  //
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //
  //! External
  //
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
