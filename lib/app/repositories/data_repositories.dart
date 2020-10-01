import 'package:covid19_app/app/repositories/endpoint_data.dart';
import 'package:covid19_app/app/services/api.dart';
import 'package:covid19_app/app/services/api_service.dart';
import 'package:covid19_app/app/services/data_cach_service.dart';
import 'package:covid19_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepositories {
  DataRepositories({
    @required this.apiService,
    @required this.dataCacheService,
  });
  final APIService apiService;
  final DataCacheService dataCacheService;

  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint),
      );
  EndpointsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndpointsData> getAllEndpointsData() async =>
      await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  // Future<int> getEndpointData(Endpoint endpoint) async {
  //   try {
  //     if (_accessToken == null) {
  //       _accessToken = await apiService.getAccessToken();
  //     }
  //     return await apiService.getEndpointData(
  //       accessToken: _accessToken,
  //       endpoint: endpoint,
  //     );
  //   } on Response catch (response) {
  //     // if unauthorized , get access token again
  //     if (response.statusCode == 401) {
  //       _accessToken = await apiService.getAccessToken();
  //       return await apiService.getEndpointData(
  //         accessToken: _accessToken,
  //         endpoint: endpoint,
  //       );
  //     }
  //     rethrow;
  //   }
  // }

  // Future<EndpointsData> getAllEndpointsData() async {
  //   try {
  //     if (_accessToken == null) {
  //       _accessToken = await apiService.getAccessToken();
  //     }
  //     return await _getAllEndpointsData();
  //   } on Response catch (response) {
  //     // if unauthorized , get access token again
  //     if (response.statusCode == 401) {
  //       _accessToken = await apiService.getAccessToken();
  //       return await _getAllEndpointsData();
  //     }
  //     rethrow;
  //   }
  // }

  Future<EndpointsData> _getAllEndpointsData() async {
    // final cases = await apiService.getEndpointData(
    //   accessToken: _accessToken,
    //   endpoint: Endpoint.cases,
    // );
    //  final deaths = await apiService.getEndpointData(
    //   accessToken: _accessToken,
    //   endpoint: Endpoint.deaths,
    // );
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      },
    );
  }
}
