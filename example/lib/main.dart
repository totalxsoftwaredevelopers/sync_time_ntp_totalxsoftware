// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

void main() {
  runApp(const NtpTimeExampleApp());
}

class NtpTimeExampleApp extends StatelessWidget {
  const NtpTimeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NTP Time Sync Example',
      home: NtpTimeHomePage(),
    );
  }
}

class NtpTimeHomePage extends StatefulWidget {
  const NtpTimeHomePage({super.key});

  @override
  State<NtpTimeHomePage> createState() => _NtpTimeHomePageState();
}

class _NtpTimeHomePageState extends State<NtpTimeHomePage> {
  String _networkTime = "Not fetched";
  String _validationStatus = "Not validated";

  /// Fetches the NTP time and updates the state.
  Future<void> _fetchNetworkTime() async {
    DateTime? networkTime = await NtpTimeSyncChecker.getNetworkTime();
    setState(() {
      _networkTime = networkTime != null
          ? networkTime.toString()
          : "Failed to fetch Network Time.";
    });
  }

  /// Validates device time against NTP time and updates the state.
  Future<void> _validateTime() async {
    bool isSynced = await NtpTimeSyncChecker.validateDeviceTime(
      toleranceInSeconds: 5,
    );
    setState(() {
      _validationStatus = isSynced
          ? "Device time is synchronized."
          : "Device time is NOT synchronized.";
    });

    if (!isSynced) {
      // Show a dialog if time is not synchronized
      NtpTimeSyncChecker.showTimeSyncIssueDialog(
        context: context,
        onRetry: () {
          Navigator.pop(context);
          _validateTime();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NTP Time Sync Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "NTP Network Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _networkTime,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchNetworkTime,
              child: const Text("Fetch Network Time"),
            ),
            const SizedBox(height: 24),
            const Text(
              "Device Time Validation:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _validationStatus,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _validateTime,
              child: const Text("Validate Device Time"),
            ),
          ],
        ),
      ),
    );
  }
}
