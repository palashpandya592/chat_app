import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/login/bloc/login_bloc.dart';
import 'package:chatting_app/login/login_page.dart';
import 'package:chatting_app/provider/login_provider.dart';
import 'package:chatting_app/registration/registration_page.dart';
import 'package:chatting_app/repository/login_repository.dart';
import 'package:chatting_app/theme/app_theme.dart';
import 'package:chatting_app/theme/cubit/theme_cubit.dart';
import 'package:chatting_app/utilities/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return MaterialApp(
      theme: theme.isDark ? ThemeData.dark() : lightTheme,
      debugShowCheckedModeBanner: false,
      title: AppStrings.chattingApp,
      home: BlocProvider(
        create: (context) => LoginBloc(
          loginRepository: LoginRepository(
            loginProvider: LoginProvider(firebaseAuth: FirebaseAuth.instance),
          ),
        )..add(LoginVerified()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginFailure) {
              return LoginPage();
            } else if (state is LoginSuccess) {
              return RegistrationPage(authenticatedUser: state.user);
            } else if (state is LoginInProgress) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return Text(AppStrings.loginFailed);
          },
        ),
      ),
    );
  }
}
