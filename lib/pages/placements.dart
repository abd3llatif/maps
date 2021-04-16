import 'package:flutter/material.dart';
import 'package:maps/models/placement.dart';
import 'package:maps/pages/maps.dart';

class PlacementsPage extends StatefulWidget {
  final List<Placement> placements = [Placement()]; // init placement

  @override
  _PlacementsPageState createState() => _PlacementsPageState();
}

class _PlacementsPageState extends State<PlacementsPage> {
  List<Widget> placementsForms = [];

  @override
  Widget build(BuildContext context) {
    placementsForms.clear();
    for (int i = 0; i < widget.placements.length; i++) {
      placementsForms.add(_placementForm(i));
    }

    print("${placementsForms.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Placements"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: placementsForms
            ..add(Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                  child: Text("Afficher la carte"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MapsPage(widget.placements)));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            widget.placements.add(Placement());
          });
        },
      ),
    );
  }

  Widget _placementForm(int index) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.lightBlue.withOpacity(0.2)),
            child: Text("#${index + 1}"),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.lightBlue.withOpacity(0.2)),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.placements[index].lat = double.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Latitude"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.lightBlue.withOpacity(0.2)),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.placements[index].lng = double.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Longitude"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.lightBlue.withOpacity(0.2)),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                widget.placements[index].name = value;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Placement name"),
            ),
          ),
        ],
      ),
    );
  }
}
