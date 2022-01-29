import 'package:flutter/material.dart';
import 'package:order_app/models/addressmodel.dart';

class AddressesBottomSheet extends StatefulWidget {
  List<Address>? addresses;

  Function changeAddress;
  AddressesBottomSheet(this.addresses, this.changeAddress);
  @override
  _AddressesBottomSheetState createState() => _AddressesBottomSheetState();
}

class _AddressesBottomSheetState extends State<AddressesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(onClosing: () {
      setState(() {});
    }, builder: (context) {
      return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.addresses!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.changeAddress(widget.addresses![index]);
                      Navigator.of(context).pop();
                    });
                  },
                  child: ListTile(
                    title: Text(
                        "${widget.addresses![index].city}/${widget.addresses![index].street}"),
                  ),
                );
              })
        ],
      );
    });
  }
}
