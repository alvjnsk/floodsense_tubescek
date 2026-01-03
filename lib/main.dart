import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/home/home_cubit.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/admin_page.dart';

void main() {
  runApp(const FloodSenseApp());
}

class FloodSenseApp extends StatelessWidget {
  const FloodSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/admin': (context) => const AdminPage(),
        },
      ),
    );
  }
}
