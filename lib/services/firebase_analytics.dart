import 'package:firebase_analytics/firebase_analytics.dart';

class AppFirebaseAnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<void> addLogWithParam(
    String name,
    Map<String, dynamic> param,
  ) async {
    await analytics.logEvent(name: name, parameters: param);
  }

  Future<void> addLog(String name) async {
    await analytics.logEvent(
      name: name,
    );
  }

  Future<void> addCurrentScreen(String name) async {
    await analytics.setCurrentScreen(screenName: name);
  }

  Future<void> addSetUserId(String id) async {
    await analytics.setUserId(id: id);
  }
}
