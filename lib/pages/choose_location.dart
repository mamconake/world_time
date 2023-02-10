// import 'package:flutter/material.dart';


// class ChooseLocation extends StatefulWidget {
//   const ChooseLocation({super.key});

//   @override
//   State<ChooseLocation> createState() => _ChooseLocationState();
// }

// class _ChooseLocationState extends State<ChooseLocation> {


//   @override
//   Widget build(BuildContext context) {
//     print('initBuild function run');
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.blue[900],
//         title: Text('choose location screen'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List? countries;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  _fetchCountries() async {
    final response = await http.get(Uri.parse('https://countryflagsapi.com/png'));
    if (response.statusCode == 200) {
      setState(() {
        countries = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('choose location screen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: countries == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countries?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    'https://www.countryflags.io/${countries?[index]['alpha2Code']}/flat/64.png',
                  ),
                  title: Text(countries?[index]['name']),
                );
              },
            ),
    );
  }
}
