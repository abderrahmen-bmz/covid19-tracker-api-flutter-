import 'dart:io';

import 'package:covid19_app/app/repositories/data_repositories.dart';
import 'package:covid19_app/app/repositories/endpoint_data.dart';
import 'package:covid19_app/app/services/api.dart';
import 'package:covid19_app/app/ui/endpoint_card.dart';
import 'package:covid19_app/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'show_alert_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  // int _cases;
  Future<void> _updateData() async {
    try {
      final dataRepository = Provider.of<DataRepositories>(
        context,
        listen: false,
      );
      //final cases = await dataRepository.getEndpointData(Endpoint.cases);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
     showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_){
      // generic catch block 4xx and 5xx from server or parsing  data errors
         showAlertDialog( 
        context: context,
        title: 'unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases].date
          : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
              // text:  _endpointsData != null
              //       ? _endpointsData.values[Endpoint.cases].date?.toString() ?? ''
              //       : '',
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
