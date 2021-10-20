import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ticket_kiosk/core/entities/location.dart';

class PlaceService {
  final client=Client();

  // PlaceService(this.client);

  static final String iosKey = 'AIzaSyAdapRoJPofx1BKpfiEzI06jMv_03w8eoo';
  static final String androidKey = 'AIzaSyAdapRoJPofx1BKpfiEzI06jMv_03w8eoo';

  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Location>> call(String sessionToken, String query, {String languageCode='en', String countryCode='ng'}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=$languageCode&components=country:$countryCode&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Location>((prediction) => Location(
              placeId: prediction['place_id'], 
              placeAddress: prediction['description'])
            )
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  // Future<Place> getPlaceDetailFromId(String placeId) async {
  //   // if you want to get the details of the selected place by place_id
  // }
}