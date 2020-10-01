import 'package:covid19_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}
// this class represent list of endpoint
class API {
  API({
    @required this.apiKey,
  });

  final String apiKey;

  factory API.sandbox() => API(
        apiKey: APIKeys.ncovSandboxKey,
      );

  static final String host = 'ncov2019-admin.firebaseapp.com';
 // static final int port =  443;
 // static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
     //   port: port,
        path: _paths[endpoint],
      );
      // path:'$basePath/${_paths[endpoint]}',
  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
