import 'package:flutter/material.dart';
import 'package:flutter_back_php/services/speciality.dart';
import 'package:flutter_back_php/services/medecin.dart';

class ChooseSpeciality extends StatefulWidget {
  const ChooseSpeciality({Key? key}) : super(key: key);

  @override
  _ChooseSpecialityState createState() => _ChooseSpecialityState();
}

class _ChooseSpecialityState extends State<ChooseSpeciality> {
  bool isSearching = false;
  final searchController = TextEditingController();
  List<Speciality> specialities = [
    Speciality(id: 1, nom: 'Dermatologie', img: 'dermatologie.png'),
    Speciality(id: 2, nom: 'Pédiatrie', img: 'pediatrie.png'),
    Speciality(id: 3, nom: 'Ophtalmologie', img: 'ophtalmo.png'),
  ];
  List<Speciality> filtered = [];
  List<Medecin> toSend = [];

  @override
  void initState(){
    setState((){
      filtered = specialities;
    });
    super.initState();
  }

  void filterData(value){
    setState((){
      filtered = specialities.where((element) => element.nom.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text('Choix Spécialité'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(child: isSearching ? IconButton(
                      onPressed: (){
                        setState((){
                          isSearching = false;
                          searchController.clear();
                          filtered = specialities;
                        });
                      },
                      icon: Icon(Icons.cancel)
                    ) : IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.search)
                      )
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Rechercher service',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: InputBorder.none
                          ),
                          onTap: (){
                            setState((){
                              isSearching = true;
                            });
                          },
                          onChanged: (value){
                            filterData(value);
                            setState(() {
                              isSearching = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Les spécialités les plus populaires',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Flexible(
                child: ListView.builder(
                    itemCount: filtered.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              if(filtered[index].nom == "Dermatologie"){
                                toSend = [
                                  Medecin(id: 1, nom: 'Docteur Jack', statut: 'Consultant Dermatologue', adresse: 'Rue 101 Raseta'),
                                  Medecin(id: 2, nom: 'Docteur Charlene', statut: 'Dermatologue specialiste', adresse: 'Rue 101 Rasalama'),
                                  Medecin(id: 3, nom: 'Docteur Hasinjara', statut: 'Dermatologue estheticien', adresse: 'Rue 101 Ravoahangy'),
                                ];


                              }
                            },
                            title: Text(filtered[index].nom),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/${filtered[index].img}'),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
