class Etablissement{

  late String id;
  late String nom;
  late String adresse;
  late double lat;
  late double lng;
  late String mail;
  late String type;

  Etablissement({required this.id, required this.nom, required this.adresse, required this.lat, required this.lng, required this.mail, required this.type});

  factory Etablissement.fromJson(dynamic json){
    return Etablissement(id: json['idEtablissement'] as String, nom: json['nom'] as String, adresse: json['adresse'] as String, lat: double.parse(json['latitude']), lng: double.parse(json['longitude']), mail: json['mail'] as String, type: json['type'] as String);
  }

  @override
  String toString(){
    return "$nom a $adresse a ($lat,$lng)";
  }

}