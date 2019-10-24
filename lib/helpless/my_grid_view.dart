import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trampoely2/database/cars_database.dart';
import 'package:trampoely2/modal/modals_car.dart';
import 'package:trampoely2/screens/cars_description.dart';
import 'package:trampoely2/screens/inputs_datas_screen.dart';


class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  DBCars dbcars = DBCars();

  List<Cars> cars = List();


  @override
  void initState() {
    super.initState();
    _getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemCount: cars.length + 1,
      itemBuilder: (context, index){
        if(index < cars.length){
          return GestureDetector(
            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DescritionScreen(cars[index])));},
            onLongPress: (){
              _showOptions(context, index);
            },
            child: Card(
              child:Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: cars[index].imagem != null
                              ? FileImage(File(cars[index].imagem))
                              : AssetImage('image/padrao.png')),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 36,
                      width: double.infinity,
                      color: Colors.white70,
                      child: Center(child: Text(cars[index].nome, textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                    ),
                  )
                ],
              ),
            ),
          );
        }else{
          return Container(
            color: Colors.grey,
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70,),
                  Text('Adicionar Novo Carro',
                    style: TextStyle(color: Colors.white, fontSize: 18),)
                ],
              ),
              onTap: (){
                _showCarsPage();
              },

            ),

          );
        }
      },
      );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Text(
                            'Editar',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showCarsPage(car: cars[index]);
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Text(
                            'Excluir',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          onPressed: () {
                            print(cars[index]);
                            print(cars[index].id);
                            dbcars.deleteCar(cars[index].id);
                            setState(() {
                              Navigator.pop(context);
                              cars.removeAt(index);
                            });
                          },
                        ))
                  ],
                ),
              );
            },
          );
        });
  }


  void _showCarsPage({Cars car}) async{
    final recCars = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CarPage(
              car: car,
            )));
    if (recCars != null) {
      if (car != null) {
        await dbcars.updateCar(recCars);
      } else {
        await dbcars.saveCar(recCars);
      }
      _getAllCars();
    }
  }


  void _getAllCars() {
    dbcars.getAllCar().then((list) {
      setState(() {
        cars = list;
      });
    });
  }
}
