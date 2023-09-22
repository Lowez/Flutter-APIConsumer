import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bitcoin extends StatefulWidget {
  const Bitcoin({super.key});

  @override
  State<Bitcoin> createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {
  String _precoBitcoin = "0";
  bool _gotPrice = true;

  void _setLoading() {
    setState(() {
      _gotPrice = !_gotPrice;
    });
  }

  void _recuperaPrecoBitcoin() async {
    _setLoading();

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> retorno = jsonDecode(response.body);

    setState(() {
      _precoBitcoin = retorno["BRL"]["buy"].toString();
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
            "https://upload.wikimedia.org/wikipedia/commons/5/50/Bitcoin.png",
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: _gotPrice ?
            Text(
              "R\$ $_precoBitcoin",
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
              backgroundColor: Colors.amber[600],
              padding: EdgeInsets.all(15.0)
            ),
          ),
        ),
      ],
    );
  }
}