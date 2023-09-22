// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dolar extends StatefulWidget {
  const Dolar({super.key});

  @override
  State<Dolar> createState() => _DolarState();
}

class _DolarState extends State<Dolar> {
  String _precoDol = "0";
  bool _gotPrice = true;

  void _setLoading() {
    setState(() {
      _gotPrice = !_gotPrice;
    });
  }

  void _recuperaPrecoBitcoin() async {
    _setLoading();

    String url = "https://economia.awesomeapi.com.br/last/USD-BRL";
    http.Response response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> retorno = jsonDecode(response.body);

    print(retorno);

    setState(() {
      _precoDol = retorno["USDBRL"]["bid"];
      _setLoading();
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperaPrecoBitcoin();    
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network(
            "https://www.pngarts.com/files/3/US-Dollar-PNG-High-Quality-Image.png",
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: _gotPrice ?
            Text(
              "R\$ $_precoDol",
              style: const TextStyle(
                fontSize: 25,
              ),
            )
            :
            CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            child: Text(
              "Atualizar Preço",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: _recuperaPrecoBitcoin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: EdgeInsets.all(15.0)
            ),
          ),
        ),
      ],
    );
  }
}