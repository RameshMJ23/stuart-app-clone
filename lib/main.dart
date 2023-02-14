import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stuartappclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:stuartappclone/screens/auth_screen/auth_screen.dart';
import 'package:stuartappclone/screens/auth_screen/sign_up_screen.dart';
import 'package:stuartappclone/screens/filter_screen.dart';
import 'package:stuartappclone/screens/route/router.dart';
import 'package:stuartappclone/screens/route/routes_names.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetBloc>(
      lazy: false,
      create: (context) => InternetBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stuart clone',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android : ZoomPageTransitionsBuilder()
              }
          ),
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            // For auth title
            titleLarge: GoogleFonts.workSans(
                textStyle: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                )
            ),
            // For auth sub-title
            titleMedium: GoogleFonts.workSans(
                textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                )
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(GoogleFonts.workSans(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal
                    )
                )),
              )
          ),
        ),
        initialRoute: RouteNames.authWrapperScreen,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
