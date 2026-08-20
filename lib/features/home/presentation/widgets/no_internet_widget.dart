import 'package:edulab_b2b/widget_imports.dart';

Future showNoInternetDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,

    builder: (context) {
      return AlertDialog(
        title: Text(context.localizations.noInternetC),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(context.localizations.pleaseCheck),
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
          children: [
            Icon(Icons.wifi_off, size: 64),
            SizedBox(height: 16),
            Text(context.localizations.noInternetC),
          ],
        ),
      ),
    );
  }
}
