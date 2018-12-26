import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../screen/boarding/boarding.dart';

/*
 * Define application wide static objects
 */
class MyRouter extends Router {
    static const String ROOT = '/';
    // region Boarding
    static const String BOARDING = '/boarding/:page';
    // endregion
    static const String CALL = '/call';
    static const String DASHBOARD = '/dashboard';
    static const String WALKTHROUGH = '/walkthrough';
    static const String DISASTER = '/disaster';
    // static String deepLink = '/message';

    final boardingHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params['id'][0]);
        final page = params['page'][0];
        switch (page) {
            case 'login': 
                return BoadingLogin(title: 'Relieve ID Home Page');
                break;
            case 'register': 
                final number = params['number'][0];
                if (number == 1) {
                    return BoadingRegister1(title: 'Relieve ID Home Page');
                } else {
                    return BoadingRegister2(title: 'Relieve ID Home Page');
                }
                break;
            default : return BoadingHome(title: 'Relieve ID Home Page');
        }
    });

    final callHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params['id'][0]);
        return Text('CALL');
    });

    final dashboardHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params['id'][0]);
        return Text('DASHBOARD');
    });

    final walkthroughHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params['id'][0]);
        return Text('walkthrough');
    });

    final disasterHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // return UsersScreen(params['id'][0]);
        return Text('disaster');
    });

    MyRouter() {
        define(BOARDING, handler: boardingHandler);
        define(CALL, handler: callHandler);
        define(WALKTHROUGH, handler: walkthroughHandler);
        define(DASHBOARD, handler: dashboardHandler);
        define(DISASTER, handler: disasterHandler);
    }
}