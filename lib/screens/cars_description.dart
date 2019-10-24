import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trampoely2/modal/modals_car.dart';

class DescritionScreen extends StatelessWidget {
  final Cars cars;

  DescritionScreen(this.cars);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cars.nome),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 18),
            Center(
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: cars.imagem != null
                          ? FileImage(File(cars.imagem))
                          : AssetImage('image/padrao.png')),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text('Ano: ${cars.ano}', style: TextStyle(fontSize: 24),),
            SizedBox(height: 18),
            Text('Modelo: ${cars.modelo}', style: TextStyle(fontSize: 24),),
            SizedBox(height: 18),
            Text('Cor: ${cars.cor}', style: TextStyle(fontSize: 24),),
            SizedBox(height: 18),
            Text('Tipo Combustível: ${cars.combustivel}', style: TextStyle(fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
