import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/constants.dart';

class ChargingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getLeadingOnlyAppBar(context: context),
      backgroundColor: getPeachColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildScreenTitle(content: "All transaction"),
            noHistoryAvail(
              key: const Key("no_transaction_avail_key"),
              icon: Icons.repeat,
              content: "No transaction available!"
            )
          ],
        ),
      ),
    );
  }
}
