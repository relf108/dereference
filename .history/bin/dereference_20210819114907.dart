#! /usr/bin/env dcli

import 'dart:io';

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
          '${Directory.current.path}/${parsed.arguments.firstWhere((element) => element.toString().contains('.ris'))}');
      refLines = await refFile.readAsLines();
    } on FileSystemException catch (_) {
      echo(red(
          'The passed in file could not be found, make sure it exists and is readable.'));
      exit(1);
    } on StateError catch (_) {
      echo(red('Please pass a .ris file'));
      exit(2);
    }
  }
  for (var line in refLines) {
    final key = line.split('-')[0].trim();
    var value = '';
    if (line.split('-').length > 1) {
      value = line.split('-')[1].trim();
    }
    if (refMap.containsKey(key)) {
      if (key == 'AU') {
        refMap.update(key, (curentVal) => curentVal += '. $value');
      } else {
        refMap.update(key, (curentVal) => curentVal += ', $value');
      }
    } else {
      refMap.addAll({key: value});
    }
  }
  var AU = [];
  var PY = [];
  var T1 = [];
  var T2 = [];
  var JF = [];
  var SP = [];
  var BT = [];
  var UR = [];
  for (var entry in refMap.entries) {
    switch (entry.key) {
      case 'AU':
        {
          AU.add(entry.value);
          break;
        }
      case 'PY':
        {
          PY.add(entry.value);
          break;
        }
      case 'T1':
        {
          T1.add(entry.value);
          break;
        }
      case 'T2':
        {
          T2.add(entry.value);
          break;
        }
      case 'JF':
        {
          JF.add(entry.value);
          break;
        }
      case 'BT':
        {
          BT.add(entry.value);
          break;
        }
      case 'SP':
        {
          SP.add(entry.value);
          break;
        }
      case 'UR':
        {
          UR.add(entry.value);
          break;
        }
    }
  }

  String formatDate() {
    final date = DateTime.now().toLocal();
    return '${date.day}/${date.month}/${date.year}';
  }
  if(T2.isEmpty)
  var result =
      '$AU. $PY, "$T1", $T2, $JF, $BT, $SP, viewed ${formatDate()}, <$UR>.'
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(RegExp(' {2}'), ' ')
          .replaceAll(' ,', '');
  echo(result);
}
