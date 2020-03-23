// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:dart_cricket/services/router.dart';
import 'package:dart_cricket/services/module_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ModuleContainer.configure();
  await ModuleContainer.initialize();

  try {
    runApp(MaterialApp(
        initialRoute: Router.initialRoute(),
        onGenerateRoute: Router.generateRoute
    ));
  } catch(err) {
    print('$err');
  }
}