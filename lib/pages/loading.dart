import 'package:flutter/material.dart';
import 'package:flutter_back_php/services/etablissement.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_back_php/util/env.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String url = '';
  Map search = {};
  Map searchText = {};
  Map isCabinet = {};

  void getData() async {
      String param = search.isNotEmpty ? search['search'] : "";
      String paramText = searchText.isNotEmpty ? searchText['searchText'] : "";
      bool cab = search.isNotEmpty ? search['isCabinet'] : false;
      print('Cab:{${search['isCabinet']}');

      url = '${Env.server}/get.php?type=$param&text=$paramText';
      print(url);
      var uri = Uri.parse(url);
      http.Response response = await http.get(uri);
      var position = await _determinePosition();
      var data = jsonDecode(response.body) as List;
      Navigator.popAndPushNamed(context, '/home', arguments: {
        'locations': data,
        'position' : position,
        'selected' : param,
        'isCabinet' : cab
      });
    }

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    }

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)?.settings?.arguments != null){
      Map content = ModalRoute.of(context)?.settings?.arguments as Map;
      if(content['search'] != null) {
        search = search.isNotEmpty ? search : ModalRoute.of(context)?.settings?.arguments as Map;
      }
      else if(content['searchText'] != null){
        searchText = searchText.isNotEmpty ? searchText : ModalRoute.of(context)?.settings?.arguments as Map;
      }
    }


    getData();
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
