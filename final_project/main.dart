import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'homepage.dart';
//import 'itemlist.dart';
//import 'profile_info.dart';
//import 'settings.dart';
//import 'user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // Wrap your app with ChangeNotifierProvider
      create: (context) => ItemList(), // Provide an instance of ItemList
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileInfo(),
        '/settings': (context) => SettingsPage(),
        '/addItem': (context) => ItemListPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> climateProblemsInTurkey = [
    {
      'problem': 'Göllerde Su Kıtlığı',
      'explanation': 'Göllerde ve barajlarda su kaynaklarının tükenmesi.',
    },
    {
      'problem': 'Tarımsal Bölgelerde Kuraklık',
      'explanation': 'Tarımsal bölgelerini etkileyen uzun kurak dönemler.',
    },
    {
      'problem': 'Ormanlarda İzinsiz Ağaç Kesimi',
      'explanation': ' İzinsiz ağaç kesimi ve kentleşme nedeniyle orman kaybı.',
    },
    {
      'problem': 'Büyük Şehirlerde Hava Kirliliği',
      'explanation':
          'Türkiye\'nin büyük şehirlerinde yüksek hava kirliliği seviyeleri ve hava kalitesinin düşmesi.',
    },
    {
      'problem': 'Kıyı Alanlarında Erozyon',
      'explanation':
          'Kıyı bölgilerini etkileyen erozyon ve deniz seviyesi yükselmesi.',
    },
    {
      'problem': 'Ekosistemlerde Biyoçeşitliliğin Kaybı',
      'explanation':
          'Ekosistemlerde bitki ve hayvan türlerinin çeşitliliğinde azalma.',
    },
    {
      'problem': 'Akdeniz Bölgesi Orman Yangınları',
      'explanation': 'Akdeniz bölgesinde orman yangınlarının artan sıklığı.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/kodluyoruz.jpg',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Container(
            width: 350,
            height: 50,
            color: Colors.deepOrange,
            child: const Center(
              child: Text(
                'İklimden Haberler',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: climateProblemsInTurkey.length,
              itemBuilder: (context, index) {
                final problem = climateProblemsInTurkey[index]['problem'];
                final explanation =
                    climateProblemsInTurkey[index]['explanation'];

                return ListTile(
                  title: Text(problem ?? 'Unknown'),
                  subtitle: Text(explanation ?? ''),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(), // Add a divider between items
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
              context, '/addItem'); // Navigate to the "AddItem" page
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üye Girişi'),
        backgroundColor: Colors.deepOrange,
      ),
      body: const InputWidgetDemo(),
    );
    //debugShowCheckedModeBanner: false,
  }
}

class InputWidgetDemo extends StatefulWidget {
  const InputWidgetDemo();

  @override
  State<InputWidgetDemo> createState() => _InputWidgetDemoState();
}

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _InputWidgetDemoState extends State<InputWidgetDemo> {
  int counter = 0;

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void decreaseCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16.0),
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  hintText: "İsminizi giriniz",
                  labelText: "Kullanıcı İsmi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email adresinizi giriniz",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () {
                    showUserDetailsDialog(context);
                  },
                  child: const Text('Profil Bilgileri'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  )),
              SizedBox(height: 50),
              const Text("Gün sonunda kaç haber okudunuz? ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    //color: Colors.deepOrange,
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        increaseCounter();
                      },
                      child: const Text("Bilgilendim")),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        decreaseCounter();
                      },
                      child: const Text("Bilgilenemedim")),
                ],
              ),
              const SizedBox(height: 20),
              Text('Okuduğunuz haber sayısı: $counter'),
            ]));
  }
}

void showUserDetailsDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profil Bilgileri'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, //Changes where the text begins in the dialog
            mainAxisSize: MainAxisSize.min, //Changes the size of the dialog
            children: [
              Text('Kullanıcı İsmi: ${userNameController.text}'),
              Text('Email: ${emailController.text}'),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange),
                ))
          ],
        );
      });
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkThemeEnabled = false;
  String selectedLanguage = 'Türkçe';
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uygulama Ayarları'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Karanlık Tema'),
              trailing: Switch(
                value: darkThemeEnabled,
                onChanged: (value) {
                  setState(() {
                    darkThemeEnabled = value;
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Dil'),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: <String>['English', 'Türkçe', 'Français', 'Deutsch']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Bildirimler'),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog for user questions
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Bir sorunuz mu var?'),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Sorunuz/Geri bildiriminiz',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        // Handle user question submission
                        Navigator.of(context).pop();
                      },
                      child: const Text('Gönder')),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.help_outline),
      ),
    );
  }
}

class Item {
  String header;
  String description;

  //Constructor
  Item(this.header, this.description);
}

class ItemList with ChangeNotifier {
  List<Item> items = [];

  void addItem(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    items.remove(item);
    notifyListeners();
  }
}

class AddItem extends StatefulWidget {
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController headerController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var itemListObject = Provider.of<ItemList>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sizin Önlemleriniz"),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const SizedBox(height: 15),
            Container(
              width: 350,
              height: 50,
              color: Colors.deepOrange,
              child: const Center(
                child: Text(
                  'Bugün iklim değişikliğine engel olmak için yaptıklarınız:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: headerController,
              decoration: const InputDecoration(hintText: "İklim için..."),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "..."),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  var newItem =
                      Item(headerController.text, descriptionController.text);
                  itemListObject.addItem(newItem);
                  Navigator.pop(context);
                },
                child: const Text("Onayla"))
          ]),
        ));
  }
}

class ItemListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemListObject = Provider.of<ItemList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("İklim Uğruna"),
        backgroundColor: Colors.deepOrange,
      ),
      body: itemListObject.items.isEmpty
          ? Center(child: Text("Bu dünya için bugün yapacakların"))
          : ListView.builder(
              itemCount: itemListObject.items.length,
              itemBuilder: (context, index) {
                final item = itemListObject.items[index];
                return ListTile(
                  title: Text(item.header),
                  subtitle: Text(item.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      itemListObject.removeItem(item);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use Navigator to navigate to the "AddItem" page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
