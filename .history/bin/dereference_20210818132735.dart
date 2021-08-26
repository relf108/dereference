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
      refFile = File(
          '${Directory.current.path}/${parsed.arguments.firstWhere((element) => element.toString().contains('fdsashkjfdjakl;'))}');
      refLines = await refFile.readAsLines();
      print('passedFile');
    } on FileSystemException catch (_) {
      print(red('The passed in file could not be found, make sure it exists and is readable.'));
    } on StateError catch (_) {
      print(red('Please pass a .ris file'));
      exit(2);
    }
  }
  for (var line in refLines) {
    final key = line.split('-')[0].trim();
    final value = line.split('-')[1].trim();

    refMap.addEntries({MapEntry(key, value)});
  }
}
