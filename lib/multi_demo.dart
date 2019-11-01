
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';



// class ExampleScreen extends StatefulWidget {
//   @override
//   _ExampleScreenState createState() => _ExampleScreenState();
// }

// class _ExampleScreenState extends State<ExampleScreen> {
//   final colors = <MaterialColor>[];

//   var _selection = MultiChildSelection.empty;

//   @override
//   void initState() {
//     super.initState();
//     colors.addAll(Colors.primaries);
//     colors.addAll(Colors.primaries);
//     colors.addAll(Colors.primaries);
//     colors.addAll(Colors.primaries);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MultiSelectAppBar(
//         appBar: AppBar(
//           title: Text('Multi Select Example'),
//         ),
//         selection: _selection,
//         selectingActions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: MultiSelectGridView(
//         onSelectionChanged: (selection) => setState(() => _selection = selection),
//         padding: EdgeInsets.all(8.0),
//         itemCount: colors.length,
//         itemBuilder: (BuildContext context, int index, bool selected) {
//           return ExampleChildItem(
//             index: index,
//             color: colors[index],
//             selected: selected,
//           );
//         },
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//       ),
//     );
//   }
// }

// class ExampleChildItem extends StatefulWidget {
//   const ExampleChildItem({
//     Key key,
//     @required this.index,
//     @required this.color,
//     @required this.selected,
//   }) : super(key: key);

//   final int index;
//   final MaterialColor color;
//   final bool selected;

//   @override
//   _ExampleChildItemState createState() => _ExampleChildItemState();
// }

// class _ExampleChildItemState extends State<ExampleChildItem> with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       value: widget.selected ? 1.0 : 0.0,
//       duration: kThemeChangeDuration,
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.ease,
//     ));
//   }

//   @override
//   void didUpdateWidget(ExampleChildItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected) {
//       if (widget.selected) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (BuildContext context, Widget child) {
//         final color = Color.lerp(widget.color.shade500, widget.color.shade900, _controller.value);
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: DecoratedBox(
//             decoration: BoxDecoration(color: color),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         alignment: Alignment.center,
//         child: Text(
//           '${widget.index}',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22.0,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MultiSelectAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const MultiSelectAppBar({
//     Key key,
//     this.appBar,
//     this.selection = MultiChildSelection.empty,
//     this.selectingActions,
//   })  : assert(selection != null),
//         super(key: key);

//   final AppBar appBar;
//   final MultiChildSelection selection;
//   final List<Widget> selectingActions;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: appBar.backgroundColor ?? AppBarTheme.of(context).color ?? Theme.of(context).primaryColor,
//       child: AnimatedSwitcher(
//         duration: kThemeAnimationDuration,
//         child: !selection.selecting
//             ? appBar
//             : AppBar(
//                 key: Key('multi-select'),
//                 leading: const BackButton(),
//                 titleSpacing: 0.0,
//                 title: Text('${selection.total} items selected…'),
//                 actions: selectingActions,
//               ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => appBar.preferredSize;
// }

// typedef MultiSelectWidgetBuilder = Widget Function(BuildContext context, int index, bool selected);
// typedef MultiSelectSelectionCb = void Function(MultiChildSelection selection);

// class MultiSelectGridView extends StatefulWidget {
//   const MultiSelectGridView({
//     Key key,
//     this.onSelectionChanged,
//     this.padding,
//     @required this.itemCount,
//     @required this.itemBuilder,
//     @required this.gridDelegate,
//     this.scrollPadding = const EdgeInsets.all(48.0),
//   }) : super(key: key);

//   final MultiSelectSelectionCb onSelectionChanged;
//   final EdgeInsetsGeometry padding;
//   final int itemCount;
//   final MultiSelectWidgetBuilder itemBuilder;
//   final SliverGridDelegate gridDelegate;
//   final EdgeInsets scrollPadding;

//   @override
//   _MultiSelectGridViewState createState() => _MultiSelectGridViewState();
// }

// class _MultiSelectGridViewState extends State<MultiSelectGridView> {
//   final _elements = List<_MultiSelectChildElement>();

//   bool _isSelecting = false;
//   int _startIndex = -1;
//   int _endIndex = -1;

//   LocalHistoryEntry _historyEntry;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapUp: _onTapUp,
//       onLongPressStart: _onLongPressStart,
//       onLongPressMoveUpdate: _onLongPressUpdate,
//       onLongPressEnd: _onLongPressEnd,
//       child: IgnorePointer(
//         ignoring: _isSelecting,
//         child: GridView.builder(
//           padding: widget.padding,
//           itemCount: widget.itemCount,
//           itemBuilder: (BuildContext context, int index) {
//             final start = (_startIndex < _endIndex) ? _startIndex : _endIndex;
//             final end = (_startIndex < _endIndex) ? _endIndex : _startIndex;
//             final selected = (index >= start && index <= end);
//             return _MultiSelectChild(
//               index: index,
//               child: widget.itemBuilder(context, index, selected),
//             );
//           },
//           gridDelegate: widget.gridDelegate,
//         ),
//       ),
//     );
//   }

//   void _onTapUp(TapUpDetails details) {
//     _setSelection(-1, -1);
//     _updateLocalHistory();
//   }

//   void _onLongPressStart(LongPressStartDetails details) {
//     final startIndex = _findMultiSelectChildFromOffset(details.localPosition);
//     _setSelection(startIndex, startIndex);
//     setState(() => _isSelecting = (startIndex != -1));
//   }

//   void _onLongPressUpdate(LongPressMoveUpdateDetails details) {
//     if (_isSelecting) {
//       _updateEndIndex(details.localPosition);
//     }
//   }

//   void _onLongPressEnd(LongPressEndDetails details) {
//     _updateEndIndex(details.localPosition);
//     setState(() => _isSelecting = false);
//   }

//   void _updateEndIndex(Offset localPosition) {
//     final endIndex = _findMultiSelectChildFromOffset(localPosition);
//     if (endIndex != -1) {
//       _setSelection(_startIndex, endIndex);
//       _updateLocalHistory();
//     }
//   }

//   void _setSelection(int start, int end) {
//     setState(() {
//       _startIndex = start;
//       _endIndex = end;
//     });
//     if (widget.onSelectionChanged != null) {
//       final start = (_startIndex < _endIndex) ? _startIndex : _endIndex;
//       final end = (_startIndex < _endIndex) ? _endIndex : _startIndex;
//       final total = (start != -1 && end != -1) ? ((end + 1) - start) : 0;
//       widget.onSelectionChanged?.call(MultiChildSelection(total, start, end));
//     }
//   }

//   void _updateLocalHistory() {
//     final route = ModalRoute.of(context);
//     if (route != null) {
//       if (_startIndex != -1 && _endIndex != -1) {
//         if (_historyEntry == null) {
//           _historyEntry = LocalHistoryEntry(
//             onRemove: () {
//               _setSelection(-1, -1);
//               _historyEntry = null;
//             },
//           );
//           route.addLocalHistoryEntry(_historyEntry);
//         }
//       } else {
//         if (_historyEntry != null) {
//           route.removeLocalHistoryEntry(_historyEntry);
//           _historyEntry = null;
//         }
//       }
//     }
//   }

//   int _findMultiSelectChildFromOffset(Offset offset) {
//     final ancestor = context.findRenderObject();
//     for (_MultiSelectChildElement element in List.from(_elements)) {
//       if (element.containsOffset(ancestor, offset)) {
//         if (widget.scrollPadding != null) {
//           element.showOnScreen(widget.scrollPadding);
//         }
//         return element.widget.index;
//       }
//     }
//     return -1;
//   }
// }

// class _MultiSelectChild extends ProxyWidget {
//   const _MultiSelectChild({
//     Key key,
//     @required this.index,
//     @required Widget child,
//   }) : super(key: key, child: child);

//   final int index;

//   @override
//   _MultiSelectChildElement createElement() => _MultiSelectChildElement(this);
// }

// class _MultiSelectChildElement extends ProxyElement {
//   _MultiSelectChildElement(_MultiSelectChild widget) : super(widget);

//   @override
//   _MultiSelectChild get widget => super.widget;

//   _MultiSelectGridViewState _ancestorState;

//   @override
//   void mount(Element parent, newSlot) {
//     super.mount(parent, newSlot);
//     _ancestorState = ancestorStateOfType(TypeMatcher<_MultiSelectGridViewState>());
//     _ancestorState?._elements?.add(this);
//   }

//   @override
//   void unmount() {
//     _ancestorState?._elements?.remove(this);
//     _ancestorState = null;
//     super.unmount();
//   }

//   bool containsOffset(RenderObject ancestor, Offset offset) {
//     final RenderBox box = renderObject;
//     final rect = box.localToGlobal(Offset.zero, ancestor: ancestor) & box.size;
//     return rect.contains(offset);
//   }

//   void showOnScreen(EdgeInsets scrollPadding) {
//     final RenderBox box = renderObject;
//     box.showOnScreen(
//       rect: scrollPadding.inflateRect(Offset.zero & box.size),
//       duration: const Duration(milliseconds: 150),
//     );
//   }

//   @override
//   void notifyClients(ProxyWidget oldWidget) {
//     //
//   }
// }

// class MultiChildSelection {
//   const MultiChildSelection(this.total, this.start, this.end);

//   static const empty = MultiChildSelection(0, -1, -1);

//   final int total;
//   final int start;
//   final int end;

//   bool get selecting => total != 0;

//   @override
//   String toString() => 'MultiChildSelection{$total, $start, $end}';
// }
