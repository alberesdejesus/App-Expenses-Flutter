import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove;

  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    Future _confirmRemove(fund) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Deseja mesmo remover?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return widget.onRemove(fund);
                  },
                ),
                FlatButton(
                  child: Text('Não'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return false;
                  },
                ),
              ],
            );
          });
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                onPressed: () => _confirmRemove(widget.tr.id),
                icon: Icon(Icons.delete),
                label: Text('Excluir'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _confirmRemove(widget.tr.id),
              ),
      ),
    );
  }
}