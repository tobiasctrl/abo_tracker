import 'package:flutter/material.dart';

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
    super.initState();
    if (widget.subscriptionName != null) {
      _subscriptionNameController.text = widget.subscriptionName!;
    }
    if (widget.subscriptionPrice != null) {
      _subscriptionPriceController.text = widget.subscriptionPrice.toString();
    }
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
        child: Column(
          children: const <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Subscription Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Subscription Price',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Save',
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
