import 'package:diary_sysman/data/database/database_helper.dart';
import 'package:diary_sysman/data/diary_repository.dart';
import 'package:diary_sysman/data/prod/diary_impl.dart';
import 'package:diary_sysman/ui/diary/cubit/diary_cubit.dart';
import 'package:diary_sysman/ui/entry/cubit/entry_cubit.dart';
import 'package:diary_sysman/ui/splash/splash_screen.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/custom_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()async {
  await initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers:  <RepositoryProvider>[
        RepositoryProvider<DiaryRepository>(create: (_) => DiaryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>DiaryCubit()),
          BlocProvider(create: (_)=>EntryCubit()),
        ],
        child: MaterialApp(
          title: 'Diary Sysman',
          debugShowCheckedModeBanner: false,
          theme: _isDarkMode ? darkTheme : lightTheme,
          home:  SplashScreen(onThemeToggle:_toggleTheme)
        ),
      ),
    );
  }
}
