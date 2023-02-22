import 'package:flutter/material.dart';

import '../constants/colors.dart';

// The stateful widget that manages the to-do list
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

// The state of the to-do list
class _TodoListState extends State<TodoList> {
  // The list of to-do items
  List<TodoItem> _todoItems = [];

  // Adds a to-do item to the list
  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() => _todoItems.add(TodoItem(task: task)));
    }
  }

  // Removes a to-do item from the list
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Prompts the user to confirm that they want to remove a to-do item
  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete "${_todoItems[index].task}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('DELETE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Marks a to-do item as complete
  void _markTodoItemComplete(int index) {
    setState(() {
      _todoItems[index].isComplete = true;
    });
  }

  // Builds the list of to-do items
  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Builds a single to-do item
  Widget _buildTodoItem(TodoItem todoItem, int index) {
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.black,
        activeColor: Colors.red,
        value: todoItem.isComplete,
        onChanged: (value) {
          _markTodoItemComplete(index);
        },
      ),
      title: Text(
        todoItem.task,
        style: TextStyle(
          color: Colors.white,
          // Crosses out the text of a completed to-do item
          decoration: todoItem.isComplete ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
        onPressed: () {
          _promptRemoveTodoItem(index);
        },
      ),
    );
  }

// Builds the UI of the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBlue,
      appBar: AppBar(
        backgroundColor: tdRed,
        title: const Text('Todo Application'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }

// Displays a new screen with a text field for the user to enter a new To-Do item
  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            backgroundColor: tdBlue,
            appBar: AppBar(
              backgroundColor: tdRed,
              title: const Text('Add a new task'),
            ),
            body: TextField(
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              onSubmitted: (val) {
                // Calls the _addTodoItem() function to add the new item to the list
                _addTodoItem(val);
                // Pops the current screen and returns to the previous screen
                Navigator.pop(context);
              },
              decoration: const InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: EdgeInsets.all(16.0),
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Defines the TodoItem class with a task and a boolean to determine if the item is complete
class TodoItem {
  final String task;
  bool isComplete;

  TodoItem({required this.task, this.isComplete = false});
}
