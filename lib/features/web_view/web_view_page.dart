import 'package:edulab_b2b/widget_imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
      Uri.parse(
        'https://test.edulab.uz/uploads/media/articulate/sources/660/662/rus/703/index.html#/',
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBarBackButton(),
            Spacer(),
            GestureDetector(
              onTap: () {
                showChatBottomSheet(context);
              },
              child: Assets.icons.chat.chat.svg(
                colorFilter: ColorFilter.mode(
                  context.colors.fgDefault,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
