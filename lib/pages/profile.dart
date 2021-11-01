import 'package:flutter/material.dart';
import 'package:flutter_back_php/pages/form.dart';


class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProfileHeader(
            title: "Randria",
            subtitle: "Olivier",
            actions: <Widget>[
              MaterialButton(
                color: Colors.white,
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(Icons.edit),
                onPressed: () {
                  _onButtonPressed(context);
                },
              )
            ],
          ),
          const SizedBox(height: 10.0),
          UserInfo(),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "Informations",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Adresse"),
                            subtitle: Text("Lot D21 Ambohitsoa"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text("randria.olivier@gmail.com"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Telephone"),
                            subtitle: Text("0321322476"),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Sexe"),
                            subtitle: Text(
                                "Masculin."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic>? avatar;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
        this.avatar,
        this.title,
        this.subtitle,
        this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (actions != null)
          Container(
            width: double.infinity,
            height: 135,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Text(
                title! + ' '+subtitle!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        )
      ],
    );
  }
}

void _onButtonPressed(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context){
        return CustomForm();
      });
}