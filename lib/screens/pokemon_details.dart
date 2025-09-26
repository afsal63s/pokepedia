
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetails extends StatefulWidget {

  final tag;
  final pokedetails;
  final Color color;
  const PokemonDetails({super.key,required this.tag, required this.pokedetails, required this.color});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
          icon: Icon(Icons.arrow_back,
          color: Colors.white,
          size: 30,
          ))),
          Positioned(
            top: 90,
            left: 20,
            child: Text(widget.pokedetails['name'],style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30
            ),)),
            Positioned(
              top: 133,
              left: 25,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.black26
                ),
              child: Padding(
                padding: const EdgeInsets.only(top: 1 , bottom: 1, left: 8 ,right: 8),
                child: Text(widget.pokedetails['type'].join(', '),style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),),
              ),
            )),
            Positioned(
              right: -30,
              top: height * 0.2,
              child: Image.asset('images/pokeball.png',width: 200,fit: BoxFit.contain,
              )),
            Positioned(
              top: 130,
              left: (width/2)-115,
              child: CachedNetworkImage(imageUrl: widget.pokedetails['img'],
              height: 200,
              fit: BoxFit.fill,
              )),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35,),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Name",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500],
                            ),),
                            SizedBox(width: 80,),
                            Text(widget.pokedetails['name'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Height",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500]
                            ),),
                            SizedBox(width: 75,),
                            Text(widget.pokedetails['height'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Weight",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500]
                            ),),
                            SizedBox(width: 75,),
                            Text(widget.pokedetails['weight'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Spawn Time",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500]
                            ),),
                            SizedBox(width: 40,),
                            Text(widget.pokedetails['spawn_time'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Weakness",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500]
                            ),),
                            SizedBox(width: 55,),
                            Text(widget.pokedetails['weaknesses'].join(', '),style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text("Evolution",style: TextStyle(
                              fontSize: 17,
                              color: Colors.blueGrey[500]
                            ),),
                            SizedBox(width: 65,),
                            widget.pokedetails['next_evolution'] != null ?
                            SizedBox(
                              height: 30,
                              width: width * 0.5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.pokedetails['next_evolution'].length,
                                itemBuilder: (context,index){
                                  return Text("${widget.pokedetails['next_evolution'][index]['name']}, " ,style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),);
                              }),
                            )
                            :
                            Text("Maxed Out" ,style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}