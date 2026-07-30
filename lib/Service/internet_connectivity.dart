import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController extends GetxController {
  // Start with false to prevent showing blue cloud before actual check
  var isConnected = false.obs;
  final InternetConnectionChecker _checker = InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 3),
  );

  @override
  void onInit() {
    super.onInit();
    // Check connection immediately and synchronously if possible
    _performImmediateCheck();
    // Then do a full async check
    _checkConnectionSync();
    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // print("====== Connectivity Changed: $results ======");
      _checkConnection();
    });
  }

  // Perform an immediate synchronous check based on connectivity state
  void _performImmediateCheck() {
    // This will complete almost instantly
    Connectivity().checkConnectivity().then((results) {
      // print("====== Immediate Connectivity Check: $results ======");
      // If we have any network connection, optimistically set to true
      if (!results.contains(ConnectivityResult.none)) {
        isConnected.value = true;
        // print("====== Immediate State: Connected (Network detected) ======");
      } else {
        isConnected.value = false;
        // print("====== Immediate State: Disconnected (No network) ======");
      }
    }).catchError((e) {
      // print("====== Error in immediate check: $e ======");
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Double-check connection when controller is ready
    _checkConnection();
  }

  // Synchronous initial check
  void _checkConnectionSync() async {
    try {
      // First check if we have any network connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      // print("====== Initial Connectivity Check: $connectivityResult ======");

      // If no network at all, set to disconnected immediately
      if (connectivityResult.contains(ConnectivityResult.none)) {
        isConnected.value = false;
        // print("====== Initial Internet Connection: false (No Network) ======");
        return;
      }

      // If we have network connectivity, optimistically show as connected
      // This provides instant feedback while we verify actual internet access
      isConnected.value = true;
      // print("====== Initial Internet Connection: true (Network detected, verifying...) ======");

      // Now verify actual internet connection
      bool result = await _checker.hasConnection;
      if (result != isConnected.value) {
        isConnected.value = result;
        // print("====== Initial Internet Connection: $result (After verification) ======");
      } else {
        // print("====== Initial Internet Connection: $result (Verified) ======");
      }
    } catch (e) {
      // print("====== Error checking initial connection: $e ======");
      isConnected.value = false;
    }
  }

  void _checkConnection() async {
    try {
      // First check if we have any network connectivity
      final connectivityResult = await Connectivity().checkConnectivity();

      // If no network at all, set to disconnected immediately
      if (connectivityResult.contains(ConnectivityResult.none)) {
        isConnected.value = false;
        // print("====== Internet Connection Changed: false (No Network) ======");
        return;
      }

      // If we have network, verify actual internet connection
      bool result = await _checker.hasConnection;
      isConnected.value = result;
      // print("====== Internet Connection Changed: $result ======");
    } catch (e) {
      // print("====== Error checking connection: $e ======");
      isConnected.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
