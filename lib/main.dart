import 'package:flutter/material.dart';
import 'package:kwetter_app/api/auth.dart';
import 'package:kwetter_app/models/user.dart';
import 'package:kwetter_app/pages/home.dart';
import 'package:kwetter_app/pages/login.dart';
import 'package:kwetter_app/pages/profile.dart';

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
  ProfilePage _profilePage;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Constructor
  KwetterAppState() {
    authService = new AuthService();
    _loginPage = new LoginPage(onSubmit: onSubmit);
    _homePage = new HomePage();
    _profilePage = new ProfilePage();
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

  void _toggleProfilePage() {
    setState(() {
      if (_screen == _profilePage) {
        _screen = _homePage;
        _title = 'Tijdlijn';
      } else {
        _screen = _profilePage;
        _title = 'Mijn Profiel';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Kwetter',
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(_title),
          leading: new IconButton(
              icon: new Icon(Icons.exit_to_app), onPressed: _logOut),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                  _screen == _profilePage ? Icons.home : Icons.account_circle),
              onPressed: _toggleProfilePage,
            ),
          ],
        ),
        body: _screen,
      ),
    );
  }
}
