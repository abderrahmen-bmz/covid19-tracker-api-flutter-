import 'package:covid19_app/app/services/api.dart';
import 'package:covid19_app/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepositories {
  DataRepositories({@required this.apiService});
  final APIService apiService;
  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        final _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointData(
        accessToken: _accessToken,
        endpoint: endpoint,
      );
    } on Response catch (response) {
      // if unauthorized , get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(
          accessToken: _accessToken,
          endpoint: endpoint,
        );
      }
      rethrow;
    }
  }
}
