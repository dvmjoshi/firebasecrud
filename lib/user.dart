import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String description;
  String nickname;
  String imageurl;
  String power;
  DocumentReference reference;

  User({this.name,this.description,this.reference,
    this.nickname,this.imageurl,this.power});
  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["name"];
    description=map["description"];
    nickname=map["nickname"];
    imageurl=map["imageurl"];
    power =map["power"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {'name': name,'description':description,'imageurl'
        :imageurl,'nickname':nickname,"power":power};
  }
}