import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat.yMMMMd("en_US").addPattern("'at'").add_jm();
class NewRidePage extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey(debugLabel: "New Ride Form");

  @override
  State createState() => new NewRidePageState();
}

class NewRidePageState extends State<NewRidePage> {
  String _origin, _destination;
  DateTime _departureTime;
  int _passengers;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(key: widget._formKey,
            child: Padding(padding: EdgeInsets.all(25),child: ListView(shrinkWrap: true, children: <Widget>[
              Text('New Ride', style: TextStyle(fontSize: 32)),
              Padding(padding: EdgeInsets.all(25)),
              TextFormField(controller: TextEditingController(text: _origin), onChanged: (address) => _origin = address,
                  validator: (address) => address.isEmpty? "Address can't be empty" : null,
                  decoration: InputDecoration(labelText: "Origin", prefixIcon: Icon(Icons.place))),
              Padding(padding: EdgeInsets.all(25)),
              TextFormField(controller: TextEditingController(text: _destination),onChanged: (address) => _destination = address,
                  validator: (address) => address.isEmpty? "Address can't be empty" : null,
                  decoration: InputDecoration(labelText: "Destination", prefixIcon: Icon(Icons.place))),
              Padding(padding: EdgeInsets.all(25)),
              TextFormField(controller: TextEditingController(text: _passengers == null? "" : _passengers.toString()),keyboardType: TextInputType.number, onChanged: (passengers) => _passengers = int.parse(passengers),
                  validator: (passengers) => int.tryParse(passengers) == null? "Passengers must be a number" : null,
                  decoration: InputDecoration(labelText: "Passengers", prefixIcon: Icon(Icons.people))),
              Padding(padding: EdgeInsets.all(25)),
              DateTimeField(
                validator: (date) => date == null? "Invalid Date" : null,
                format: dateFormat,
                decoration: InputDecoration(labelText: "Departure Time", prefixIcon: Icon(Icons.access_time)),
                controller: TextEditingController(text: _departureTime == null? "" : dateFormat.format(_departureTime)),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    var val = DateTimeField.combine(date, time);
                    setState(() => _departureTime = val);
                    return val;
                  } else {
                    setState(() => _departureTime = currentValue);
                    return currentValue;
                  }
                },
              ),
              Padding(padding: EdgeInsets.all(25)),
              Align(alignment: Alignment.center, child: _loading? CircularProgressIndicator() : FlatButton(color: Theme.of(context).primaryColor,
                  onPressed: () => createRide(),
                  child: Padding(padding: EdgeInsets.all(10), child: Text("Submit", style: TextStyle(fontSize: 18))))),
              Padding(padding: EdgeInsets.all(30)),
            ]),
            )));
  }

  createRide() async {
    if (widget._formKey.currentState.validate()) {
      setState(() => _loading = true);
      await Firestore.instance.collection('rides').document().setData({
        "originAddress": _origin,
        "destinationAddress": _destination,
        "departureTime": _departureTime,
        "passengers": _passengers,
        "assigned": []
      });
      setState(() {
        _origin = null;
        _destination = null;
        _departureTime = null;
        _passengers = null;
        _loading = false;
      });
    }
  }
}
