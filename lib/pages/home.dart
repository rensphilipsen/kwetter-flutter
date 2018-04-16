import 'package:flutter/material.dart';
import 'package:kwetter_app/api/kweets.dart';
import 'package:kwetter_app/models/kweet.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  KweetService kweetService;

  @override
  void initState() {
    kweetService = new KweetService();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: kweetService.getTimeline(),
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
                return createListView(context, snapshot);
          }
        });
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Kweet> kweets = snapshot.data;
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
