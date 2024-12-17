library sync_time_ntp_totalxsoftware;

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

export 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

/// A utility class for checking if the device time is synchronized with NTP server time.
class NtpTimeSyncChecker {
  /// Validates whether the device time is synchronized with the NTP server time.
  ///
  /// The [toleranceInSeconds] specifies the acceptable difference (in seconds)
  /// between the device's time and the NTP server time. Defaults to 5 seconds.
  ///
  /// Returns `true` if the time difference is within the tolerance, otherwise `false`.
  static Future<bool> validateDeviceTime({int toleranceInSeconds = 5}) async {
    try {
      // Get the device's current time
      DateTime deviceTime = DateTime.now();

      // Fetch the current time from the NTP server
      DateTime ntpTime = await NTP.now();

      // Calculate the difference between device time and NTP time
      Duration difference = deviceTime.difference(ntpTime);
      log('Time difference: ${difference.inSeconds} seconds');

      // Check if the difference is within the acceptable tolerance
      return difference.inSeconds.abs() <= toleranceInSeconds;
    } catch (e) {
      log('Error while validating NTP time: $e');
      return false;
    }
  }

  /// Fetches and returns the current time from the NTP server.
  ///
  /// If fetching fails, the method returns `null`.
  static Future<DateTime?> getNetworkTime() async {
    try {
      DateTime ntpTime = await NTP.now();
      log('Fetched NTP Time: $ntpTime');
      return ntpTime;
    } catch (e) {
      log('Error while fetching NTP time: $e');
      return null;
    }
  }

  /// Shows a dialog indicating time synchronization issues and provides resolution options.
  ///
  /// The dialog includes options to open the Date/Time settings and retry the app's flow.
  static void showTimeSyncIssueDialog({
    required BuildContext context,
    bool barrierDismissible = false,
    bool canPop = false,
    String title = "Device Issues Detected",
    String message = "We detected the following issues with your device:\n\n"
        "1. Your device's date and time may be incorrect.\n"
        "2. Your device may not be connected to the internet.\n\n"
        "Please resolve these issues to continue using the app.",
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String openSettingsLabel = "Open Date/Time Settings",
    String retryLabel = "Retry",
    Widget? retryDestination, // Widget to restart navigation.
    required void Function() onRetry, // Optional callback for retry action.
    TextStyle? retryButtonTextstyle,
    TextStyle? openSettingsTextstyle,
  }) {
    showDialog(
      context: context,
      barrierDismissible:
          barrierDismissible, // Prevent dismissing by tapping outside
      builder: (context) {
        return PopScope(
          canPop: canPop,
          child: AlertDialog(
            title: Text(
              title,
              style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              message,
              style: messageStyle ?? const TextStyle(fontSize: 16),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              // Open Date/Time Settings
              TextButton(
                onPressed: () async {
                  await _openDateTimeSettings(context);
                },
                child: Text(
                  openSettingsLabel,
                  style: openSettingsTextstyle ??
                      const TextStyle(color: Colors.blue),
                ),
              ),
              // Retry or Navigate
              TextButton(
                onPressed: () {
                  onRetry();
                },
                child: Text(
                  retryLabel,
                  style: retryButtonTextstyle ??
                      const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Opens the Date/Time settings on Android or iOS.
  static Future<void> _openDateTimeSettings(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        const OpenSettingsPlusAndroid().date();
      } else if (Platform.isIOS) {
        const OpenSettingsPlusIOS().dateAndTime();
      } else {
        throw UnsupportedError(
            'Unsupported platform: ${Platform.operatingSystem}');
      }
    } catch (e) {
      debugPrint("Error opening settings: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to open settings. Please try again.")),
      );
    }
  }
}
