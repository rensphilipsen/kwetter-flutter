import 'package:flutter/material.dart';
import 'package:kwetter_app/api/auth.dart';
import 'package:kwetter_app/api/kweets.dart';
import 'package:kwetter_app/models/kweet.dart';
import 'package:kwetter_app/models/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  KweetService kweetService;
  AuthService authService;

  @override
  void initState() {
    kweetService = new KweetService();
    authService = new AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: authService.getAuthenticatedUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Dialog(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new Container(
                  margin: new EdgeInsets.only(top: 16.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildUserIdentity(snapshot.data),
                      new Padding(
                        child: _buildUserInfo(snapshot.data),
                        padding: new EdgeInsets.only(top: 24.0, bottom: 8.0),
                      ),
                      new Divider(),
                      new Expanded(child: this.createListView(snapshot.data))
                    ],
                  ),
                );
          }
        });
  }

  Widget _buildUserIdentity(User user) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(
            child: new CircleAvatar(
                backgroundImage: new NetworkImage(user.profilePicture)),
            padding: const EdgeInsets.only(right: 16.0),
          ),
          new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: new Text(user.username,
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ),
              new Text(user.email)
            ],
          )
        ]);
  }

  Widget _buildUserInfo(User user) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
          onPressed: null,
          child: new Column(
            children: <Widget>[
              new Text(user.kweets.length.toString()),
              const Text('Kweets')
            ],
          ),
        ),
        new FlatButton(
            onPressed: null,
            child: new Column(
              children: <Widget>[
                new Text(user.followers.length.toString()),
                const Text('Followers')
              ],
            )),
        new FlatButton(
            onPressed: null,
            child: new Column(
              children: <Widget>[
                new Text(user.following.length.toString()),
                const Text('Following')
              ],
            )),
      ],
    );
  }

  Widget createListView(User user) {
    List<Kweet> kweets = user.kweets;
    print(kweets);
    return new ListView.builder(
      itemCount: kweets == null ? 0 : kweets.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(kweets[index].user.profilePicture)),
                title: new Text(kweets[index].user.username),
                subtitle: new Text(kweets[index].text),
              ),
              new ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: new ButtonBar(
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('LIKE'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
