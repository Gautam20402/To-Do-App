

class todomodel{
  String? id;
  String? todotext;
  bool isdone;

  todomodel({
    required this.id, required this.todotext,
   this.isdone = false,
});

  static List<todomodel> todolist(){
    return[
      todomodel(id: '01', todotext: 'Sample To-Do Item: 1', isdone: true),
      todomodel(id: '02', todotext: 'Sample To-Do Item: 2', isdone: true),
      todomodel(id: '03', todotext: 'Sample To-Do Item: 3', ),
      todomodel(id: '04', todotext: 'Sample To-Do Item: 4',),
      todomodel(id: '05', todotext: 'Sample To-Do Item: 5', ),
    ];
  }

}



