import 'package:diary_sysman/data/diary_repository.dart';
import 'package:diary_sysman/data/prod/diary_impl.dart';
import 'package:diary_sysman/ui/diary/cubit/diary_cubit.dart';
import 'package:diary_sysman/ui/entry/cubit/entry_cubit.dart';
import 'package:diary_sysman/ui/splash/splash_screen.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()async {
  await initializeDateFormatting('es_ES', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
            useMaterial3: true,
          ),
          home: const SplashScreen()
        ),
      ),
    );
  }
}
