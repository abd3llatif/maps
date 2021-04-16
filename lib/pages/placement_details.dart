import 'package:flutter/material.dart';
import 'package:maps/models/placement.dart';

class PlacementDetailsPage extends StatelessWidget {
  final Placement placement;

  PlacementDetailsPage(this.placement);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${placement.name}"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("Nom d'emplacement: "),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.lightBlue.withOpacity(0.2)),
                        child: Text(
                          "${placement.name}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Latitude: "),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.lightBlue.withOpacity(0.2)),
                        child: Text(
                          "${placement.lat}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Longitude: "),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.lightBlue.withOpacity(0.2)),
                        child: Text(
                          "${placement.lng}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
