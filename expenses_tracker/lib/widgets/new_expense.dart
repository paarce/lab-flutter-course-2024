import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function( Expense expense) onAddExpense;

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
      
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid form'),
        content: const Text('Please make sure that ....'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('OK'))
        ],
      ));
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: amountDouble!,
        date: _selectedDate!,
        category: _selectedCategory!,
      )
    );

    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: initialDate,
      lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text, // default
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount')
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null ? 'Select Date' : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker, 
                      icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),),
                ).toList(),
                onChanged: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close')
              ),
              ElevatedButton(
                onPressed: _sumitForm,
                child: const Text('Save expense')
              ),
            ],
          ),
        ],
      ),
    );
  }
}