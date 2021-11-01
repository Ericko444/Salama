import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:flutter_map/src/layer/marker_layer.dart" as marker;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_back_php/services/etablissement.dart';
import 'package:flutter_back_php/pages/home.dart';
import 'package:flutter_back_php/pages/loading.dart';
import 'package:flutter_back_php/pages/search_speciality.dart';
import 'package:flutter_back_php/pages/splash.dart';
import 'package:flutter_back_php/pages/container.dart';
import 'package:flutter_back_php/pages/join.dart';


void main() {
  runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/home': (context) => MyHomePage(),
          '/loadMap': (context) => Loading(),
          '/accueil': (context) => Home(),
          '/search':(context) => ChooseSpeciality(),
          '/join':(context) => Join(),
        },
      ));
}




