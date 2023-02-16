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
import 'package:sharq_crm/features/customers/data/datasourse/customer_local_datasource.dart';
import 'package:sharq_crm/features/customers/data/repository/customer_repo_impl.dart';
import 'package:sharq_crm/features/customers/domain/usecase/delete_customer.dart';
import 'package:sharq_crm/features/customers/domain/usecase/get_current_customer_from_collection.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/orders/data/datasourse/car_datasource.dart';
import 'package:sharq_crm/features/orders/data/repository/car_repo_impl.dart';
import 'package:sharq_crm/features/orders/domain/repository/car_repo.dart';
import 'package:sharq_crm/features/orders/domain/usecase/car_usecase/add_new_car.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/services/album/data/datasourse/album_remote_datasource.dart';
import 'package:sharq_crm/features/services/album/data/repository/album_repo_impl.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/delete_album_usecase.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/get_album_for_customer_usecase.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/get_album_usecase.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/add_album_usecase.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/update_album_usecase.dart';
import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import 'package:sharq_crm/features/services/club/data/datasourse/club_remote_datasource.dart';
import 'package:sharq_crm/features/services/club/data/repository/club_repo_impl.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/delete_club_usecase.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/get_club_for_customer_usecase.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/get_club_usecase.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/add_club_usecase.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/get_datetime_orders_usecase.dart';
import 'package:sharq_crm/features/services/club/domain/usecase/update_club_usecase.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/data/datasourse/photostudio_remote_ds.dart';
import 'package:sharq_crm/features/services/photo_studio/data/repository/photostudio_repo_impl.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/delete_photo_studio_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/get_datetime_orders_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/get_photostudio_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/getphotostudio_for_customer_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/add_photostudio_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/usecase/update_photostudio_usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/video/domain/usecase/delete_video_usecase.dart';
import 'package:sharq_crm/features/services/video/domain/usecase/get_datetime_orders_usecase.dart';
import 'package:sharq_crm/features/services/video/domain/usecase/get_video_for_customer_usecase.dart';
import 'package:sharq_crm/features/services/video/domain/usecase/update_video_usecase.dart';
import 'package:sharq_crm/features/services/video/presentation/bloc/video_bloc.dart';

import '../core/network/network_info.dart';
import 'auth/data/repository/manager_auth_repo_impl.dart';
import 'auth/domain/repository/manager_repo.dart';
import 'customers/data/datasourse/customer_remote_ds.dart';
import 'customers/domain/repository/customer_repo.dart';
import 'customers/domain/usecase/get_all_cus_usecase.dart';
import 'customers/domain/usecase/get_current_customer.dart';
import 'customers/domain/usecase/logout_customer.dart';
import 'customers/domain/usecase/new_customer_add_usecase.dart';
import 'package:sharq_crm/features/services/album/domain/usecase/get_datetime_orders_usecase.dart';
import 'customers/domain/usecase/update_customer_usecase.dart';

import 'orders/domain/usecase/car_usecase/get_all_cars.dart';
import 'services/video/data/datasourse/video_remote_datasource.dart';
import 'services/video/data/repository/video_repo_impl.dart';
import 'services/video/domain/repository/video_repo.dart';
import 'services/video/domain/usecase/get_video_usecase.dart';
import 'services/video/domain/usecase/add_video_usecase.dart';

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
  sl.registerFactory(() => CustomerCubit(
      getAllCus: sl(),
      deleteCus: sl(),
      updateCus: sl(),
      addNewCus: sl(),
      getCurrentCustomer: sl(),
      getCurrentCustomerFromCollection: sl(), logOutCustomerUseCase: sl()));

  //3
  sl.registerFactory(() => CarBloc(sl(), sl()));

  //4
  sl.registerFactory(() => PhotoStudioBloc(sl(), sl(), sl(), sl(),sl(),sl()));

  //5
  sl.registerFactory(() => ClubBloc(sl(), sl(), sl(), sl(),sl(),sl()));

  //6
  sl.registerFactory(() => AlbumBloc(sl(), sl(), sl(), sl(),sl(),sl()));

  //7
  sl.registerFactory(() => VideoBloc(sl(), sl(), sl(), sl(),sl(),sl()));

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
  sl.registerLazySingleton(() => GetCurrentCustomerUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentCustomerFromCollectionUsecase(sl()));
  sl.registerLazySingleton(() => LogOutCustomerUseCase(sl()));

  //3
  sl.registerLazySingleton(() => AddNewCarUseCase(carRepo: sl()));
  sl.registerLazySingleton(() => GetAllCarsUseCase(repo: sl()));

  //4
  sl.registerLazySingleton(() => GetPhotoStudioUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddPhotoStudioUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeletePhotoStudioUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetPhotoStudioForCustomerUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdatePhotoStudioUseCase(repo: sl()));
  sl.registerLazySingleton(() => PhotoGetDateTimeOrdersUsecase(repo: sl()));

  //5
  sl.registerLazySingleton(() => GetClubUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddClubUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeleteClubUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetClubForCustomerUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateClubUseCase(repo: sl()));
  sl.registerLazySingleton(() => ClubGetDateTimeOrdersUsecase(repo: sl()));


  //6
  sl.registerLazySingleton(() => DeleteAlbumClubUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetAlbumForCustomerUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetAlbumUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddAlbumUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateAlbumUseCase(repo: sl()));
  sl.registerLazySingleton(() => AlbumGetDateTimeOrdersUsecase(repo: sl()));

  //7
  sl.registerLazySingleton(() => DeleteVideoClubUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetVideoForCustomerUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetVideoUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddVideoUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateVideoUseCase(repo: sl()));
  sl.registerLazySingleton(() => VideoGetDateTimeOrdersUsecase(repo: sl()));

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
      info: sl(), customerRemoteDS: sl(), localDataSource: sl()));

  //3
  sl.registerLazySingleton<CarRepo>(
      () => CarRepoImpl(carRemoteDataSource: sl(), info: sl()));

  //4
  sl.registerLazySingleton<PhotoStudioRepo>(
      () => PhotoStudioRepoImpl(remoteDS: sl(), info: sl()));

  //5
  sl.registerLazySingleton<ClubRepo>(
      () => ClubRepoImpl(remoteDS: sl(), info: sl()));
  //6
  sl.registerLazySingleton<AlbumRepo>(
      () => AlbumRepoImpl(remoteDS: sl(), info: sl()));
  //7
  sl.registerLazySingleton<VideoRepo>(
      () => VideoRepoImpl(remoteDS: sl(), info: sl()));

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
  sl.registerLazySingleton<CustomerLocalDataSource>(
      () => CustomerLocalDataSourceImpl(preferences: sl()));

  //3
  sl.registerLazySingleton<CarRemoteDataSource>(
      () => CarRemoteDataSourceImpl());

  //4
  sl.registerLazySingleton<PhotoStudioRemoteDS>(
      () => PhotoStudioRemoteDSImpl());

  //5
  sl.registerLazySingleton<ClubRemoteDataSource>(
      () => ClubRemoteDataSourceImpl());

  //6
  sl.registerLazySingleton<AlbumRemoteDataSource>(
      () => AlbumRemoteDataSourceImpl());

  //7
  sl.registerLazySingleton<VideoRemoteDataSource>(
          () => VideoRemoteDataSourceImpl());


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
