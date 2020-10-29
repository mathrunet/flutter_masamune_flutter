import 'package:flutter/material.dart';
import 'package:masamune_flutter/masamune_flutter.dart';
import 'package:masamune_flutter/widget/mixin/uipagesearchmixin.dart';

/// Page template for creating a page for search.
abstract class UIHookPageSearch extends UIHookPageScaffold
    with UIPageSearchMixin {}
