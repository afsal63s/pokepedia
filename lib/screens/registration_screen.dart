
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/login_screen.dart';
import 'package:pokepedia/widgets/button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formkey=GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool obscureText = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController.addListener((){
      setState(() {
        
      });
    });
    nameController.addListener((){
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 250,
                  child: Lottie.asset('animations/pikachu.json',
                  ),
                ),
              ),
              Text("Sign Up",style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
                fontFamily: 'Roboto'
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text("Use proper Information",style: TextStyle(
                  fontSize: 17,
                  color: Colors.greenAccent[200],
                  fontFamily: 'Roboto'
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 7, top: 25),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: "Name...",
                    hintStyle: TextStyle(color: Colors.black54,fontFamily: 'Roboto'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12,
                       
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(131, 95, 209, 154),
                        width: 2.6
                      )
                    ),
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: nameController.text.isEmpty ? Container(width: 0,)
                    : IconButton(onPressed: (){
                      nameController.clear();
                      }, icon: Icon(Icons.close)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 7, top: 10),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: "Email...",
                    hintStyle: TextStyle(color: Colors.black54,fontFamily: 'Roboto'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12,
                       
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(131, 95, 209, 154),
                        width: 2.6
                      )
                    ),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: emailController.text.isEmpty ? Container(width: 0,)
                    : IconButton(onPressed: (){
                      emailController.clear();
                      }, icon: Icon(Icons.close)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20 , top: 10, bottom: 17),
                child: TextFormField(
                  controller: passswordController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: obscureText,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText: "Password...",
                    hintStyle: TextStyle(color: Colors.black54,fontFamily: 'Roboto'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black26,
                       
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(131, 95, 209, 154),
                        width: 2.6
                      )
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: obscureText==true  ? IconButton(onPressed: (){
                        setState(() {
                          obscureText=false;
                        });
                    }, 
                    icon: Icon(Icons.visibility_off_outlined))
                    : IconButton(onPressed: (){
                      setState(() {
                        obscureText=true;
                      });
                    }, icon: Icon(Icons.visibility_outlined))
                    
                  ),
                ),
              ),
              SizedBox(height: 10,),
              LoadingAnimatedButton(child: Text("Register",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[1000],
                  fontFamily: 'Roboto'
              ),), onTap: (){
                    registerUser();
                    final form = formkey.currentState!;
                    String name = nameController.text;
                    String password = passswordController.text;
                    String email = emailController.text;
                    print("$email $password $name");
                    if(form.validate()){
                      final password = passswordController.text;
                      final email = emailController.text;
                    }
                }),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(
                    fontSize: 17,
                    color: Colors.greenAccent[200],
                    fontFamily: 'Roboto'
                  ),
                  ),
                  SizedBox(width: 8,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                    },
                    child: Text("Sign In",style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Roboto'
                  ),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(){
    if(emailController.text.trim().isEmpty || passswordController.text.trim().isEmpty || nameController.text.trim().isEmpty){
      Fluttertoast.showToast(msg: "Email, Password, Name can't be empty.",backgroundColor: Colors.blueAccent);
    }
    else{
      String email = emailController.text;
      String password = passswordController.text;
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          if(value!=null){
            var user = value.user;
            print(user);
            var uid = user!.uid;
             print(uid);
            addUserData(uid);
          }
      }).catchError((e){
        Fluttertoast.showToast(msg: "$e",backgroundColor: Colors.blueAccent);
      });
    }
  }

  void addUserData(String uid){
    Map<String,dynamic> userData={
      'name': nameController.text,
      'password': passswordController.text,
      'email': emailController.text,
      'uid': uid
    };
    FirebaseFirestore.instance.collection('users').doc(uid).set(userData).then((value){
        if(mounted){
          Fluttertoast.showToast(msg: "Registration Successful",backgroundColor: Colors.blue);
          Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_) => LoginScreen()));
        }
    }).catchError((e){
      Fluttertoast.showToast(msg: "$e",backgroundColor: Colors.blueAccent);
    });
  }
}