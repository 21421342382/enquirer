import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/validation_mixin.dart';
import 'package:okito/okito.dart';

class BaseController extends OkitoController with ToastMixin, ValidationMixin {
  LoadingState state = LoadingState.loading;

  set loadingState(LoadingState state) {
    setState(() {
      this.state = state;
    });
  }
}
