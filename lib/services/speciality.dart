import 'package:sqflite/sqflite.dart';

class Speciality{
  late int id;
  late String nom;
  late String img;

  Speciality({required this.id, required this.nom, required this.img});
  factory Speciality.fromMap(Map data){
    return Speciality(id: data['id'], nom: data['nom'], img: data['img']);
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id" : id,
      "nom" : nom,
      "img" : img,
    };
  }
}