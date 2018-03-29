import 'package:flutter/material.dart';
import 'package:kwetter_app/api/auth.dart';
import 'package:kwetter_app/home.dart';
import 'package:kwetter_app/login.dart';
import 'package:kwetter_app/user.dart';

void main() {
  runApp(new KwetterApp());
}

class KwetterApp extends StatefulWidget {
  @override
  KwetterAppState createState() => new KwetterAppState();
}

class KwetterAppState extends State<KwetterApp> {
  User authenticatedUser;
  AuthService authService;
  String _title = 'Tijdlijn';
  Widget _screen;
  LoginPage _loginPage;
  HomePage _homePage;

  /// Constructor
  KwetterAppState() {
    authService = new AuthService();
    _loginPage = new LoginPage(onSubmit: onSubmit);
    _homePage = new HomePage();
    _screen = _loginPage;

    // Check if the user is already authenticated
    authService.getAuthenticatedUser().then((User user) {
      _setAuthenticated(user);
    });
  }

  void onSubmit() {
    this
        .authService
        .login(_loginPage.username, _loginPage.password)
        .then((User user) {
      _setAuthenticated(user);
    });
  }

  void _setAuthenticated(user) {
    setState(() {
      authenticatedUser = user;
      _screen = authenticatedUser != null ? _homePage : _loginPage;
    });
  }

  void _logOut() {
    authService.logout();
    _setAuthenticated(null);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Kwetter',
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text(_title),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.exit_to_app), onPressed: _logOut)
            ],
          ),
          body: _screen),
    );
  }
}
