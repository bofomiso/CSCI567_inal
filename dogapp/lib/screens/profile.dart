import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogapp/screens/newdog.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({Key key, this.uid}) : super(key: key); 
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: Text('Your Dogs'), actions: <Widget>[
        FlatButton.icon(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewDog()));
            },
            icon: Icon(Icons.person),
            label: Text("Add Dog"))
      ]),
      body: StreamBuilder(                    
          stream: Firestore.instance.collection('dog').where('userId', isEqualTo: widget.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return ListView(
              children: snapshot.data.documents.map((document) {
                return Card(
                  child: ListTile(
                    title: Text(document['name']),
                    subtitle: Text(document['breed']),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                    onTap: (){
                      print(document['name']);
                    },
                  ),
                );
              }).toList(),
            );
          }),
    );
  }

}
