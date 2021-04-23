import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty //verificar se a variavel esta vazia
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!', // texto
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover, //ajustar o tamanho da imagem
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: widget.transactions.length,
            itemBuilder: (ctx, index) {
              final tr = widget.transactions[index];
              return TransactionItem(
                tr: tr,
                onRemove: widget.onRemove,
              );
            },
          );
  }
}
