import 'package:flutter/material.dart';
import 'package:trampoely2/helpless/input_help.dart';
import 'package:trampoely2/screens/cars_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 56,),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Image.asset('image/carro.png',),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      InputHelp(
                        controller: userController,
                        text: 'Usuário',
                        pass: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InputHelp(
                        controller: passController,
                        text: 'Senha',
                        pass: true,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0),
                        child: SizedBox(
                          height: 58,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            onPressed:(){
                              _submit(userController.text, passController.text);
                            },
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _submit(user, pass){
    if(user == 'teste' || pass == 'teste'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CarScreen()));
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Login invalido"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
