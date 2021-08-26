#! /usr/bin/env dcli

import 'dart:io';

import 'package:args/args.dart';

import 'package:dcli/dcli.dart';

Future<void> main(List<String> args) async {
  var refFile = File('');
  var refLines;
  final refMap = {};
  final parser = ArgParser()
    ..addFlag(
      'file',
      abbr: 'f',
      negatable: false,
      help: 'The .ris file to convert.',
    );

  final parsed = parser.parse(args);

  if (parsed.wasParsed('file')) {
    try {
      refFile = File('${Directory.current}/${parsed.arguments.firstWhere((element) => element.toString().contains('.ris'))}');
      print('passedFile');
    } on Exception catch (_) {
      print(red('Please pass a .ris file'));
      exit(1);
    }
  }
  for (var line in refLines) {
    final key = line.split('-')[0].trim();
    final value = line.split('-')[1].trim();

    refMap.addEntries({MapEntry(key, value)});
  }
}
