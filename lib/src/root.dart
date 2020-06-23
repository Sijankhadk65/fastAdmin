import 'package:fastibtmsadmin/src/bloc/login_bloc.dart';
import 'package:fastibtmsadmin/src/screens/home_screen.dart';
import 'package:fastibtmsadmin/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => LoginBloc(),
      dispose: (context, LoginBloc bloc) => bloc.dispose(),
      child: StreamBuilder<User>(
          stream: _loginBloc.userStatus(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? HomeScreen(
                    user: snapshot.data,
                  )
                : LoginScreen();
          }),
    );
  }
}
