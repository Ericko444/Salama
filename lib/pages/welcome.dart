import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {


  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home.jpg'),
                    fit: BoxFit.cover
                ),
              ),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors:[
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.2),
                          ]
                      )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        Text("Que recherchez-vous?", textAlign:TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                              hintText: "Trouver des spécialistes",
                            ),
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              Navigator.pushNamed(context, '/search');
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ]
                  )
              )
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nos services", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 20),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/loadMap');
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: 100,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // child: Image.network(
                      //   'https://placeimg.com/640/480/any',
                      //   fit: BoxFit.fill,
                      // ),
                      child: Center(child: Text('Près de chez vous', style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/join');
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: 100,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // child: Image.network(
                      //   'https://placeimg.com/640/480/any',
                      //   fit: BoxFit.fill,
                      // ),
                      child: Center(child: Text('Nous rejoindre', style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}