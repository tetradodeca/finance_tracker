import 'package:http/http.dart' as http;
import 'dart:convert';

Future getPrice(String id) async {
  try {
    var url = "https://api.coingecko.com/api/v3/coins/" + id;
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var value = json['market_data']['current_price']['usd'].toString();
    return double.parse(value);
  } catch (e) {
    print(e.toString());
  }
}

// Future getList() async {
//   try {
//     var url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     return json.toString();
//   } catch (e) {
//     print(e.toString());
//   }
// }