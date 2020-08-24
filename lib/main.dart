import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:multi_level_drop_down/models/Localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List countiesList = List();
  List subCountiesList = List();
  List wardsList = List();
  List subCountiesTempList = List();
  List wardsTempList = List();

  String _county;
  String _subCounty;
  String _ward;

  String countytest;

  Future<String> loadCountyDataFromFile() async {
    return await rootBundle.loadString('assets/county_data.json');
  }

  Future<String> _populateDropdown() async {
    String getPlaces = await loadCountyDataFromFile();
    final jsonResponse = json.decode(getPlaces);

    Localization places = new Localization.fromJson(jsonResponse);

    setState(() {
      countiesList = places.counties;
      subCountiesList = places.subCounties;
      wardsList = places.wards;
    });
  }

  @override
  void initState() {
    super.initState();
    this._populateDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dependent Dropdown'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                items: countiesList.map((dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem.countyId.toString(),
                    child: Text(dropDownStringItem.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _subCounty = null;
                    _county = value;
                    countytest = countiesList
                        .singleWhere((i) => i.countyId.toString() == value)
                        .name;
                    print("You selected $countytest");

                    subCountiesTempList = subCountiesList
                        .where((element) =>
                            element.countyId.toString() == (_county.toString()))
                        .toList();
                  });
                },
                value: _county,
                hint: Text('Select county...'),
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: subCountiesTempList.map((dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem.subCountyId.toString(),
                    child: Text(dropDownStringItem.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _ward = null;
                    _subCounty = value;
                    wardsTempList = wardsList
                        .where((element) =>
                            element.subCountyId.toString() ==
                            _subCounty.toString())
                        .toList();
                  });
                },
                value: _subCounty,
                hint: Text('Select subcounty...'),
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: wardsTempList.map((dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem.name,
                    child: Text(dropDownStringItem.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _ward = value;
                  });
                },
                value: _ward,
                hint: Text('Select ward...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
