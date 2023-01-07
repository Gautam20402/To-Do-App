import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/screens/homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/usermodel.dart';

class createaccount extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return createaccountstate();
  }
}


class createaccountstate extends State<createaccount> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController controlemail = TextEditingController();
  TextEditingController controlpass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController sername = TextEditingController();
  TextEditingController confirmpass = TextEditingController();


  Future<void> createuser(String email ,String password)async{

     if (_formkey.currentState!.validate()){
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((value)=>{
          postDetailstofirestore(),
        }).catchError((e){
          Fluttertoast.showToast(msg:e!.message);
        });

     }
  }

  postDetailstofirestore()async{
    FirebaseFirestore firebaseFirestore =
        FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    Usermodel  usermodel =Usermodel();

    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.firstname = name.text;
    usermodel.secondname = sername.text;


    await firebaseFirestore
      .collection('users')
      .doc(user.uid)
      .set(usermodel.toMap());

    Fluttertoast.showToast(msg: 'Account created successfully');

    Navigator.pushAndRemoveUntil(
        (context), MaterialPageRoute(
        builder: (context)=>home()),
        (route)=>false

    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            } ,
            icon: Icon(Icons.arrow_back_rounded) ,
          color: Colors.blueAccent,)
      ),
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
                  Container(height:85),
                  SizedBox(
                    height: 130,
                    child: Image.network('https://to-do-cdn.microsoft.com/static-assets/c87265a87f887380a04cf21925a56539b29364b51ae53e089c3ee2b2180148c6/icons/logo.png' ,
                      fit: BoxFit.contain,),
                  ),
                  Container(height: 30,),
                  TextFormField(
                    autofocus: false,
                    validator: (value){
                      RegExp reg = new RegExp(r'^.{3,}$');
                      if(value!.isEmpty){
                        return('first name can not be empty');
                      }if(!reg.hasMatch(value)){
                        return('Enter valid name(Min. 3 characters)');
                      }
                      return null;
                    } ,
                    onSaved: (value){
                      name.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    controller: name ,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'First Name',
                      labelStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.account_circle_outlined),
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
                    validator: (value){
                      if(value!.isEmpty){
                        return('first name can not be empty');
                      }
                      return null;
                    } ,
                    onSaved: (value){
                      sername.text = value!;
                    },
                    controller: sername,
                    decoration: InputDecoration(
                      labelText: 'Second Name',
                      hintText: 'Second Name',
                      labelStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.account_circle_outlined),
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
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return ('Please Enter your Email');
                      }if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                        return ("Please Enter Valid Email");
                      }
                      return null;
                    },
                    onSaved: (value){
                      controlemail.text = value! ;
                      _formkey.currentState!.validate();

                    },
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
                      _formkey.currentState!.validate();

                    },
                    obscureText: true,
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
                  Container(height: 20,),
                  TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    controller: confirmpass ,
                    validator: (value){
                      if(confirmpass.text.length != controlpass.text.length){
                        return 'Password do not match';
                      }
                      return null;
                    },
                    onSaved: (value){
                      confirmpass.text = value! ;
                      _formkey.currentState!.validate();

                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password' ,
                      hintText: 'Re-Enter your Password',
                      labelStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.key_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Container(height: 30,),
                  Material(
                    color: Colors.blueAccent,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      minWidth: 270,
                      onPressed:(){
                        createuser(controlemail.text,controlpass.text);
                      },
                      child: Text(
                          'Create account' , textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 21 , color: Colors.black87,
                              fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
              ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
