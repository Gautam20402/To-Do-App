import 'package:flutter/material.dart';
import 'package:to_do/todomodel.dart';


class todos extends StatelessWidget {

  final todomodel todo;
  final ontodochange;
  final ondeleteitem;

  const  todos ({Key? key,
    required this.todo ,
    required this.ontodochange ,
    required this.ondeleteitem}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

  return Container(
    margin: EdgeInsets.only(bottom:20 ),
    child: ListTile(
      onTap: (){
        ontodochange(todo);
      },
      shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      tileColor: Colors.grey[350],
      leading: Icon(todo.isdone? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, color: Colors.blue,),
      title: Text(todo.todotext!,
      style: TextStyle(
        fontSize: 20 ,
        color: Colors.black,
        decoration: todo.isdone? TextDecoration.lineThrough: null,
      ),),
      trailing: Container(
        padding: EdgeInsets.symmetric(vertical:0),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20)
        ),
        child:  IconButton(
            onPressed: (){
              ondeleteitem(todo.id);
            },
            icon: Icon(Icons.delete_rounded),
          iconSize: 25,
          color: Colors.white,
        )
      ),
    ),
  );

  }
}
