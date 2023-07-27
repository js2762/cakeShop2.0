import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  String userEndPoint = 'https://64464735ee791e1e29fabb4f.mockapi.io/api/demo/users';

  getUserData() async{
    final response = await http.get(Uri.parse(userEndPoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      //print(result);
      return result;
    } else {
      throw Exception('Error While Fetching Data!');
    }

  }

}
