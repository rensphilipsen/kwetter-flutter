import 'package:flutter/material.dart';
import 'package:kwetter_app/api/kweets.dart';
import 'package:kwetter_app/models/kweet.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  KweetService kweetService;
  List<Kweet> kweets;

  @override
  void initState() {
    kweetService = new KweetService();
    kweetService.getTimeline().then((data) {
      setState(() {
        kweets = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: kweets == null ? 0 : kweets.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new CircleAvatar(
                    backgroundImage: new NetworkImage(kweets[index].user.profilePicture)),
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
