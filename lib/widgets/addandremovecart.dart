import 'package:flutter/material.dart';

class AddAndRemoveItem extends StatefulWidget {
  AddAndRemoveItem(this.count);

  int count;

  @override
  State<AddAndRemoveItem> createState() => _AddAndRemoveItemState();
}

class _AddAndRemoveItemState extends State<AddAndRemoveItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                if (widget.count > 1) {
                  setState(() {
                    widget.count--;
                  });
                }
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.orange,
              )),
          Text(
            "${widget.count}",
            style: Theme.of(context).textTheme.headline4,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.count++;
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }
}
