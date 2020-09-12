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
import 'package:masamune_core/masamune_core.dart';
import 'widget/dialog.dart';
import 'widget/mixin.dart';
export 'package:masamune_core/masamune_core.dart';
export 'widget/dialog.dart';
export 'widget/mixin.dart';
export 'widget/template.dart';
export 'widget/widget.dart';
export 'package:intl/intl.dart' show DateFormat;

part 'core/typedef.dart';
part 'core/defaultpath.dart';
part 'core/bootstrap.dart';

part 'theme/themecolor.dart';

part 'component/uimaterialapp.dart';
part 'component/widgetdata.dart';
part 'component/uipage.dart';
part 'component/extensions.dart';
part 'component/uiwidget.dart';
part 'component/uivalue.dart';

part 'key/uivaluekey.dart';
part 'key/uipagestoragekey.dart';

part 'route/extensions.dart';
part 'route/routeconfig.dart';
part 'route/uipageroute.dart';
part 'route/routequery.dart';
part 'route/uirouteobserver.dart';

part 'animation/uianimatorscenario.dart';
part 'animation/uianimatorunit.dart';

part 'model/unitmodel.dart';
part 'model/documentmodel.dart';
part 'model/collectionmodel.dart';
