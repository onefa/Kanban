import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authentication_state.dart';

class User {
  String username;
  String password;

  User({this.username, this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password": this.password
  };
}


class AuthorizationPage extends StatefulWidget {

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: <Widget>[
          _logo(),
             Column(
                children: <Widget>[
                  _form('Login', _loginButton),
                  Padding(
                    padding: EdgeInsets.all(10),
                  )
                ],
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 90),
      child: Container(
        child: Align(
          child: Text('Like Trello Board',
            style: TextStyle(fontSize: 25, color: Colors.white30),
          ),
        ),
      ),
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        children:
        <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input(Icon(Icons.face), 'login', _loginController, false),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input(Icon(Icons.lock_outline),'password', _passwordController, true),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style:  TextStyle(color: Colors.white38, fontSize: 20),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 20, color: Colors.white24),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent,
                    width: 3)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue,
                    width: 1)
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: icon,
            )
        ),
      ),
    );
  }

  Widget _button(String label, void func()) {
    return RaisedButton(
      child: Text(label,
      ),
      onPressed: () {
        func();
      },
    );
  }

  _loginButton() async {
//    String _login = "armada";
//    String _password = "FSH6zBZ0p9yH";
    User user = User(username: _loginController.text,
                     password: _passwordController.text);
    _loginController.clear();
    _passwordController.clear();
    _authenticationBloc.add(LoginButtonPressed(user));
  }
}


class AuthorizationError extends StatefulWidget {
  @override
  _AuthorizationErrorState createState() => _AuthorizationErrorState();
}

class _AuthorizationErrorState extends State<AuthorizationError> {
  String error;
  AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    AuthenticationError state = _authenticationBloc.state;
    error = state.error != null ? state.error : 'Unknown error';

      return Scaffold (
          body: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Text('Error: ' + error.toString(), style: TextStyle(fontSize: 17),),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _authenticationBloc.add(UserLoggedOut()),
              label: Text('Return')
          )
      );
  }
}
