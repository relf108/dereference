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

void main(List<String> args) {
  final parser = ArgParser()
    ..addFlag(
      'file',
      abbr: '-f',
      negatable: false,
      help: 'The .ris file to convert.',
    )
    //..addOption('prompt', abbr: 'p', help: 'The prompt to show the user.');

  final parsed = parser.parse(args);

  if (parsed.wasParsed('file')) {
    Settings().setVerbose(enabled: true);
  }

  if (!parsed.wasParsed('prompt')) {
    printerr(red('You must pass a prompt'));
    showUsage(parser);
  }

  final prompt = parsed['prompt'] as String;

  var valid = false;
  String response;
  do {
    response = ask('$prompt:', validator: Ask.all([Ask.alpha, Ask.required]));

    valid = confirm('Is this your response? ${green(response)}');
  } while (!valid);

  print(orange('Your response was: $response'));
}

/// Show useage.
void showUsage(ArgParser parser) {
  print('Usage: dereference.dart -v -prompt <a questions>');
  print(parser.usage);
  exit(1);
}
