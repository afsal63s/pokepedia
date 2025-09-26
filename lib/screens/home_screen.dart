
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pokepedia/screens/login_screen.dart';
import 'package:pokepedia/screens/pokemon_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  List pokepedia = [];
  bool isLoading = true;
  var pokepediaApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset("images/pokeball.png",width: 250,fit: BoxFit.fitHeight,
            )),
            Positioned(
              top: 100,
              left: 15,
              child: Text("Poke Pedia",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),)),
              Positioned(
                top: 30,
                right: 10,
                child: IconButton(onPressed: (){
                  showLogoutDialog(context);
              }, 
              icon: Icon(Icons.logout))),
            Positioned(
              top: 160,
              bottom: 0,
              width: width,
              child: Column(
                children: [
                  !isLoading ?
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4),
                        itemCount: pokepedia.length, 
                      itemBuilder: (context,index){
                          var type = pokepedia[index]['type'][0];
                          var color= typeColors[type];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetails(tag: index, pokedetails: pokepedia[index], color: color!)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: typeColors[type] ?? Colors.white,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                    children:[ 
                                      Positioned(
                                        bottom: -8,
                                        right: -8,
                                        child: Image.asset("images/pokeball.png",
                                        width: 100,
                                        fit: BoxFit.fitHeight,
                                        )),
                                        Positioned(
                                          top: 40,
                                          left: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 1 , bottom: 1, left: 8 ,right: 8),
                                              child: Text(type.toString(),style: TextStyle(
                                                color: Colors.white
                                              ),),
                                            ),
                                        )),
                                     Positioned(
                                      bottom: 0,
                                      right: 5,
                                      child: CachedNetworkImage(imageUrl: pokepedia[index]['img'],height: 100,fit: BoxFit.fill,
                                      )),
                                      Positioned(
                                          top: 13,
                                          left: 10,
                                          child: Text(pokepedia[index]['name'],style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),),),

                                  ]
                                ),
                              ),
                            ),
                          );
                      } ),
                  ):Center(
                      child: SpinKitDoubleBounce(
                        size: 40,
                        color: Colors.blueGrey,
                      ),
                    )
                ],
              )),
        ],
      )
    );
  }
  
  void fetchData() {
    var url = Uri.https("raw.githubusercontent.com","Biuni/PokemonGO-Pokedex/master/pokedex.json");
    print(url);
    http.get(url).then((value){
        if(value.statusCode==200){
          var data=jsonDecode(value.body);
          
          setState(() {
            pokepedia = data["pokemon"];
            isLoading=false;
          
          });
        }
        else{
          setState(() {
            isLoading=false;
          });
        }
    }).catchError((e){
      Fluttertoast.showToast(msg: "$e");
      setState(() {
        isLoading=false;
      });
    });
  }

  void showLogoutDialog(BuildContext context){
    showDialog(context: context, 
    builder: (BuildContext dialogContext){
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.pop(dialogContext);
          }, 
          child: Text("Cancel")),
          TextButton(onPressed: (){
            Fluttertoast.showToast(msg: "User Logged out!");
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
          }, child: Text("Log Out",
          style: TextStyle(
            color: Colors.red),)),
        ],
      );
    });
  }

  final Map<String, Color> typeColors = {
  "Normal": Colors.grey[400]!,
  "Fire": Colors.redAccent,
  "Water": Colors.blue,
  "Grass": Colors.greenAccent,
  "Electric": Colors.amber, 
  "Ice": Colors.lightBlue[200]!, 
  "Fighting": Colors.deepOrange[700]!, 
  "Poison": Colors.deepPurple,
  "Ground": Colors.brown[400]!, 
  "Flying": Colors.indigo[300]!, 
  "Psychic": Colors.pink, 
  "Bug": Colors.lightGreen[600]!, 
  "Rock": Colors.brown[700]!, 
  "Ghost": Colors.indigo, 
  "Dragon": Colors.indigo[900]!, 
  "Steel": Colors.blueGrey[400]!, 
  "Fairy": Colors.pink[200]!, 
  "Dark": Colors.grey[800]!, 
};
}