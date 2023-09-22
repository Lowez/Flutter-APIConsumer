// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Euro extends StatefulWidget {
  const Euro({super.key});

  @override
  State<Euro> createState() => _EuroState();
}

class _EuroState extends State<Euro> {
  String _precoEuro = "0";
  bool _gotPrice = true;

  void _setLoading() {
    setState(() {
      _gotPrice = !_gotPrice;
    });
  }

  void _recuperaPrecoBitcoin() async {
    _setLoading();

    String url = "https://economia.awesomeapi.com.br/last/EUR-BRL";
    http.Response response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> retorno = jsonDecode(response.body);

    print(retorno);

    setState(() {
      _precoEuro = retorno["EURBRL"]["bid"];
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
            "https://assets.stickpng.com/images/580b585b2edbce24c47b287f.png",
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: _gotPrice ?
            Text(
              "R\$ $_precoEuro",
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
              backgroundColor: Colors.grey[600],
              padding: EdgeInsets.all(15.0)
            ),
          ),
        ),
      ],
    );
  }
}