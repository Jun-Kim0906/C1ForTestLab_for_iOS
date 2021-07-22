import 'package:class1_for_integration_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  String studentID = '22000694';
  String name = 'Jung JuYoung';
  testWidgets('Set AppBar Title to Name', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(MyApp());

    expect(find.widgetWithText(AppBar, '$studentID $name'), findsOneWidget);
  });

  testWidgets('Set AppBar Background Color', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    Color? bgColor =
        (tester.firstWidget(find.byType(AppBar)) as AppBar).backgroundColor;
    if (bgColor != null) {
      expect(bgColor, equals(Colors.blue.shade100));
    } else {
      expect(Theme.of(tester.element(find.byType(AppBar))).primaryColor,
          equals(Colors.blue.shade100));
    }
  });

  testWidgets('Icon is in \"leading\" position', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    ListTile tile = tester.firstWidget(find.byType(ListTile)) as ListTile;

    expect(tile.leading.runtimeType, equals(Icon));
  });

  testWidgets('Icon is yellow and star, not red and heart', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.widgetWithIcon(ListTile, Icons.star_border).first);

    await tester.pumpAndSettle();

    Icon? tileIcon = (tester.firstWidget(find.byType(ListTile).at(0)) as ListTile).leading as Icon;

    expect(tileIcon.color, equals(Colors.yellow));
    expect(tileIcon.icon, equals(Icons.star));
  });

  ///scroll 이어지는지
  ///tap한 listTile이 저장 되어 있는가
  testWidgets('All the example codes must be completed',(WidgetTester tester) async {
    List<String> prev = [];
    List<String> cur = [];
    await tester.pumpWidget(MyApp());

    ListTile tile = tester.firstWidget(find.widgetWithIcon(ListTile, Icons.star_border).first) as ListTile;

    Iterable<ListTile> tiles = tester.widgetList(find.byType(ListTile));

    tiles.forEach((element) {
      prev.add((element.title as Text).data!);
      print((element.title as Text).data!);
    });


    print(tiles.length);

    await tester.tap(find.widgetWithIcon(ListTile, Icons.star_border).first);

    await tester.pumpAndSettle();

    for(int i = 0; i<2;i++){
      await tester.drag(find.byType(ListView), Offset(0.0, -1000.0));

      await tester.pumpAndSettle();

      Iterable<ListTile> tiles2 = tester.widgetList(find.byType(ListTile));

      tiles2.forEach((element) {
        cur.add((element.title as Text).data!);
        print((element.title as Text).data!);
      });
      print('length : ${tiles2.length}');

      if(prev==cur){
        print('same');
        throw Exception('Fail to Get New List Items');
      }else{
        print('different');
      }

      print(cur);
      print(prev);

      prev.clear();

      prev = new List<String>.from(cur);

      cur.clear();
    }

    await tester.tap(find.widgetWithIcon(IconButton, Icons.list).first);


    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, (tile.title as Text).data!), findsOneWidget);


  });
}
//
// class AppBarByColorFinder extends MatchFinder {
//   AppBarByColorFinder(this.color, this.primaryColor, {bool skipOffstage = true})
//       : super(skipOffstage: skipOffstage);
//
//   final Color color;
//   final Color primaryColor;
//
//   @override
//   String get description => 'AppBar{color: "$color"}';
//
//   @override
//   bool matches(Element candidate) {
//     if (candidate.widget is AppBar) {
//       final AppBar appBarWidget = candidate.widget as AppBar;
//       if (appBarWidget.backgroundColor != null) {
//         return appBarWidget.backgroundColor == color;
//       } else {
//         return primaryColor == color;
//       }
//     }
//     return false;
//   }
// }