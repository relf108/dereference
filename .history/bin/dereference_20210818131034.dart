#! /usr/bin/env dcli

import 'dart:io';

import 'package:args/args.dart';

// ignore: prefer_relative_imports
import 'package:dcli/dcli.dart';

/// dcli script generated by:
/// dcli create dereference.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

Future<void> main(List<String> args) async {
  var refFile = File('');
  refMap = {};
  final parser = ArgParser()
    ..addFlag(
      'file',
      abbr: 'f',
      negatable: false,
      help: 'The .ris file to convert.',
    );
  //..addOption('prompt', abbr: 'p', help: 'The prompt to show the user.');

  final parsed = parser.parse(args);

  if (parsed.wasParsed('file')) {
    try {
      refFile = File(parsed.arguments
          .firstWhere((element) => element.toString().contains('.ris'))
          .toString());
      print('passedFile');
    } on Exception catch (_) {
      print(red('Please pass a .ris file'));
      exit(1);
    }
  }
  var refLines = await refFile.readAsLines();
  for (var line in refLines) {}
}
