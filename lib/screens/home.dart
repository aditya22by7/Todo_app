import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../model/todo.dart';
import '../widgets/todo_items.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();

  List<ToDo> _foundToDo = [];

  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(backgroundColor: Colors.cyanAccent,
        child: ListView(
            children: [
              Container(height: 200,
                width: 200,
                color: Colors.indigoAccent,

                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatarimage.jpg'),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Favourite'),
                ),
                leading: Icon(Icons.favorite),
                onTap: () {},
              ),
              Divider(thickness: 3,
              color: Colors.blue,),
              ListTile(
                leading: Icon(Icons.person),
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Friends'),
                ),
                onTap: () {},
              ),
              Divider(thickness: 3,
              color: Colors.blue,),
              ListTile(
                leading: Icon(Icons.settings),
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Settings'),
                ),
                
              ),
              Divider(thickness: 3,
              color: Colors.blue,),
              ListTile(
                leading: Icon(Icons.notifications)
                ,title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Notifications'),
                ),
              ),
              Divider(thickness: 3,
              color: Colors.blue,),
              ListTile(
                leading: Icon(Icons.policy),
                title: Padding(
                  padding: const EdgeInsets.all(20.0),                  child: Text('Policy'),
                ),
              ),
              Divider(thickness: 3,
              color: Colors.blue,)
            ]

        ),
      ),
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),

                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff74ebd5), Color(0xff9face6)]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_todoController.text.isNotEmpty) {
                            setState(() {
                              _todoController.text.toString();
                              // Clear the text field after adding
                            });
                          } else if (_todoController.text.isEmpty) {
                            setState(() {
                              _todoController.text =
                                  'PLEASE ADD SOMETHING HERE';
                            });
                          }

                          _addToDoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          minimumSize: Size(60, 60),
                          backgroundColor: Color(0xffc495ed),
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black87,
                          ),
                        )),
                  )
                ],
              ),
            )
          ],

        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword) {
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0.0, 0.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
          ],
          gradient:
              LinearGradient(colors: [Color(0xff9795f0), Color(0xfffbc8d4)]),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black87,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.deepPurple),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff30cfd0),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            'ToDo',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatarimage.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
