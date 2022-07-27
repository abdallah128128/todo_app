import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/core/bloc_observer.dart';
import 'package:todo_app/core/cache_helper.dart';
import 'package:todo_app/core/themes/app_theme.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/screens/board_screen/board_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp({Key? key, this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(fromShared: isDark)
              ..createDataBase(),
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  themeMode: AppCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  theme: lightMode,
                  darkTheme: darkMode,
                  home: const BoardPage(),
                );
              },
            ),
          );
        });
  }
}
