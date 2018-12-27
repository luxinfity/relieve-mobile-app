import 'package:fluro/fluro.dart';

class RouterUtils {
    // Map <path to source>
    static Map<String, String> pathMap = Map();

    static void addRoute(String source, String routePath, {Handler handler, TransitionType transitionType}) {
        final hasPath = pathMap.containsKey(routePath);
        
        if (hasPath) {
            if (pathMap[routePath] != source) {
                throw Exception('duplicate path with different source, choose another path');
            }
            // else do nothing
        } else {
            pathMap[routePath] = source; // add to route map
            Router.appRouter.define(routePath, handler: handler, transitionType: transitionType);
        }
    }
}