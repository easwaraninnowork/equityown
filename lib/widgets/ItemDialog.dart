// lib/widgets/item_dialog.dart
import 'package:flutter/material.dart';
import 'package:quityown/widgets/Item.dart';

class ItemDialog extends StatefulWidget {
  final Function(Item) onAddItem;
  final Item? currentItem; // Nullable item for editing

  ItemDialog({required this.onAddItem, this.currentItem});

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.currentItem?.name ?? '', // Use current item name if editing
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final itemName = _controller.text;
    if (itemName.isNotEmpty) {
      if (widget.currentItem != null) {
        widget.currentItem!.name = itemName; // Modify the current item
      }
      widget.onAddItem(Item(name: itemName,id : 00000));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.currentItem == null ? 'Add Item' : 'Edit Item'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Item name'),
      ),
      actions: [
        TextButton(
          onPressed: _onSubmit,
          child: Text(widget.currentItem == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
