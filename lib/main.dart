import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navegação Básica',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: PrimeiraRota(),
  ));
}

class PrimeiraRota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC'),
        centerTitle: true,
      ),
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text('Calcular IMC',
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          color: Colors.blue,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  // ignore: missing_return
  Widget build(BuildContext context) {
    // ignore: unused_label
    body:
    Center(
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.blue,
        child: Text('Retornar'),
      ),
    );
  }
}

class _HomeState extends State<Home> {
  String infoTexto = "Informe seus dados";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Widget buildTextField(String label, TextEditingController c) {
    return TextField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
          border: OutlineInputBorder()),
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
      keyboardType: TextInputType.number,
      controller: c,
    );
  }

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      infoTexto = "Informe seus dados";
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height + height);

    setState(() {
      if (imc < 17) {
        infoTexto = "Muito abaixo do peso " + ((imc.toStringAsPrecision(4)));
      } else if (imc >= 17 && imc <= 18.49) {
        infoTexto = "Abaixo do peso " + (imc.toStringAsPrecision(4));
      } else if (imc >= 18.5 && imc <= 24.99) {
        infoTexto = "Peso ideal ou normal " + (imc.toStringAsPrecision(4));
      } else if (imc >= 25 && imc <= 29.99) {
        infoTexto = "Acima do peso " + (imc.toStringAsPrecision(4));
      } else if (imc >= 30 && imc <= 34.99) {
        infoTexto = "Obesidade I " + (imc.toStringAsPrecision(4));
      } else if (imc >= 35 && imc <= 39.99) {
        infoTexto = "Obesidade II (severa) " + (imc.toStringAsPrecision(4));
      } else if (imc > 40) {
        infoTexto = "Obesidade III (mórbida) " + (imc.toStringAsPrecision(4));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 170.0, color: Colors.green),
            buildTextField("Peso", weightController),
            Divider(),
            buildTextField("Altura", heightController),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 50.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    "Verificar",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    _calculate();
                  },
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                infoTexto,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
