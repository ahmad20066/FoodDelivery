import 'package:flutter/material.dart';
import 'package:order_app/models/cartitem.dart';

class OrderWidget extends StatefulWidget {
  String restaurantName;
  double totalAmount;
  List<CartModel> items;
  OrderWidget(this.restaurantName, this.totalAmount, this.items, {Key? key})
      : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.restaurantName,
              style: Theme.of(context).textTheme.headline6),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text("${widget.totalAmount}\$",
                  style: Theme.of(context).textTheme.headline6),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon:
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more))
            ]),
          ),
        ),
        if (isExpanded)
          Container(
            color: Colors.orange[100],
            //height: MediaQuery.of(context).size.height * 0.04,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${widget.items[index].title} x ${widget.items[index].quantity}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                              "${widget.items[index].price * widget.items[index].quantity}\$",
                              style: Theme.of(context).textTheme.headline6)
                        ],
                      ),
                    ],
                  );
                }),
          )
      ],
    );
  }
}
