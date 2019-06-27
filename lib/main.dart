import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
    ));

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumMargin = 5.0;
  var _currentItemSelected = '';
  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle mTextFieldTextStyle =
        Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16.0);
    TextStyle mButtonTextStyle = Theme.of(context).textTheme.subtitle;
    TextStyle mErrorTextStyle = Theme.of(context).textTheme.caption.copyWith(color: Colors.redAccent,fontSize: 13.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumMargin),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.all(_minimumMargin),
                child: TextFormField(
                  style: mTextFieldTextStyle,
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: mTextFieldTextStyle,
                      errorStyle: mErrorTextStyle,
                      hintText: 'Enter Principal Amount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumMargin),
                child: TextFormField(
                  style: mTextFieldTextStyle,
                  controller: interestRateController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter interest rate';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Interest Rate',
                      labelStyle: mTextFieldTextStyle,
                      errorStyle: mErrorTextStyle,
                      hintText: 'In Precent',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumMargin),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: mTextFieldTextStyle,
                        controller: termController,
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter term period';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: mTextFieldTextStyle,
                            errorStyle: mErrorTextStyle,
                            hintText: 'Time In Years',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(
                      width: _minimumMargin * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumMargin),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.2,
                          style: mButtonTextStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturns();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.2,
                          style: mButtonTextStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumMargin),
                child: Text(
                  displayResult,
                  style: mTextFieldTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/img.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      margin: EdgeInsets.all(_minimumMargin * 6),
      child: image,
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double interestRate = double.parse(interestRateController.text);
    double term = double.parse(termController.text);

    double totalAmount = principal + (principal * interestRate * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmount $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    interestRateController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
