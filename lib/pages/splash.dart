import 'package:flutter/material.dart';
import 'package:flutter_back_php/pages/container.dart';


class Splash extends StatefulWidget {
	const Splash({ Key? key }) : super(key: key);

	@override
	State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  _navigate()async{
    await Future.delayed(Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }

	@override
	Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/nobg.png',
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      );
	}
}