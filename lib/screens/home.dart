// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:api_consume/components/bitcoin.dart';
import 'package:api_consume/components/dolar.dart';
import 'package:api_consume/components/euro.dart';
import 'package:api_consume/components/postal_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Bitcoin(),
                      Dolar()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Euro(),
                      PostalCode()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}