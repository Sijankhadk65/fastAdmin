import 'package:fastibtmsadmin/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(
        children: [
          StreamBuilder<String>(
              stream: _loginBloc.email,
              builder: (context, snapshot) {
                return TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: _loginBloc.changeEmail,
                );
              }),
          StreamBuilder<String>(
              stream: _loginBloc.password,
              builder: (context, snapshot) {
                return TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onChanged: _loginBloc.changePassword,
                );
              }),
          StreamBuilder<bool>(
              stream: _loginBloc.canLogin(),
              builder: (context, snapshot) {
                print("This is the snapshot :${snapshot.data}");
                return RaisedButton(
                  onPressed: snapshot.hasData
                      ? () {
                          try {
                            _loginBloc.loginUser();
                          } catch (e) {}
                        }
                      : null,
                  child: Text("Login"),
                );
              }),
        ],
      )),
    );
  }
}
