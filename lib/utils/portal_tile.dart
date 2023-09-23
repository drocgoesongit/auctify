import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:flutter/material.dart';

class PortalTile extends StatefulWidget {
  PortalTile({super.key, required this.portalModel});
  final Portal portalModel;
  @override
  State<PortalTile> createState() => _PortalTileState();
}

class _PortalTileState extends State<PortalTile> {
  @override
  Widget build(BuildContext context) {
    String endTime =
        UtilFunctions().formatTimestamp(widget.portalModel.endTime);
    return ListTile(
      title: Text(widget.portalModel.portalStatus),
      subtitle: Column(children: [
        Text(widget.portalModel.portalId),
        SizedBox(height: 10),
        Text("iteration: ${widget.portalModel.iterationCount}"),
        SizedBox(height: 10),
        Text("endtime: $endTime"),
        SizedBox(height: 10),
        Text("total bids: ${widget.portalModel.totalNumberOfBidders}"),
        SizedBox(height: 10),
        Text("bidder: ${widget.portalModel.portalCurrentWinner}"),
        SizedBox(height: 10),
        Text("bid: ${widget.portalModel.portalCurrentWinnerBidAmount}"),
      ]),
    );
  }
}
