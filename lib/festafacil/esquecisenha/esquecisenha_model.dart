import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'esquecisenha_widget.dart' show EsquecisenhaWidget;
import 'package:flutter/material.dart';

class EsquecisenhaModel extends FlutterFlowModel<EsquecisenhaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
