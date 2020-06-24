import 'package:fastibtmsadmin/src/bloc/login_bloc.dart';
import 'package:fastibtmsadmin/src/root.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          textTheme: TextTheme(
            headline6: GoogleFonts.oswald(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
        ),
      ),
      home: Provider(
        create: (_) => LoginBloc(),
        dispose: (context, LoginBloc bloc) => bloc.dispose(),
        child: Root(),
      ),
    );
  }
}
