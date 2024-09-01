import 'dart:io';

import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _sumitForm() {
    final amountDouble = double.tryParse(_amountController.text);
    final isAmountInvalid = amountDouble == null || amountDouble < 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
          _showDialog();
    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: amountDouble!,
      date: _selectedDate!,
      category: _selectedCategory!,
    ));

    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid form'),
                content: const Text('Please make sure that ....'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OK'))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid form'),
                content: const Text('Please make sure that ....'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OK'))
                ],
              ));
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: initialDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  // Subwidgets
  Widget _getTitleField() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      keyboardType: TextInputType.text, // default
      decoration: const InputDecoration(label: Text('Title')),
    );
  }

  Widget _getAmountField() {
    return TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            prefixText: '\$ ', label: Text('Amount')),
    );
  }

  Widget _getDateField() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(_selectedDate == null
              ? 'Select Date'
              : formatter.format(_selectedDate!)),
          IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month)),
        ],
    );
  }

  Widget _getCategoryField() {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (category) {
        setState(() {
          _selectedCategory = category;
        });
      });
  }

  List<Widget> _getActionButtonsSet() {
    return [
      const Spacer(),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close')),
      ElevatedButton(
          onPressed: _sumitForm, child: const Text('Save expense')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    
    return LayoutBuilder(builder: (ctx, constraints) {
      final witdh = constraints.maxWidth;
      return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (witdh >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Expanded(child: _getTitleField()), const SizedBox(width: 16,), Expanded(child: _getAmountField())],
                    )
                  else
                    _getTitleField(),

                  Row(
                    children: [
                      if (witdh >= 600)
                        _getCategoryField()
                      else
                        Expanded(child: _getAmountField()),
                      Expanded(child: _getDateField()),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      if (witdh < 600)
                        _getCategoryField(),
                      ..._getActionButtonsSet()
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }
}
