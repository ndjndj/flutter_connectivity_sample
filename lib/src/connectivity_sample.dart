import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_connectivity_sample/src/not_connection.dart';

class ConnectivitySample extends StatefulWidget {
  const ConnectivitySample({
    super.key,
    required this.child
  });

  final Widget child;

  @override 
  State<ConnectivitySample> createState() => _State();
}

class _State extends State<ConnectivitySample> {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override 
  void initState() {
    super.initState();
    initConnectivity();
    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override 
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch(_) {
      return;
    }

    if (!mounted) {
      return;
    }
    
    updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return connectionStatus == ConnectivityResult.none 
    ? const NotConnection()
    : widget.child;
  }
}