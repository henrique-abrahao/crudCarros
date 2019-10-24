import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trampoely2/modal/modals_car.dart';

class CarPage extends StatefulWidget {

  final Cars car;

  CarPage({this.car});

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {

  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _corController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _combustivelController = TextEditingController();


  final _nomeFocus = FocusNode();

  Cars _editedCar;

  bool _carEdited = false;

  @override
  void initState() {
    super.initState();

    if (widget.car == null) {
      _editedCar = Cars();
    } else {
      _editedCar = Cars.fromMap(widget.car.toMap());

      _nomeController.text = _editedCar.nome;
      _imagemController.text = _editedCar.imagem;
      _anoController.text = _editedCar.ano;
      _modeloController.text = _editedCar.modelo;
      _combustivelController.text = _editedCar.combustivel;
      _corController.text = _editedCar.cor;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editedCar.nome ?? 'Novo Carro'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedCar.nome != null && _editedCar.nome.isNotEmpty) {
              Navigator.pop(context, _editedCar);
            } else {
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
          },
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedCar.imagem != null
                            ? FileImage(File(_editedCar.imagem))
                            : AssetImage('image/padrao.png')),
                  ),
                ),
                onTap: (){
                  ImagePicker.pickImage(source: ImageSource.camera).then((file){
                    if(file == null) return;
                    setState(() {
                      _editedCar.imagem = file.path;
                    });
                  });
                },
              ),
              TextField(
                controller: _nomeController,
                focusNode: _nomeFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _carEdited = true;
                  setState(() {
                    _editedCar.nome = text;
                  });
                },
              ),
              TextField(
                controller: _corController,
                decoration: InputDecoration(labelText: "Cor"),
                onChanged: (text) {
                  _carEdited = true;
                  _editedCar.cor = text;
                },
              ),
              TextField(
                controller: _modeloController,
                decoration: InputDecoration(labelText: "Modelo"),
                onChanged: (text) {
                  _carEdited = true;
                  _editedCar.modelo = text;
                },
              ),
              TextField(
                controller: _combustivelController,
                decoration: InputDecoration(labelText: "Combustível"),
                onChanged: (text) {
                  _carEdited = true;
                  _editedCar.combustivel = text;
                },
              ),
              TextField(
                controller: _anoController,
                decoration: InputDecoration(labelText: "Ano"),
                onChanged: (text) {
                  _carEdited = true;
                  _editedCar.ano = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _requestPop() {
    if (_carEdited) {
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text('Se Sair as Alterações serão Perdidas'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],

            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
