import 'dart:convert';

import 'package:abo_tracker/add_subscription.dart';
import 'package:abo_tracker/subscription_element.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<SubscriptionElement> _subscriptions = [];
  final JsonCodec json = const JsonCodec();

  Future<void> _navigateToAddSubscription(
      String? name, double? price, int? id) async {
    if (_subscriptions.isNotEmpty && id == null) {
      id = _subscriptions[_subscriptions.length - 1].subscriptionId + 1;
    } else {
      id ??= 0;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddSubscriptionPage(
                subscriptionName: name,
                subscriptionPrice: price,
                subscriptionId: id,
              )),
    );
    _loadSubscriptions();
  }

  Future<void> _deleteSubscription(int id) async {
    print('delete subscription $id');
    final SharedPreferences prefs = await _prefs;
    final String? subscriptions = prefs.getString('subscriptions');
    final List<dynamic> subscriptionsJson =
        subscriptions != null ? json.decode(subscriptions) : <dynamic>[];
    subscriptionsJson
        .removeWhere((dynamic subscription) => subscription['id'] == id);
    prefs.setString('subscriptions', json.encode(subscriptionsJson));
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    print('loading subscriptions');
    _subscriptions.clear();
    final SharedPreferences prefs = await _prefs;
    final String? subscriptions = prefs.getString('subscriptions');
    if (subscriptions != null) {
      final List<dynamic> subscriptionsJson = json.decode(subscriptions);
      for (final dynamic subscriptionJson in subscriptionsJson) {
        final String subscriptionName = subscriptionJson['name'];
        final double subscriptionPrice = subscriptionJson['price'];
        final int subscriptionId = subscriptionJson['id'];
        _subscriptions.add(SubscriptionElement(
          subscriptionName: subscriptionName,
          subscriptionPrice: subscriptionPrice,
          subscriptionId: subscriptionId,
          onEdit: _navigateToAddSubscription,
          onDelete: _deleteSubscription,
        ));
      }
    }
    setState(() {});
  }

  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          for (final SubscriptionElement subscription in _subscriptions)
            subscription,
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToAddSubscription(null, null, null);
        },
        tooltip: 'Add Subscription',
        label: const Text('Add Subscription'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
