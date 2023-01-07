
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/screens/homescreen.dart';
import 'dart:async';
import 'package:getwidget/getwidget.dart';
import 'package:to_do/screens/loginpage.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myapp());
}

class splashscreen extends StatefulWidget {  @override
State<StatefulWidget> createState() {
  return splashscreenstate();
}
}

class splashscreenstate extends State<splashscreen> {

  late StreamSubscription<User?> user;
  @override
  void initState() {

    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        const snackBar =
        SnackBar(content: Text('User is currently signed out!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text('User is signed in!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>FirebaseAuth.instance.currentUser == null
              ?  loginpage()
              :  home()
      ));
    });

    super.initState();
  }
  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }


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
          child: Center(
            child: Column(
              children: [
                Container(height: 210,),
                GFAvatar(backgroundImage:
                NetworkImage('https://news.thewindowsclub.com/wp-content/uploads/2020/03/Microsoft-To-Do-1200x1200.jpg'),
                  radius: 80,backgroundColor: Colors.blueAccent,),
                Container(height: 10,),
                Text('TO-DO', style: TextStyle(
                    fontWeight: FontWeight.bold , fontSize: 30 ,
                    color: Colors.black
                ),),
                Container(height: 280,),
                CircularProgressIndicator(color: Colors.blue,)
              ],
            ),
          ),
        )
    );
  }
}



class myapp extends StatefulWidget {
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {


      @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent)
        );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: splashscreen(),
    );
      }

}
