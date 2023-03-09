import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Company {
  final String title;
  final String address;
  final String phone;
  final String specialization;
  final String work_time;
  const Company(this.title, this.address, this.phone, this.specialization,
      this.work_time);
}

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/data/companiesData.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hello"),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text("Press me"),
                    onPressed: readJson,
                  ),
                  // Display the data loaded from sample.json
                  _items.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text((index + 1).toString()),
                            title: Text(_items[index]["title"]),
                            subtitle:
                            Text(_items[index]["specialization"]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                        company: Company(
                                            _items[index]["title"],
                                            _items[index]["address"],
                                            _items[index]["phone"],
                                            _items[index]
                                            ["specialization"],
                                            _items[index]["work_time"]))),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                      : Positioned(
                      top: 20,
                      child: Text('Companies are here !  ',
                          style: TextStyle(
                            fontSize: 40,
                            // fontFamily: 'Whisper',
                            color: Colors.blue[300],
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSomeShit()),
          )
        },
        child: const Icon(Icons.add_box_outlined),
      ),*/
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key, required this.company}) : super(key: key);
  final Company company;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text("Спеціалізація: ${company.title}"),
                Text("Адресса: ${company.address}"),
                Text("Номер телефону: ${company.phone}"),
                Text("Спеціалізація: ${company.specialization}"),
                Text("Час роботи: ${company.work_time}"),
              ],
            ),
          )),
    );
  }
}

/*class AddSomeShit extends StatelessWidget {
  const AddSomeShit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Додати компанію"),
      ),
      // body: Center(
      //   child: ,
      //   )
    );
  }
}*/