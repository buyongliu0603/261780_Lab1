import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _bcontroller = TextEditingController();
  final TextEditingController _ccontroller = TextEditingController();
  final TextEditingController _dcontroller = TextEditingController();
  int a, b, c, d, result1 = 0, result2 = 0;
  var operation = ['+', '-', 'x', '/'];
  var _currentOperation = '+';
  String img = "assets/images/calculator.gif";
  AudioCache audioCache = new AudioCache();
  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fraction Calculator',
      home: Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Fraction Calculator'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, height: 250.0, fit: BoxFit.cover),
            Row(
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 80,
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.yellow[50],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _acontroller,
                          )),
                      Divider(
                        color: Colors.black,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Container(
                          width: 80,
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.yellow[50],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _bcontroller,
                          )),
                    ],
                  ),
                ),
                Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: DropdownButton<String>(
                      items: operation.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                      value: _currentOperation,
                    )),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 80,
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.yellow[50],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _ccontroller,
                          )),
                      Divider(
                        color: Colors.black,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Container(
                          width: 80,
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.yellow[50],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _dcontroller,
                          )),
                    ],
                  ),
                ),
                Text(
                  "=",
                  style: TextStyle(fontSize: 30),
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text("$result1"),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text("$result2"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text("Calculate"),
                  onPressed: _onPressed1,
                  color: Colors.blue[200],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text("Clear"),
                  onPressed: _onPressed2,
                  color: Colors.blue[200],
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentOperation = newValueSelected;
    });
  }

  void _onPressed1() {
    setState(() {
      a = int.parse(_acontroller.text);
      b = int.parse(_bcontroller.text);
      c = int.parse(_ccontroller.text);
      d = int.parse(_dcontroller.text);
      if (_currentOperation == '+') {
        result1 = (a * d) + (b * c);
        result2 = b * d;
      } else if (_currentOperation == '-') {
        result1 = (a * d) - (b * c);
        result2 = b * d;
      } else if (_currentOperation == 'x') {
        result1 = a * c;
        result2 = b * d;
      } else if (_currentOperation == '/') {
        result1 = a * d;
        result2 = b * c;
      }
      for (int i = 2; i <= 100000; i++) {
        while (result1 % i == 0 && result2 % i == 0) {
          result1 = (result1 / i).round();
          result2 = (result2 / i).round();
        }
      }
      _count();
    });
  }

  void _onPressed2() {
    setState(() {
      _acontroller.text = "";
      _bcontroller.text = "";
      _ccontroller.text = "";
      _dcontroller.text = "";
      result1 = 0;
      result2 = 0;
      _clear();
    });
  }

  Future _count() async {
    audioPlayer = await AudioCache().play("audio/correct.mp3");
  }

  Future _clear() async {
    audioPlayer = await AudioCache().play("audio/quack.mp3");
  }

  @override
  void dispose() {
    audioPlayer = null;
    super.dispose();
  }
}
