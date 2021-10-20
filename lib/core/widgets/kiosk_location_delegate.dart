import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/entities/location.dart';
import 'package:ticket_kiosk/core/services/place_service.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';

class KioskLocationDelegate extends SearchDelegate<Location> {
  final String sessionToken;

  KioskLocationDelegate(this.sessionToken);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      KioskRoundButton(
        iconClose,
        onTap: (){
          query='';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: PlaceService().call(sessionToken, query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter address'),
            )
          : snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) => 
                ListTile(
                  title: Text(
                    snapshot.data[index].placeAddress,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  onTap: () {
                    close(context, snapshot.data[index]);
                  },
                ),
                itemCount: snapshot.data.length,
              )
            : SizedBox.shrink()
    );
  }
}