import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expenses_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _list = [
    Expense(title: "Course", amount: 19.9, category: Category.food, date: DateTime.now(),),
    Expense(title: "Restaurant", amount: 11.9, category: Category.travel, date: DateTime.now(),)
  ];

  void _showAddExpenseModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context, 
      builder: (modalContext) => NewExpense(onAddExpense: _addExpense,)
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _list.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _list.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_list.isNotEmpty) {
      mainContent = ExpensesList(data: _list, onRemoveExpense: _removeExpense,);
    }

    final container = width < 600 ? Column(
        children: [
          Chart(expenses: _list),
          Expanded(child: mainContent),
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _list)),
          Expanded(child: mainContent),
        ],
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _showAddExpenseModal, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: container,
    );
  }
}