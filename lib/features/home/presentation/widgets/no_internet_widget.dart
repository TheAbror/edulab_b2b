import 'package:leti_mobile/widget_imports.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,

    builder: (context) {
      return AlertDialog(
        title: const Text('No Internet Connection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.wifi_off, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Please check your internet connection and try again.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off, size: 64),
            SizedBox(height: 16),
            Text('No internet connection'),
          ],
        ),
      ),
    );
  }
}
