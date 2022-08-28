import 'package:flutter/material.dart';

//Create subscription element
class SubscriptionElement extends StatelessWidget {
  const SubscriptionElement(
      {Key? key,
      required this.subscriptionName,
      required this.subscriptionPrice,
      required this.subscriptionId,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);
  final String subscriptionName;
  final double subscriptionPrice;
  final int subscriptionId;
  final void Function(String, double, int) onEdit;
  final void Function(int) onDelete;

  void _handleSelection(String value) {
    //print('Selected $value');
    if (value == 'Delete') {
      _deleteSubscription();
    } else if (value == 'Edit') {
      _editSubscription();
    }
  }

  void _deleteSubscription() {
    //print('delete subscription $subscriptionId');
    onDelete(subscriptionId);
  }

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
