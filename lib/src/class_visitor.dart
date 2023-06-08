import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ClassVisitor extends SimpleElementVisitor {
  DartType? className;
  // Map<String, DartType>? params = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;

    // List<ParameterElement> parameters = element.parameters;
    // for (int idx = 0; idx < parameters.length; idx++) {
    //   if (parameters[idx].name == 'key') continue;
    //   params![parameters[idx].name] = parameters[idx].type;
    // }
  }

  // @override
  // visitFieldElement(FieldElement element) {
  //   params![element.name] = element.type;
  // }
}
