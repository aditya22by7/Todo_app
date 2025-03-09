import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget{
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({ Key? key,required this.todo,required this.onToDoChanged,required this.onDeleteItem }): super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: ListTile(
      onTap: (){
       // print('Clicked on ToDo Item' );

        onToDoChanged(todo);
      },


      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ) ,

      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      leading: Icon(
        todo.isDone? Icons.check_box :Icons.check_box_outline_blank,
        color: tdBlue,),
      tileColor: Color(0xff95eddd),

        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              decoration: todo.isDone? TextDecoration.lineThrough:null),
        ),
      
      trailing: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 12),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffb295ed)
        ),
        child: IconButton(

          color: Colors.white,
          iconSize: 18,

          onPressed: () {
            //print('Clicked on delete icon');

            onDeleteItem(todo.id);
          },

          icon: Icon(Icons.delete),

        )
        
      ),
      ),
  );
  }


}