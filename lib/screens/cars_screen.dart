import 'package:flutter/material.dart';
import 'package:trampoely2/helpless/my_grid_view.dart';

import 'inputs_datas_screen.dart';

class CarScreen extends StatefulWidget {
  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Carros'), centerTitle: true,),
        body: Column(
          children: <Widget>[
            Expanded(child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: MyGridView(),
            ))
          ],
        )
    );
  }
}
