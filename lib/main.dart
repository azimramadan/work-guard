import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/helper/shared_prefs_helper.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/auth/data/repositories/sign_in_repository%20.dart';
import 'package:work_guard/features/auth/presentation/view_model/cubit/auth_sign_in_cubit.dart';
import 'package:work_guard/features/home/presentation/view_model/cubit/attendance_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final bool isFirstTime = await SharedPrefsHelper.isFirstTimeUser();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  // Register Hive adapter
  Hive.registerAdapter(UserLocalModelAdapter());

  // Open the box
  await Hive.openBox<UserLocalModel>('userBox');
  runApp(WorkGuardApp(isFirstTime: isFirstTime));
}

class WorkGuardApp extends StatelessWidget {
  const WorkGuardApp({super.key, required this.isFirstTime});
  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthSignInCubit(SignInRepository())),
        BlocProvider(create: (context) => AttendanceCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        routerConfig: AppRouter.createRouter(isFirstTime: isFirstTime),
      ),
    );
  }
}
