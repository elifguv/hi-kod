import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)),
          home: ListTasksUIWidget()),
    );
  }
}

class ListTasksUIWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskListObject = Provider.of<TaskList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do List"),
      ),
      body: ListView.builder(
        itemCount: taskListObject.tasks.length,
        itemBuilder: (context, index) {
          var task = taskListObject.tasks[index];
          return Dismissible(
            key: Key(task.name), // Provide a unique key for each task
            background: Container(
              color: Colors.red, // Background color when swiping
            ),
            onDismissed: (direction) {
              // Remove the task when swiped
              taskListObject.removeTask(task);
            },
            child: CardWidget(task: task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  Task task;

  CardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final dateRange =
        '${task.start_date} - ${task.end_date}'; // Combine start and end dates
    return Card(
      child: ListTile(
        leading: const Icon(Icons.task_alt_sharp),
        title: Text(task.name),
        subtitle: Text(task.description),
        trailing: Text(dateRange),
      ),
    );
  }
}

class Task {
  final String id; // Unique identifier
  String name;
  String description;
  String start_date;
  String end_date;

  //Constructor
  Task(this.id, this.name, this.description, this.start_date, this.end_date);
}

class TaskList with ChangeNotifier {
  List<Task> tasks = [
    Task('1', 'Differential Equations', 'Integral', '14.10.23', '15.10.23'),
    Task('2', 'Logic Circuit', 'Logic Gates', '15.10.23', '16.10.23'),
    Task('3', 'Flutter', 'API', '15.10.23', '16.10.23'),
    Task('4', 'Discrete Mathematics', 'Logical Operators', '14.10.23',
        '15.10.23'),
  ];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }
}

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startingController = TextEditingController();
  TextEditingController endingController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var taskListObject = Provider.of<TaskList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Task Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            TextField(
              controller: startingController,
              decoration: const InputDecoration(hintText: "Start Date"),
            ),
            TextField(
              controller: endingController,
              decoration: const InputDecoration(hintText: "End Date"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  var newTask = Task(
                      idController.text,
                      nameController.text,
                      descriptionController.text,
                      startingController.text,
                      endingController.text);
                  taskListObject.addTask(newTask);
                  Navigator.pop(context);
                },
                child: const Text("Save the changes"))
          ],
        ),
      ),
    );
  }
}
