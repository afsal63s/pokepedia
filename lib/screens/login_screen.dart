
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/home_screen.dart';
import 'package:pokepedia/screens/registration_screen.dart';
import 'package:pokepedia/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey= GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passswordController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener((){
      setState(() {

      });
      passswordController.addListener((){
        listener:(context);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.removeListener((){listener:(context);});
    passswordController.removeListener((){listener:(context);});
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
                  height: 300,
                  child: Lottie.asset('animations/bulb.json',
                  ),
                ),
              ),
              Text("Sign In",style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
                fontFamily: 'Roboto'
              ),
              ),
              Text("Enter your email & password",style: TextStyle(
                fontSize: 17,
                color: Colors.greenAccent[200],
                fontFamily: 'Roboto'
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 13, top: 25),
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
              LoadingAnimatedButton(child: Text("Login",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[1000],
                  fontFamily: 'Roboto'
              ),), onTap: (){
                print("Button pressed");
                loginUser();
                final form = formkey.currentState!;
                String email=emailController.text;
                String password=passswordController.text;
                print("$email mail");
                print("$password pass");
                if(form.validate()){
                  final email = emailController.text;
                  final password = passswordController.text;
                }
              }),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(
                    fontSize: 17,
                    color: Colors.greenAccent[200],
                    fontFamily: 'Roboto'
                  ),
                  ),
                  SizedBox(width: 8,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrationScreen()));
                    },
                    child: Text("Sign Up",style: TextStyle(
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

  void loginUser(){
        if(passswordController.text.trim().isEmpty || emailController.text.trim().isEmpty){
          Fluttertoast.showToast(msg: "Email or Password cannot be blank",backgroundColor: Colors.blueAccent);
        }
        else{
          String email = emailController.text;
          String password = passswordController.text;
          FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
            if(mounted){
              Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_) => HomeScreen()));
            }
          }).catchError((e){
            Fluttertoast.showToast(msg: '$e',backgroundColor: Colors.blueAccent);
          });
        }
    }

}