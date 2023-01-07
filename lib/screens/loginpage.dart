import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/screens/createaccount.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/screens/homescreen.dart';


class loginpage extends StatefulWidget {

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController controlemail = TextEditingController();
  TextEditingController controlpass = TextEditingController();
  final _formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.lightBlueAccent,
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height:150),
                  SizedBox(
                    height: 130,
                    child: Image.network('https://to-do-cdn.microsoft.com/static-assets/c87265a87f887380a04cf21925a56539b29364b51ae53e089c3ee2b2180148c6/icons/logo.png' ,
                      fit: BoxFit.contain,),
                  ),
                  Container(height: 50,),
                  TextFormField(
                    autofocus: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return ('Please Enter your Email');
                      }if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                        return ("Please Enter Valid Email");
                      }
                    },
                    onSaved: (value){
                      controlemail.text = value! ;

                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: controlemail ,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                      labelStyle: TextStyle(fontSize: 20),
                     prefixIcon: Icon(Icons.mail_outline_rounded),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(15),
                     ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    controller: controlpass ,
                    obscureText: true,
                    validator: (value){
                      RegExp reg = new RegExp(r'^.{6,}$');
                      if(value!.isEmpty){
                        return('Please Enter your password');
                      }if(!reg.hasMatch(value)){
                        return('Enter valid password(Min. 6 characters)');
                      }
                    } ,
                    onSaved: (value){
                      controlpass.text = value! ;

                    },
                    decoration: InputDecoration(
                        labelText: 'Password' ,
                      hintText: 'Enter your password',
                      labelStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.key_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Container(height: 50,),
                  Material(
                    color: Colors.blueAccent,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      minWidth: 270,
                        onPressed:() {
                          loginuser(controlemail.text,controlpass.text);
                          print('user login');
                        },
                        child: Text(
                          'Login' , textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 21 , color: Colors.black87,
                          fontWeight: FontWeight.bold)
                        ),
                    ),
                  ),
                  Container(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>createaccount()
                          )
                          );
                        },
                        child: Text('Create account',
                        style: TextStyle(
                            fontSize: 15 , fontWeight: FontWeight.bold ,
                          color: Colors.blueAccent
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loginuser(String email , String password)async{
    _formkey.currentState!.validate();
    if(_formkey.currentState!.validate()){
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: 'Login Succesful'),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder:(context)=>home())
        )
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

}



