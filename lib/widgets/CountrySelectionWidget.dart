import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';


class CountrySelectionWidget extends StatefulWidget {
  @override
  _CountrySelectionWidgetState createState() => _CountrySelectionWidgetState();
}

class _CountrySelectionWidgetState extends State<CountrySelectionWidget> {
   var _selectedCountryCode ;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.only(top: 15),
      height: 80,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          CountryCodePicker(
            onChanged: (CountryCode countryCode) {
              setState(() {
                _selectedCountryCode = countryCode;
              });
            },
            initialSelection: 'US',
            favorite: ['+1', 'US'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
          SizedBox(width: 8.0),
          _selectedCountryCode != null
              ? Text(
            _selectedCountryCode?.dialCode ?? '',
            style: TextStyle(fontSize: 16.0),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
