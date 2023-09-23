import 'dart:developer';

import 'package:auctify/models/portal_model.dart';
import 'package:auctify/utils/portal_tile.dart';
import 'package:auctify/viewmodels/manage_portal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PortalStatusesScreen extends StatefulWidget {
  const PortalStatusesScreen({super.key});

  @override
  State<PortalStatusesScreen> createState() => _PortalStatusesScreenState();
}

class _PortalStatusesScreenState extends State<PortalStatusesScreen> {
  // stream to get the list of active and inactive portals.
  Stream<List<Portal>> getPortals() {
    return FirebaseFirestore.instance
        .collection('portal')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Portal.fromJson(doc.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ManagePortalBackend().checkForExistingPortals();
    return Scaffold(
      appBar: AppBar(title: Text("Portal Statuses")),
      body: StreamBuilder<List<Portal>>(
        stream: getPortals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: kDefaultIconDarkColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            log("No portal found");
            return const Center(
                child: Text(
              'No Portal found',
            ));
          } else if (snapshot.hasData) {
            log("Existing chat is set to false.");
            List<Portal> portals = snapshot.data!;

            return ListView.builder(
              itemCount: portals.length,
              itemBuilder: (context, index) {
                Portal portal = portals[index];
                return PortalTile(portalModel: portal);
              },
            );
          } else {
            return Center(child: Text('No messages available.'));
          }
        },
      ),
    );
  }
}
