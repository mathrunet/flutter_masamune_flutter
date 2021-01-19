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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:masamune_core/masamune_core.dart';
import 'package:masamune/masamune.dart';
import 'package:meta/meta.dart';
export 'widget/dialog.dart';
export 'widget/mixin.dart';
export 'widget/template.dart';
export 'widget/widget.dart';
export 'package:masamune/masamune.dart';
export 'package:flutter/material.dart' hide Path, Listener;
export 'form/form.dart';
export 'list/list.dart';
export 'package:intl/intl.dart' show DateFormat;

part 'core/typedef.dart';
part 'core/defaultpath.dart';
part 'core/bootstrap.dart';

part 'component/extensions.dart';

part 'key/uivaluekey.dart';
part 'key/uipagestoragekey.dart';

part 'animation/uianimatorscenario.dart';
part 'animation/uianimatorunit.dart';
