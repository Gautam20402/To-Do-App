import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:to_do/screens/todo list.dart';
import 'package:to_do/todomodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/screens/loginpage.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final listtodo = todomodel.todolist();
  final todocontroller = TextEditingController();
  List<todomodel> foundtodo = [];

  @override
  void initState() {
    foundtodo = listtodo;
    super.initState();
  }

  void todochange(todomodel todo) {
    setState(() {
      todo.isdone = !todo.isdone;
    });
  }

  void deleteitem(String id) {
    setState(() {
      listtodo.removeWhere((item) => item.id == id);
    });
  }

  void addtodoitem(String todo) {
    setState(() {
      listtodo.add(todomodel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todotext: todo,
      ));
    });
    todocontroller.clear();
  }



  void filter(String keyword) {
    List<todomodel> result = [];
    if (keyword.isEmpty) {
      result = listtodo;
    } else {
      result = listtodo
          .where((item) =>
              item.todotext!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundtodo = result;
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: <Widget>[
            GFAvatar(
              backgroundImage: NetworkImage(
                  'https://news.thewindowsclub.com/wp-content/uploads/2020/03/Microsoft-To-Do-1200x1200.jpg'),
              radius: 22,
              backgroundColor: Colors.blueAccent,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                iconSize: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              logout();
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              size: 30,
                            ),
                            color: Colors.blueAccent,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                    ]),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                color: Colors.white60,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onChanged: (value) => filter(value),
                      controller: todocontroller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 20,
                          minWidth: 30,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin:EdgeInsets.only(bottom: 50),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "All ToDo's",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20,),
                          for (todomodel todoo in foundtodo.reversed)
                            todos(
                              todo: todoo,
                              ontodochange: todochange,
                              ondeleteitem: deleteitem,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 50,
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: todocontroller,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          hintText: '   Add New To-do Item',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        addtodoitem(todocontroller.text);
                      },
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        minimumSize: Size(40, 50),
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
