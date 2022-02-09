import 'business_logic/cubit/app_cubit.dart';
import 'helpers/dio_helper.dart';
import 'presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => AppCubit()..getAllCharacters(),
        child: HomeScreen(),
      ),
    );
  }
}
