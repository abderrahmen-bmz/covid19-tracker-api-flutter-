import 'package:covid19_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  EndpointCardData({
    @required this.title,
    @required this.assetName,
    @required this.color,
  });

  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({
    Key key,
    @required this.endpoint,
    @required this.value,
  }) : super(key: key);

  final Endpoint endpoint;
  final int value;

  // static Map<Endpoint, String> _cardTitles = {
  //   Endpoint.cases: 'cases',
  //   Endpoint.casesSuspected: 'casesSuspected',
  //   Endpoint.casesConfirmed: 'casesConfirmed',
  //   Endpoint.deaths: 'deaths',
  //   Endpoint.recovered: 'recovered',
  // };
  static Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases: EndpointCardData(
        title: 'Cases',
        assetName: 'assets/count.png',
        color: Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData(
      title: 'Suspected cases',
      assetName: 'assets/suspect.png',
      color: Color(0xFFEEDA28),
    ),
    Endpoint.casesConfirmed: EndpointCardData(
      title: 'Confirmed cases',
      assetName: 'assets/fever.png',
      color: Color(0xFFE99600),
    ),
    Endpoint.deaths: EndpointCardData(
      title: 'Deaths',
      assetName: 'assets/death.png',
      color: Color(0xFFE40000),
    ),
    Endpoint.recovered: EndpointCardData(
      title: 'Recovered',
      assetName: 'assets/patient.png',
      color: Color(0xFF70A901),
    ),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(
                      formattedValue,
                      // value != null ? value.toString() : '',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
