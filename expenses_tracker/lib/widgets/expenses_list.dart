import 'package:flutter/material.dart';

import 'package:expenses_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.data,
    required this.onRemoveExpense
  });

  final List<Expense> data;
  final void Function( Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(data[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: Theme.of(context).cardTheme.margin,
          child: const Text('Deleting...', style: TextStyle(color: Colors.white),),
        ),
        onDismissed: (direction) {
          onRemoveExpense(data[index]);
        },
        child: ExpenseItem(data[index])) 
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.dateFormatted)
                  ],
                )
              ],
            ),
          ],
        )
      ));
  }
}