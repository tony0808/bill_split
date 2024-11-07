import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bill_split/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemForm extends StatefulWidget {
  final Item? item;
  final int? index;
  final bool isEdit;

  const FoodItemForm({
    super.key,
    this.isEdit = false,
    this.index,
    this.item,
  });

  @override
  State<FoodItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<FoodItemForm> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    final nameText = widget.isEdit ? widget.item!.name : '';
    final priceText = widget.isEdit ? '${widget.item!.price}' : '';
    final quantityText = widget.isEdit ? '${widget.item!.quantity}' : '';

    _nameController = TextEditingController(text: nameText);
    _priceController = TextEditingController(text: priceText);
    _quantityController = TextEditingController(text: quantityText);

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void createNewFoodItem() {
    final price = double.parse(_priceController.text);
    final name = _nameController.text;
    final quantity = int.parse(_quantityController.text);

    Item newItem = Item(
      price: price,
      name: name,
      quantity: quantity,
    );

    context.read<OrderBloc>().add(OrderAddItemEvent(newItem));

    Navigator.of(context).pop();
  }

  void editFoodItem() {
    final price = double.parse(_priceController.text);
    final name = _nameController.text;
    final quantity = int.parse(_quantityController.text);

    Item newItem = Item(
      price: price,
      name: name,
      quantity: quantity,
    );

    context.read<OrderBloc>().add(OrderEditItemEvent(widget.index!, newItem));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(
            controller: _nameController,
            hintText: 'Enter food name',
            type: TextInputType.text,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: _priceController,
            hintText: 'Enter price',
            type: TextInputType.number,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: _quantityController,
            hintText: 'Enter quantity',
            type: TextInputType.number,
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.isEdit ? editFoodItem() : createNewFoodItem();
                  },
                  child: widget.isEdit ? const Text('Update') : const Text('Create'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
