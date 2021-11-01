import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:flutter_map/src/layer/marker_layer.dart" as marker;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_back_php/services/etablissement.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_back_php/util/env.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin {
  Position? position;
  String selectedSearch = "";
  String _selectedItem = "";
  List dataSearch = [];
  Map tay = {};
  List data = [];
  List<marker.Marker> markers = [];
  List<Widget> results = [];
  MapController mapCtrl = MapController();
  final searchController = TextEditingController();
  List<String> choices = ["Medecin", "Pharmacie", "Cabinet", "Hopital"];
  bool isCabinet = false;
  String dropdownValue = 'One';
  ScrollController ctrl = ScrollController();
  String _selectedDate = '';
  DateTime dateTime = DateTime.now();
  TextEditingController noteController = TextEditingController();



  Map<String, double> pos = <String, double>{
    'latitude': -18.91368,
    'longitude': 47.53613
  };

  @override
  void initState(){
    super.initState();
  }

  void _animatedMapMove(latLng.LatLng destLocation, double destZoom) {

    final _latTween = Tween<double>(
        begin: mapCtrl.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapCtrl.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapCtrl.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    Animation<double> animation =
    CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapCtrl.move(
          latLng.LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }


  @override
  Widget build(BuildContext context) {

    tay = tay.isNotEmpty ? tay : ModalRoute.of(context)?.settings?.arguments as Map;
    data = tay['locations'];
    position = tay['position'];
    selectedSearch = tay['selected'];
    isCabinet = tay['isCabinet'];
    print('Init = $isCabinet');
    dataSearch = data.map((tagJson) => Etablissement.fromJson(tagJson)).toList();
    dataSearch.sort((a, b) => (Geolocator.distanceBetween(position!.latitude, position!.longitude, a.lat, a.lng)).compareTo(Geolocator.distanceBetween(position!.latitude, position!.longitude, b.lat, b.lng)));
    print(selectedSearch);
    return Scaffold(
      body:Stack(
          fit: StackFit.expand,
          children: <Widget> [FlutterMap(
            mapController: mapCtrl,
            options: MapOptions(
              center: latLng.LatLng(position!.latitude, position!.longitude),
              zoom: 15.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/ericko4manarivo/ckueaoc7i2xj918mqbdq2fbxz/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXJpY2tvNG1hbmFyaXZvIiwiYSI6ImNrdWUzMXZxazFkNzYycW14eGRheGp2NTAifQ.Xwo6M0h2_CqJlE0iKAXZdA",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoiZXJpY2tvNG1hbmFyaXZvIiwiYSI6ImNrdWUzMXZxazFkNzYycW14eGRheGp2NTAifQ.Xwo6M0h2_CqJlE0iKAXZdA',
                    'id': 'mapbox.mapbox-streets-v8'
                  },
                  subdomains: ["a", "b", "c"],
              ),
              MarkerLayerOptions(
                  markers: getMarkers(dataSearch)
              ),
            ],
          ),
            Positioned(
                child: FloatingActionButton(
                  onPressed: (){
                    _animatedMapMove(latLng.LatLng(position!.latitude, position!.longitude), 15);
                  },
                  child: Icon(Icons.navigation),
                ),
              right: 20,
              top: 50,
            ),
            Positioned(
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, '/accueil');
                },
                child: Icon(Icons.arrow_back),
              ),
              left: 20,
              top: 50,
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.1,
                maxChildSize: 0.5,
                builder: (context, ctrl) {
                  return Container(
                    color: Colors.white60,
                    child: SingleChildScrollView(
                      controller: ctrl,
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                                Icons.keyboard_arrow_up,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: kElevationToShadow[6]
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: TextField(
                                          controller: searchController,
                                          decoration: InputDecoration(
                                              hintText: 'Rechercher pharmacie, cabinet, service...',
                                              hintStyle: TextStyle(color: Colors.grey[500]),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(child: IconButton(
                                      onPressed: (){
                                        Navigator.popAndPushNamed(context, '/loadMap', arguments: {
                                          'searchText': searchController.text,
                                        });
                                      },
                                      icon: Icon(Icons.search),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              constraints: BoxConstraints.expand(height:50),
                              child: ListView.builder(
                                itemCount: choices.length,
                                padding: EdgeInsets.only(left: 20),
                                scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return radioSearch(choices[index], index);
                                  }
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              constraints: BoxConstraints.expand(height:200),
                              child: ListView.builder(
                                  // padding: EdgeInsets.only(left: 40),
                                  // scrollDirection: Axis.horizontal,
                                  // children: getResults(dataSearch)
                                itemCount: dataSearch.length,
                                padding: EdgeInsets.only(left: 30),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return getResultCard(dataSearch[index]);
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ]),
    );
  }
  void _showcontent(Etablissement e) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Prise de rendez-vous'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('Veuilez confirmer votre prise de rendez-vous'),
              ],
            ),
          ),
          actions: [
             Row(
               children: [
                 TextButton(
                   child: new Text('Chez le médecin'),
                   onPressed: () {
                     _createRdv(e, "medecin");
                   },
                 ),
                 TextButton(
                   child: new Text('A domicile'),
                   onPressed: () {
                     _createRdv(e, "domicile");
                   },
                 ),
                 TextButton(
                   child: new Text('Annuler'),
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                 ),
               ],
             ),
          ],
        );
      },
    );
  }

  Future _createRdv(Etablissement e, String type) async {
    String url = '${Env.server}/create.php';
    var uri = Uri.parse(url);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Votre demande a bien été prise en compte'), duration: const Duration(seconds: 1),));
    Navigator.pop(context);
    return await http.post(
      uri,
      body: {
        "idPatient": "patient-17",
        "idMedecin": e.id,
        "date": dateTime.toString(),
        "note": noteController.text,
        "type": type
      },
    );
  }
  void _onButtonPressed(Etablissement e) {
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: (isMedecin(e)) ? 300 : 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Center(
                    child: Text(
                        e.nom,
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                  ),
                  Text(e.adresse),
                  Text(e.mail),
                  (isMedecin(e)) ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'd MMM, yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: "Heure",
                      selectableDayPredicate: (DateTime val) => val.weekday == 5 || val.weekday == 6 ? false : true,
                      onChanged: (val){
                          print(val);
                          dateTime = DateTime.parse(val);
                          print(dateTime);
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ) : Container(),
                  (isMedecin(e)) ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 290,
                        child : TextField(
                            autocorrect: true,
                            controller: noteController,
                            decoration: InputDecoration(
                              hintText: 'Note',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            )
                        )
                    ),
                  ) : Container(),
                  Row(
                    mainAxisAlignment: (isMedecin(e)) ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Votre demande a bien été prise en compte'), duration: const Duration(seconds: 1),));
                          Navigator.pop(context);
                        },
                        child: Text('Contacter'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            onPrimary: Colors.white),
                      ),

                      (isMedecin(e)) ? ElevatedButton(
                        onPressed: (){
                          //_createRdv(e);
                          _showcontent(e);
                        },
                        child: Text('Prendre rendez-vous'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            onPrimary: Colors.white),
                      ) : Container(),
                    ],
                  ),

                ],
              ),
            ),
          );
        });
  }

  _selectItem(String s) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = s;
    });
  }

  List<Widget> getResults(List datass) {
    for(int  i = 0; i < datass.length; i++){
      results.add(getResultCard(datass[i]));
    }
    return results;
  }

  List<marker.Marker> getMarkers(List datass) {
    markers.add(marker.Marker(
        width: 80.0,
        height: 80.0,
        point: latLng.LatLng(position!.latitude, position!.longitude),
        builder: (ctx) =>
            IconButton(
              icon: Icon(FontAwesomeIcons.mapMarkerAlt),
              color: Colors.black,
              iconSize: 45.0,
              onPressed: (){
              },
            ),
    ));
    for(int  i = 0; i < datass.length; i++){
      markers.add(getMarker(datass[i]));
    }
    return markers;
  }

  marker.Marker getMarker(Etablissement e){
    return marker.Marker(
      width: 80.0,
      height: 80.0,
      point: latLng.LatLng(e.lat, e.lng),
      builder: (ctx) =>
          IconButton(
            icon: Icon(FontAwesomeIcons.mapMarkerAlt),
            color: (e.type == "pharmacie") ? Colors.green : (e.type == "cabinet") ? Colors.pink : (e.type == "hopital") ? Colors.red : Colors.lightBlueAccent,
            iconSize: 45.0,
            onPressed: (){
              _onButtonPressed(e);
            },
          ),
    );
  }

  Widget radioSearch(String text, int index){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: OutlinedButton(
        onPressed: (){
          setState(() {
            if(selectedSearch == text){
              selectedSearch = text;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('tous'), duration: Duration(seconds: 1),));
              Navigator.popAndPushNamed(context, '/loadMap', arguments: {
                'search': '',
                'isCabinet': false
              });
            }
            else{
              selectedSearch = text;
              print(isThisCabinet(text));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Voici la liste des $text pres de chez vous'), duration: Duration(seconds: 1)));
              Navigator.popAndPushNamed(context, '/loadMap', arguments: {
                'search': selectedSearch,
                'isCabinet': isThisCabinet(text)
              });
            }

          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: (selectedSearch == text) ? Colors.green : Colors.blueGrey,
          onPrimary: (selectedSearch == text) ? Colors.blueGrey : Colors.green,
        ),
      ),
    );
  }
  
  bool isThisCabinet(String text){
    bool valiny = false;
    valiny = (text == "Cabinet") ? true : (text == "Hopital") ? true : false;
    return valiny;
  }

  Widget getResultCard(Etablissement e) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: (e.type == "pharmacie") ? NetworkImage('https://img2.freepng.fr/20180320/zoq/kisspng-pharmacy-symbol-medical-prescription-clip-art-land-cliparts-5ab175341ad9b5.22803317152157931611.jpg') : (e.type == "cabinet") ? NetworkImage('https://img2.freepng.fr/20180705/rwq/kisspng-logo-cross-red-hospital-medical-office-5b3db923b667f6.3943560215307717477472.jpg') : (e.type == "medecin")  ? NetworkImage('https://cdn.icon-icons.com/icons2/1035/PNG/256/doctor_icon-icons.com_76230.png'): NetworkImage('https://www.iconsdb.com/icons/preview/red/hospital-xxl.png'),
              ),
              Flexible(
                child: Text(
                  e.nom,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      _animatedMapMove(latLng.LatLng(e.lat, e.lng), 15);
                    });
                  },
                  child: Text(
                    'Voir'
                  ),
              ),
            ],
          ),
          Text(e.adresse),
          Text(e.mail)
        ],
      ),
    );
  }

  bool isMedecin(Etablissement e){
    if(e.type == "medecin"){
      return true;
    }
    return false;
  }


  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }
}