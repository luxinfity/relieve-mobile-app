import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

/*
 * Define application wide static objects
 */
class MyRouter extends Router {
    static const String ROOT = "/";
    static const String BOARDING = "/boarding";
    static const String CALL = "/call";
    static const String DASHBOARD = "/dashboard";
    static const String WALKTHROUGH = "/walkthrough";
    static const String DISASTER = "/disaster";
    // static String deepLink = "/message";

    final boardingHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params["id"][0]);
        return Text("BOARDING");
    });

    final callHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params["id"][0]);
        return Text("CALL");
    });

    final dashboardHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params["id"][0]);
        return Text("DASHBOARD");
    });

    final walkthroughHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params["id"][0]);
        return Text("walkthrough");
    });

    final disasterHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params["id"][0]);
        return Text("disaster");
    });

    MyRouter() {
        define(BOARDING, handler: boardingHandler);
        define(CALL, handler: callHandler);
        define(WALKTHROUGH, handler: walkthroughHandler);
        define(DASHBOARD, handler: dashboardHandler);
        define(DISASTER, handler: disasterHandler);
    }
}