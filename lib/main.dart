import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/bloc/customer_cubit.dart';
import 'package:sharq_crm/features/orders/presentation/bloc/car_bloc/car_bloc.dart';
import 'package:sharq_crm/features/services/album/presentation/bloc/album_bloc.dart';
import 'package:sharq_crm/features/services/club/presentation/bloc/club_bloc.dart';
import 'package:sharq_crm/features/services/photo_studio/presentation/bloc/photostudio_bloc.dart';
import 'package:sharq_crm/features/services/video/presentation/bloc/video_bloc.dart';

import 'features/auth/presentation/bloc/m_auth_bloc.dart';
import 'features/choose_page.dart';
import 'features/injection_container.dart' as di;
import 'features/splash_screen_for_customer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>di.sl<AuthBloc>()..add(GetCurrentManagerEvent())),



          BlocProvider<CustomerCubit>(
            create: (_) => di.sl<CustomerCubit>()..getCurrentCustomerEvent(),
          ),
          BlocProvider(
            create: (_) => di.sl<PhotoStudioBloc>(),
          ),
          BlocProvider(create: (_) => di.sl<CarBloc>()),
          BlocProvider(create: (_) => di.sl<ClubBloc>()),
          BlocProvider(create: (_) => di.sl<AlbumBloc>()),
          BlocProvider(create: (_) => di.sl<VideoBloc>()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CRM',

          // home: CustomersPage(),
          home: SplashScreenForCustomer(),
        ));
  }
}
