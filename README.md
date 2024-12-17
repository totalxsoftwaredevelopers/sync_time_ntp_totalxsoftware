# sync_time_ntp_totalxsoftware

<a href="https://totalx.in">
<img alt="Launch Totalx" src="https://totalx.in/assets/logo-k3HH3X3v.png">
</a>

<p><strong>Developed by <a rel="noopener" target="_new" style="--streaming-animation-state: var(--batch-play-state-1); --animation-rate: var(--batch-play-rate-1);" href="https://totalx.in"><span style="--animation-count: 18; --streaming-animation-state: var(--batch-play-state-2);">Totalx Software</span></a></strong></p>

---

A Flutter package for checking and synchronizing the device time with NTP (Network Time Protocol) server time. This package ensures that the device's time is accurate within a configurable tolerance and provides user-friendly dialogs to prompt corrections when discrepancies are detected.

---

## **Features**

- Fetch accurate time from an NTP server.
- Validate device time against NTP time with configurable tolerance.
- Display dialogs for time issues and guide users to date/time settings.
- Supports both Android and iOS platforms for settings navigation.

---

## **Installation**

Add the following dependencies to your project's `pubspec.yaml` file:

```yaml
dependencies:
  sync_time_ntp_totalxsoftware: ^0.0.2
```

Run the following command:

```bash
flutter pub get
```

---

## **Usage**

### **1. Validate Device Time**

Check if the device time is synchronized with the NTP server:

```dart
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

void validateTime() async {
  bool isTimeSynced = await NtpTimeSyncChecker.validateDeviceTime(
      toleranceInSeconds: 5,
    );

  if (isTimeSynced) {
    print("Device time is synchronized.");
  } else {
    print("Device time is NOT synchronized.");
  }
}
```

---

### **2. Fetch NTP Network Time**

Fetch the current accurate time from an NTP server:

```dart
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

void fetchNTPTime() async {
  DateTime? networkTime = await NtpTimeSyncChecker.getNetworkTime();

  if (networkTime != null) {
    print("Network Time: \$networkTime");
  } else {
    print("Failed to fetch NTP time.");
  }
}
```

---

### **3. Show Time Sync Issue Dialog**

Display a dialog when the device's time is not synced, prompting the user to correct it:

```dart
import 'package:flutter/material.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

 // Show a dialog if time is not synchronized
  NtpTimeSyncChecker.showTimeSyncIssueDialog(
    context: context,
    onRetry: () {
        Navigator.pop(context);
        _validateTime();
    },
  );
```

---

### **4. Complete Example**

Here is a full example showcasing the package usage:

```dart
import 'package:flutter/material.dart';
import 'package:sync_time_ntp_totalxsoftware/sync_time_ntp_totalxsoftware.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTP Time Sync Example',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _status = "Not Checked";
  String _networkTime = "-";

  Future<void> _validateTime() async {
    bool isSynced = await NtpTimeSyncChecker.validateDeviceTime(
      toleranceInSeconds: 5,
    );
    setState(() {
      _status = isSynced ? "Time is synchronized" : "Time is NOT synchronized!";
    });

    if (!isSynced) {
      SyncTimeNTP.showTimeIssueDialog(
        context: context,
        onRetry: _validateTime,
      );
    }
  }

  Future<void> _fetchNetworkTime() async {
     DateTime? time = await NtpTimeSyncChecker.getNetworkTime();
    setState(() {
      _networkTime = time?.toString() ?? "Failed to fetch time";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NTP Time Sync Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Network Time: $_networkTime'),
            ElevatedButton(
              onPressed: _fetchNetworkTime,
              child: const Text('Fetch NTP Time'),
            ),
            const SizedBox(height: 20),
            Text('Status: $_status'),
            ElevatedButton(
              onPressed: _validateTime,
              child: const Text('Validate Device Time'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## **API Reference**

### `validateTime({int toleranceInSeconds = 5}) → Future<bool>`

- **Description**: Validates if the device's time is within a specified tolerance compared to the NTP server.
- **Parameters**:
  - `toleranceInSeconds`: The acceptable difference in seconds (default: `5` seconds).
- **Returns**: `true` if synchronized, otherwise `false`.

---

### `getNetworkTime() → Future<DateTime?>`

- **Description**: Fetches the current accurate time from an NTP server.
- **Returns**: A `DateTime` object with the network time or `null` on failure.

---

### `showTimeIssueDialog({required BuildContext context, required void Function() onRetry})`

- **Description**: Displays a dialog prompting the user to fix time synchronization issues.
- **Parameters**:
  - `context`: The widget context for displaying the dialog.
  - `onRetry`: A callback for retrying the time validation.

---

## **Supported Platforms**

- **Android**: Opens the date/time settings.
- **iOS**: Opens the date/time settings.

---

## Explore more about TotalX at www.totalx.in - Your trusted software development company!

<div style="display: flex; gap: 20px; justify-content: center; align-items: center; margin-top: 15px;"> <a href="https://www.youtube.com/channel/UCWysKlrrg4_a3W4Usw5MYKw" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" alt="YouTube" width="60" height="60"> <p style="text-align: center;">YouTube</p> </a> <a href="https://x.com/i/flow/login?redirect_after_login=%2FTOTALXsoftware" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="X (Twitter)" width="60" height="60"> <p style="text-align: center;">Twitter</p> </a> <a href="https://www.instagram.com/totalx.in/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384063.png" alt="Instagram" width="60" height="60"> <p style="text-align: center;">Instagram</p> </a> <a href="https://www.linkedin.com/company/total-x-softwares/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/145/145807.png" alt="LinkedIn" width="60" height="60"> <p style="text-align: center;">LinkedIn</p> </a> </div>

## 🌐 Connect with Totalx Software

Join the vibrant Flutter Firebase Kerala community for updates, discussions, and support:

<a href="https://t.me/Flutter_Firebase_Kerala" target="_blank" style="text-decoration: none;"> <img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" alt="Telegram" width="90" height="90"> <p><b>Flutter Firebase Kerala Totax</b></p> </a>
