import 'package:covid19_app/app/repositories/data_repositories.dart';
import 'package:covid19_app/app/repositories/endpoint_data.dart';
import 'package:covid19_app/app/services/api.dart';
import 'package:covid19_app/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
 // int _cases;
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepositories>(
      context,
      listen: false,
    );
    //final cases = await dataRepository.getEndpointData(Endpoint.cases);
    final endpointsData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
           for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
