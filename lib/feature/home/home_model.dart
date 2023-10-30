import '../../base/base_page_view_model.dart';
import '../../generated/l10n.dart';

class HomeViewModel extends BasePageViewModel {
  late S delegate;

  String _text = "Stop Service";
  String get text => _text;
  set text(String value) {
    _text = value;
    notify();
  }

  // HomeViewModel() {}

  @override
  void dispose() {
    super.dispose();
  }
}
