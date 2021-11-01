import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Join extends StatefulWidget {
  const Join({ Key? key }) : super(key: key);

  @override
  State<Join> createState() => _JoinState();
}


class _JoinState extends State<Join> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child:Container(
              padding: EdgeInsets.all(20.0),
              width: size.width * 0.7,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Column(
                        children: [
                          Text(
                              "50.000Ar",
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)
                          ),
                          Text.rich(
                              TextSpan(
                                  text: '/ ',
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '3 mois',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                    )
                                  ]
                              )
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      )),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.check, size: 25),
                        ),
                        TextSpan(
                          text: " visite à domicile",
                          style: TextStyle(color: Colors.grey[900], fontSize:18),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.check, size: 25),
                        ),
                        TextSpan(
                          text: " réduction des frais",
                          style: TextStyle(color: Colors.grey[900], fontSize:18),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.check, size: 25),
                        ),
                        TextSpan(
                          text: " priorisé",
                          style: TextStyle(color: Colors.grey[900], fontSize:18),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          )
                      ),
                      child: Text('    Acheter     '),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}