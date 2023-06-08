library fy_snippet_generator;

import 'dart:async';
import 'dart:io';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:fy_snippet_generator/src/annotations.dart';
import 'package:fy_snippet_generator/src/fy_annotated_class.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as path;

import 'class_visitor.dart';
import 'code_generator.dart';
import 'logger.dart';

class FySnipperBuilder extends Builder {
  BuilderOptions? builderOptions;
  FySnipperBuilder(this.builderOptions);

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['fy_gen/sample.fsg.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    List<FyAnnotatedClass> annotatedClasses =
        await _getFyAnnotatedClasses(buildStep);

    CodeGenerator codeGenerator = CodeGenerator();

    String code = codeGenerator.generate(annotatedClasses);

    AssetId routesFile = AssetId(buildStep.inputId.package,
        path.join('lib', 'fy_gen', 'sample.fsg.dart'));
    await buildStep.writeAsString(routesFile, code);
    Logger.log(
      "Generated code successfully ==> (lib/fy_gen/sample.fsg.dart)",
      loggerColor: LoggerColor.green,
    );
  }

  Future<List<FyAnnotatedClass>> _getFyAnnotatedClasses(
      BuildStep buildStep) async {
    Glob glob = Glob('lib/**.dart');
    List<AssetId> assets = await buildStep.findAssets(glob).toList();
    List<FyAnnotatedClass> fyAnnotatedClasses = [];
    for (int idx = 0; idx < assets.length; idx++) {
      LibraryElement libraryElement =
          await _getLibraryElement(buildStep, assets[idx]);
      LibraryReader libraryReader = LibraryReader(libraryElement);

      List<AnnotatedElement> annotatedElements = libraryReader
          .annotatedWith(const TypeChecker.fromRuntime(GenerateSampleCode))
          .toList();

      for (var ele in annotatedElements) {
        ClassVisitor dxRouteClassVisior = ClassVisitor();
        ele.element.visitChildren(dxRouteClassVisior);
        FyAnnotatedClass dxAnnonatedClass = FyAnnotatedClass(
          className: dxRouteClassVisior.className.toString(),
          importPath:
              "import 'package:${assets[idx].path.replaceAll('lib', assets[idx].package)}';",
          relativePath: assets[idx].path,
          codeSample: File(assets[idx].path)
              .readAsStringSync()
              .replaceAll('@GenerateSampleCode()', ''),
        );

        fyAnnotatedClasses.add(dxAnnonatedClass);
      }
    }

    return fyAnnotatedClasses;
  }

  Future<LibraryElement> _getLibraryElement(
      BuildStep buildStep, AssetId assetId) async {
    return await buildStep.resolver.libraryFor(assetId);
  }
}
