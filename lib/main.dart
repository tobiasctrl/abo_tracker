import 'package:abo_tracker/add_subscription.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyApp(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const AddSubscriptionPage(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Abo Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: const <Widget>[
          SubscriptionElement(
              subscriptionName: 'Netflix',
              subscriptionPrice: 9.99,
              subscriptionId: 0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddSubscriptionPage()),
          );
        },
        tooltip: 'Add Subscription',
        label: const Text('Add Subscription'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

//Create subscription element
class SubscriptionElement extends StatelessWidget {
  const SubscriptionElement(
      {Key? key,
      required this.subscriptionName,
      required this.subscriptionPrice,
      required this.subscriptionId})
      : super(key: key);
  final String subscriptionName;
  final double subscriptionPrice;
  final int subscriptionId;

  void _handleSelection(String value) {
    print('Selected $value');
    if (value == 'Delete') {
      _deleteSubscription();
    }
  }

  void _deleteSubscription() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subscriptionName),
      subtitle: Text('\$${subscriptionPrice.toStringAsFixed(2)}'),
      trailing: PopupMenuButton<String>(
        onSelected: _handleSelection,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
            //on pressed, navigate to add subscription page
            onTap: () {
              print('pressed edit');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddSubscriptionPage()),
              );
            },
          ),
          const PopupMenuItem(
            value: 'Delete',
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
