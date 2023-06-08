import 'dart:io';

import 'package:fy_snippet_generator/fy_snippet_generator.dart';
import 'package:fy_snippet_generator/src/fy_annotated_class.dart';

class CodeGenerator {
  String modifyComment = """
/*
----------------------------------------------------------------------------------
|  This file is generated automatically by FSG. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/
""";

  String fsgPackageImport =
      "import 'package:fy_snippet_generator/fy_snippet_generator.dart';";

  String annotatedClassImports(
    List<FyAnnotatedClass> dxAnnonatedClasses,
  ) {
    Set<String> uniqueImports = {};
    StringBuffer importsBuffer = StringBuffer();
    for (int idx = 0; idx < dxAnnonatedClasses.length; idx++) {
      uniqueImports.add(dxAnnonatedClasses[idx].importPath);
    }
    for (int idx = 0; idx < uniqueImports.length; idx++) {
      importsBuffer.writeln(uniqueImports.elementAt(idx));
    }

    return importsBuffer.toString();
  }

  String generate(List<FyAnnotatedClass> fyAnnonatedClasses) {
    return '''
     $modifyComment
     
     ${_generateFSGCodeClass(fyAnnonatedClasses)}
      ''';
  }

  String _generateFSGCodeClass(List<FyAnnotatedClass> fyAnnonatedClasses) {
    StringBuffer codeBuffer = StringBuffer();
    codeBuffer.writeln('class FSGCode {');
    codeBuffer.write('static String? getCodeByType<T>() {');
    codeBuffer.writeln('String type = T.toString();');
    for (int idx = 0; idx < fyAnnonatedClasses.length; idx++) {
      String className = fyAnnonatedClasses[idx].className;
      String codeSample = fyAnnonatedClasses[idx].codeSample;

      codeBuffer.writeln('if(type == "$className") {');
      codeBuffer.writeln("return '''");
      codeBuffer.writeln(codeSample);
      codeBuffer.write("''';");
      codeBuffer.writeln('}');
    }
    codeBuffer.writeln('return  null;');
    codeBuffer.writeln('}');
    codeBuffer.writeln('}');
    return codeBuffer.toString();
  }
}
