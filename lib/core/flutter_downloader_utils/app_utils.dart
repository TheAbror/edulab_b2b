import 'package:edulab_b2b/gen/assets.gen.dart';

class AppUtils {
  static String getIconByfileType(String path) {
    final newPath = path.trim();

    final startIndex = newPath.lastIndexOf('.');

    String fileType = newPath.substring(startIndex + 1, newPath.length);

    final route = Assets.icons.downloader;

    switch (fileType) {
      case 'doc':
        return route.docx.path;
      case 'docx':
        return route.docx.path;
      case 'pdf':
        return route.pdf.path;
      case 'ppt':
        return route.ppt.path;
      case 'pptx':
        return route.ppt.path;
      case 'xlsx':
        return route.xlsx.path;
      case 'xls':
        return route.xlsx.path;
      case 'zip':
        return route.zip.path;
      default:
        return route.other.path;
    }
  }
}
