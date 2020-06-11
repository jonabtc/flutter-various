import 'package:flutter/material.dart';

class Backdrop extends StatefulWidget {
  final Widget backPanel;
  final Widget frontPanel;
  final Widget frontPanelTittle;
  final TabBar tabBar;
  final TabBarView tabBarView;
  final double panelHeaderHeight;
  final BorderRadius borderRadius;
  final Function(AnimationStatus) onPressedLeading;
  final AnimatedIconData leadingIcon;
  final Duration duration;
  Backdrop({
    Key key,
    @required this.backPanel,
    @required this.frontPanel,
    this.frontPanelTittle,
    this.panelHeaderHeight = 32,
    this.onPressedLeading,
    this.leadingIcon,
    this.duration = const Duration(milliseconds: 100),
    this.borderRadius = const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0)),
  })  : assert(backPanel != null),
        assert(frontPanel != null),
        tabBar = null,
        tabBarView = null,
        super(key: key);
  Backdrop.tabBar({
    Key key,
    @required this.backPanel,
    @required this.tabBar,
    @required this.tabBarView,
    this.panelHeaderHeight = 32,
    this.onPressedLeading,
    this.leadingIcon,
    this.duration = const Duration(milliseconds: 100),
    this.borderRadius = const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0)),
  })  : assert(backPanel != null),
        assert(tabBar != null),
        assert(tabBarView != null),
        frontPanel = null,
        frontPanelTittle = null,
        super(key: key);

  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Function _onPressedLeading;
  AnimatedIconData _leadingIcon;
  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  void initState() {
    super.initState();
        _controller = AnimationController(
            duration: widget.duration, value: 1.0, vsync: this);
    _onPressedLeading = widget.onPressedLeading ?? () {};
    _leadingIcon = widget.leadingIcon ?? AnimatedIcons.close_menu;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - widget.panelHeaderHeight;
    final double bottom = -widget.panelHeaderHeight;
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData theme = Theme.of(context);
    return Container(
      color: theme.primaryColor,
      child: Stack(
        children: <Widget>[
          widget.backPanel,
          _buildFrontPage(animation),
        ],
      ),
    );
  }

  Widget _buildFrontPage(Animation<RelativeRect> animation) {
    if (widget.tabBar == null) {
      return PositionedTransition(
        rect: animation,
        child: Material(
          borderRadius: widget.borderRadius,
          elevation: 12.0,
          child: Column(children: <Widget>[
            Container(
                height: widget.panelHeaderHeight,
                child: widget.frontPanelTittle),
            Expanded(child: widget.frontPanel),
          ]),
        ),
      );
    } else {
      return PositionedTransition(
        rect: animation,
        child: Material(
          borderRadius: widget.borderRadius,
          elevation: 12.0,
          child: DefaultTabController(
            length: widget.tabBarView.children.length,
            child: Column(
              children: [
                widget.tabBar,
                Expanded(
                  child: widget.tabBarView,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            _controller
                .fling(velocity: _isPanelVisible ? -1.0 : 1.0)
                .then((_) => _onPressedLeading(_controller.status));
          },
          icon: AnimatedIcon(
            icon: _leadingIcon,
            progress: _controller.view,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
