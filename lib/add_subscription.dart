import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSubscriptionPage extends StatefulWidget {
  AddSubscriptionPage({
    Key? key,
    this.subscriptionName,
    this.subscriptionPrice,
    this.subscriptionId,
  }) : super(key: key);
  final String? subscriptionName;
  final double? subscriptionPrice;
  final int? subscriptionId;
  @override
  State<StatefulWidget> createState() => _AddSubscriptionPageState();
}

class _AddSubscriptionPageState extends State<AddSubscriptionPage> {
  final TextEditingController _subscriptionNameController =
      TextEditingController();
  final TextEditingController _subscriptionPriceController =
      TextEditingController();
  @override
  void initState() {
    /*
    print(widget.subscriptionName);
    print(widget.subscriptionPrice);
    print(widget.subscriptionId);*/
    if (widget.subscriptionName != null) {
      _subscriptionNameController.text = widget.subscriptionName!;
    }
    if (widget.subscriptionPrice != null) {
      _subscriptionPriceController.text = widget.subscriptionPrice.toString();
    }
    super.initState();
  }

  Future<void> _saveSubscription() async {
    if (_subscriptionNameController.text.isEmpty ||
        _subscriptionPriceController.text.isEmpty) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? subscriptions = prefs.getString('subscriptions');
    final List<dynamic> subscriptionsJson =
        subscriptions != null ? json.decode(subscriptions) : <dynamic>[];
    final Map<String, dynamic> subscriptionJson = <String, dynamic>{
      'name': _subscriptionNameController.text,
      'price': double.parse(_subscriptionPriceController.text),
      'id': widget.subscriptionId ?? subscriptionsJson.length,
    };
    //remove the old subscription if it exists
    if (widget.subscriptionId != null) {
      subscriptionsJson.removeWhere((dynamic subscription) =>
          subscription['id'] == widget.subscriptionId);
    }
    subscriptionsJson.add(subscriptionJson);
    prefs.setString('subscriptions', json.encode(subscriptionsJson));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subscription'),
      ),
      // TextField for subscription name and for subscription price
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
                child: TextFormField(
              controller: _subscriptionNameController,
              decoration: const InputDecoration(
                labelText: 'Subscription Name',
              ),
            )),
            Flexible(
                child: TextFormField(
              controller: _subscriptionPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subscription Price',
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveSubscription,
        tooltip: 'Save',
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
