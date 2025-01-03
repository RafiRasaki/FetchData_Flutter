import 'package:fetchingdata/bloc/live_game_bloc.dart';
import 'package:fetchingdata/cubit/genre_cubit.dart';
import 'package:fetchingdata/pages/live_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LiveGameBloc()),
        BlocProvider(create: (context) => GenreCubit()),
      ],
      child:  const MaterialApp(
      home: LiveGamePage(),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}

