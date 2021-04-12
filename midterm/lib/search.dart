import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DateTime _selectedTime;
  String date_in;
  DateFormat dateFormat = DateFormat("yyyy.MM.dd(E)");
  final _isChecked = <bool>[false, false, false];
  List<Item> _filter = generateItems(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView(
        children: [
          _buildPanel(),
          _buildDatePicker(),
          SizedBox(height: 30),
          _buildDialog(),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _filter[index].isExpanded = !isExpanded;
        });
      },
      children: _filter.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text('select filters'),
                ],
              ),
            );
          },
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked[0],
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked[0] = value;
                      });
                    },
                  ),
                  Text('No Kids Zone'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked[1],
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked[1] = value;
                      });
                    },
                  ),
                  Text('Pet-Friendly'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked[2],
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked[2] = value;
                      });
                    },
                  ),
                  Text('Free Breakfast'),
                ],
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          // RaisedButton, Text 두개이상이니 children
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      child: Text('🗓Check In')),
                  Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(date_in != null ? '$date_in' : 'R/A', style: TextStyle(fontSize: 10),)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Future<DateTime> selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), // 초깃값
                    firstDate: DateTime(2018), // 시작일
                    lastDate: DateTime(2030), // 마지막일
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark(), // 다크테마
                        child: child,
                      );
                    },
                  );

                  selectedDate.then((dateTime) {
                    setState(() {
                      _selectedTime = dateTime;
                      date_in = dateFormat.format(_selectedTime);
                    });
                  });
                },
                child: Text('select date'),
              ),
            ],
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _buildDialog() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        onPressed: () {
          showAlertDialog(context);
        },
        child: Text('Alert Dialog'),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your choice'),
          content: Column(
            children: [
              Row(
                children: [
                  Container(child: Icon(Icons.list)),
                  Container(
                      child: Column(
                        children: [
                          Text(_isChecked[0] ? 'No Kids Zone/': ''),
                          Text(_isChecked[1] ? 'Pet-Friendly/': ''),
                          Text(_isChecked[2] ? 'Free Breakfast/': ''),
                        ],
                      ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(child: Icon(Icons.calendar_today)),
                  Container(
                    child: Text(date_in != null ? '$date_in' : 'R/A'),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );
  }
}

class Item {
  Item({
    this.subtitle,
    this.headerValue,
    this.isExpanded = false,
  });

  String subtitle;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Filter',
      subtitle: 'select Filters',
    );
  });
}
