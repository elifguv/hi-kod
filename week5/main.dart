import 'package:flutter/material.dart';
import 'dart:math';

//import 'homepage.dart';
//import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileInfo()));
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                'Welcome to the Schedule App!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/pinterest.jpg',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 50,
            color: Colors.deepOrange,
            child: const Center(
              child: Text(
                'See your schedule for this week:',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  // Use the index to generate the day of the week dynamically
                  final dayOfWeek = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ][index];
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(day: '$dayOfWeek')));
                      },
                      title: Text(dayOfWeek),
                      leading: const Icon(Icons.calendar_month),
                      trailing: const Icon(Icons.arrow_forward_ios));
                },
                itemCount: 7, //Number of days in a week
                separatorBuilder: (context, index) {
                  return Divider(); // Divider widget to separate list items
                },
                shrinkWrap: true),
          )
        ]),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String day;
  final List<String> tasks = [
    'Task 1',
    'Task 2',
    'Task 3',
  ];

  DetailsPage({required this.day});

  @override
  Widget build(BuildContext context) {
    List<String> randomTasks = [];

    //Generate random tasks for the day
    for (int i = 0; i < tasks.length; i++) {
      if (Random().nextBool()) {
        randomTasks.add(tasks[i]);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Details for $day'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Tasks for $day:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (String task in randomTasks)
              Text(
                '- $task',
                style: const TextStyle(fontSize: 16),
              ),
          ]),
        ));
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitchedTheme = false;
  bool _isSwitchedNotification = false;

  //Inıtıal selected value
  String dropdownValue = 'Daily';

  //List of items in the dropdown menu
  var items = ['Never', 'Daily', 'Weekly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                'Theme Settings',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Switch(
                value: _isSwitchedTheme,
                onChanged: (newValue) {
                  setState(() {
                    _isSwitchedTheme = newValue;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Enable Notifications',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Switch(
                value: _isSwitchedNotification,
                onChanged: (newValue) {
                  setState(() {
                    _isSwitchedNotification = newValue;
                  });
                },
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 24.0), // Add left padding
            child: Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
          ),
          Divider(),
        ]),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Info"),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0), // Add left padding
                child: Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name:  Elend Venture'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email:  elend@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location:  Luthadel, The Final Empire'),
            ),
          ],
        ),
      ),
    );
  }
}
