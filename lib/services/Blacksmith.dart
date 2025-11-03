import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/models.dart';
import '../provider/userprovider.dart';
import '../users/firstuser.dart';

class Blacksmith extends StatefulWidget {
  const Blacksmith({super.key});

  @override
  State<Blacksmith> createState() => _BlacksmithState();
}

class _BlacksmithState extends State<Blacksmith> {

  @override

  void initState() {
    super.initState();
  Provider.of<UserProvider>(context, listen: false).setUsers( [


  UserModel(
  id: "1",
  phone: "",
  image: "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8",
  name: "Mohammed",
  job: "Blacksmith",
  ),

  UserModel(
  id: "1",
  phone: "",
  image: "https://previews.123rf.com/images/sanneberg/sanneberg1611/sanneberg161100860/65642082-portrait-of-happy-man-smiling-for-camera.jpg",
  name: "Mohammed",
  job: "Blacksmith",
  ),

  UserModel(
  id: "1",
  phone: "",
  image: "https://previews.123rf.com/images/sanneberg/sanneberg1611/sanneberg161100860/65642082-portrait-of-happy-man-smiling-for-camera.jpg",
  name: "Mohammed",
  job: "Blacksmith",
  ),

  UserModel(
  id: "1",
  phone: "",
  image: "https://previews.123rf.com/images/sanneberg/sanneberg1611/sanneberg161100860/65642082-portrait-of-happy-man-smiling-for-camera.jpg",

  name: "Mohammed",
  job: "Blacksmith",
  ),

  ],
  );}


  @override
  Widget build(BuildContext context) {

final provider = Provider.of<UserProvider>(context);

return Scaffold(
appBar: AppBar(title: Text("Blacksmiths")),
body: ListView.builder(
itemCount: provider.users.length,
itemBuilder: (context, index) {
final user = provider.users[index];
return ListTile(
leading: CircleAvatar(
backgroundImage: NetworkImage(user.image),
),
title: Text(user.name),
subtitle: Text(user.job),
onTap: () {
provider.selectUser(user);
Navigator.push(
context,
MaterialPageRoute(builder: (_) =>  UsersPage()),
);
},
);
},
),
);
}
}

