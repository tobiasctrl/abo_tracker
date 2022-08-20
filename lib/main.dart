import 'package:abo_tracker/add_subscription.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Abo Tracker',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(
              title: 'Abo Tracker',
            ),
        // When navigating to the "/addabo" route, build the addaboScreen widget.
        '/addabo': (context) => AddSubscriptionPage(),
      },
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToAddSubscription(String name, double price, int id) {
    print('Navigating to AddSubscriptionPage');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddSubscriptionPage(
                subscriptionName: name,
                subscriptionPrice: price,
                subscriptionId: id,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          SubscriptionElement(
              subscriptionName: 'Netflix',
              subscriptionPrice: 9.99,
              subscriptionId: 0,
              onEdit: _navigateToAddSubscription)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addabo');
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
      required this.subscriptionId,
      required this.onEdit})
      : super(key: key);
  final String subscriptionName;
  final double subscriptionPrice;
  final int subscriptionId;
  final void Function(String, double, int) onEdit;

  void _handleSelection(String value) {
    print('Selected $value');
    if (value == 'Delete') {
      _deleteSubscription();
    } else if (value == 'Edit') {
      _editSubscription();
    }
  }

  void _deleteSubscription() {}

  void _editSubscription() {
    onEdit(subscriptionName, subscriptionPrice, subscriptionId);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subscriptionName),
      subtitle: Text('\$${subscriptionPrice.toStringAsFixed(2)}'),
      trailing: PopupMenuButton<String>(
        onSelected: _handleSelection,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
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
