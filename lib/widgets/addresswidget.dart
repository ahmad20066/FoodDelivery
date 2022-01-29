import 'package:flutter/material.dart';
import 'package:order_app/screens/addressadd.dart';

class AddressWidget extends StatefulWidget {
  String addressId;
  String city;
  String street;
  String building;
  String floor;
  AddressWidget(
      this.addressId, this.city, this.street, this.building, this.floor);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        title: Text(
          "${widget.city}/${widget.street}",
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddAddressScreen.routename,
                  arguments: widget.addressId);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.orange,
            )),
        tileColor: Colors.white70,
        contentPadding: const EdgeInsets.all(8),
        leading: const Icon(
          Icons.location_on,
          color: Colors.orange,
        ),
        subtitle: Text(
          "building : ${widget.building},  floor : ${widget.floor}",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 5,
        ),
      ),
    );
  }
}
