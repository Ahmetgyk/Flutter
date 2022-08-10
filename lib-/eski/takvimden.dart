import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(title: Text('test')),
        body: Center(child: OverlayButton()),
      ),
    );
  }
}

class OverlayButton extends StatefulWidget {
  @override
  _OverlayButtonState createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<OverlayButton> {
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _overlayIsShown = false;

  @override
  void dispose() {
    super.dispose();
    if (_overlayIsShown) {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayIsShown) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
    _overlayIsShown = true;
  }

  void _hideOverlay() {
    _overlayIsShown = false;
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1000,
        child: SizedBox(
          height: 50,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: RaisedButton(child: Text('Open Overlay'), onPressed: _showOverlay),
          ),
        ),
      )
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var anchorSize = renderBox.size;
    return OverlayEntry(builder: (context) {
      // TODO: dynamically use the correct child width / height for
      // positioning us correctly on top + centered on the anchor
      var childWidth = 10.0;
      var childHeight = 80.0;
      var childOffset =
      Offset(childWidth, -(childHeight));
      return CompositedTransformFollower(
        link: _layerLink,
        offset: childOffset,
        child: Row(
          children: [
            RaisedButton(
              child: Text('close'),
              onPressed: _hideOverlay,
            ),
            RaisedButton(
              child: Text('close'),
              onPressed: _hideOverlay,
            ),
            RaisedButton(
              child: Text('close'),
              onPressed: _hideOverlay,
            ),
            RaisedButton(
              child: Text('close'),
              onPressed: _hideOverlay,
            ),
          ],
        )
      );
    });
  }
}