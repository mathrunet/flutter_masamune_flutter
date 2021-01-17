// Copyright 2020 mathru. All rights reserved.

/// Masamune flutter framework library.
///
/// To use, import `package:masamune_flutter/masamune_flutter.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library masamune.flutter;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:flutter_widget_model/flutter_widget_model.dart';
import 'widget/dialog.dart';
import 'widget/mixin.dart';
import 'package:riverpod/src/framework.dart';
import 'package:meta/meta.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:masamune_core/masamune_core.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:riverpod/riverpod.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'widget/dialog.dart';
export 'widget/mixin.dart';
export 'widget/template.dart';
export 'widget/widget.dart';
export 'package:flutter/material.dart' hide Path, Listener;
export 'form/form.dart';
export 'list/list.dart';
export 'package:intl/intl.dart' show DateFormat;
export 'package:flutter_widget_model/flutter_widget_model.dart';

part 'core/typedef.dart';
part 'core/defaultpath.dart';
part 'core/bootstrap.dart';

part 'theme/themecolor.dart';

part 'component/uimaterialapp.dart';
part 'component/uipage.dart';
part 'component/extensions.dart';
part 'component/uiwidget.dart';
// part 'component/widgetdata.dart';
// part 'component/uivalue.dart';

// part 'component/uihookwidget.dart';
// part 'component/uihookpage.dart';
part 'component/uiinternalpage.dart';

part 'key/uivaluekey.dart';
part 'key/uipagestoragekey.dart';

part 'route/dataconfig.dart';
part 'route/extensions.dart';
part 'route/routeconfig.dart';
part 'route/uipageroute.dart';
part 'route/routequery.dart';
part 'route/uirouteobserver.dart';

part 'animation/uianimatorscenario.dart';
part 'animation/uianimatorunit.dart';

part 'hooks/pagedocumenthook.dart';
// part 'hooks/pathhook.dart';

part 'provider/pathprovider.dart';
part 'provider/datafieldprovider.dart';
part 'provider/runtimedocumentprovider.dart';
part 'provider/runtimecollectionprovider.dart';
part 'provider/localdocumentprovider.dart';
part 'provider/localcollectionprovider.dart';
