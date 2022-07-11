import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:southwind/component/navigationtheme.dart';

class FFNavigationBar extends StatefulWidget {
  final Function onSelectTab;
  final List<FFNavigationBarItem> items;
  final FFNavigationBarTheme theme;

  final int selectedIndex;

  FFNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    required this.onSelectTab,
    required this.items,
    required this.theme,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onSelectTab != null);
  }

  @override
  _FFNavigationBarState createState() =>
      _FFNavigationBarState(selectedIndex: selectedIndex);
}

class _FFNavigationBarState extends State<FFNavigationBar> {
  int selectedIndex;
  _FFNavigationBarState({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final FFNavigationBarTheme theme = widget.theme;
    final bgColor = theme.barBackgroundColor;

    return MultiProvider(
      providers: [
        Provider<FFNavigationBarTheme>.value(value: theme),
        Provider<int>.value(value: widget.selectedIndex),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: theme.barHeight,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.items.map((item) {
                var index = widget.items.indexOf(item);
                item.setIndex(index);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onSelectTab(index);
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width /
                          widget.items.length,
                      height: theme.barHeight,
                      child: item,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class FFNavigationBarItem extends StatelessWidget {
  final String? label;
  final IconData? iconData;
  final Duration animationDuration;
  Color? selectedBackgroundColor;
  Color? selectedForegroundColor;
  Color? selectedLabelColor;

  late int index;
  late int selectedIndex;
  late FFNavigationBarTheme theme;
  late bool showSelectedItemShadow;
  double itemWidth;

  void setIndex(int index) {
    this.index = index;
  }

  Color _getDerivedBorderColor() {
    return theme.selectedItemBorderColor;
  }

  Color _getBorderColor(bool isOn) {
    return isOn ? _getDerivedBorderColor() : Colors.transparent;
  }

  bool _isItemSelected() {
    return index == selectedIndex;
  }

  static const kDefaultAnimationDuration = Duration(milliseconds: 1500);

  FFNavigationBarItem({
    Key? key,
    this.label,
    this.itemWidth = 60,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedLabelColor,
    this.iconData,
    this.animationDuration = kDefaultAnimationDuration,
  }) : super(key: key);

  Center _makeLabel(String label) {
    bool isSelected = _isItemSelected();
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isSelected
              ? theme.selectedItemTextStyle.fontSize
              : theme.unselectedItemTextStyle.fontSize,
          fontWeight: isSelected
              ? theme.selectedItemTextStyle.fontWeight
              : theme.unselectedItemTextStyle.fontWeight,
          color: isSelected
              ? selectedLabelColor ?? theme.selectedItemLabelColor
              : theme.unselectedItemLabelColor,
          // letterSpacing: isSelected ? 1.1 : 1.0,
        ),
      ),
    );
  }

  Widget _makeIconArea(double itemWidth, IconData iconData) {
    bool isSelected = _isItemSelected();
    double radius = itemWidth / 2;
    double innerBoxSize = itemWidth - 8;
    double innerRadius = (itemWidth - 8) / 2 - 4;

    return CircleAvatar(
      radius: isSelected ? radius : radius * 0.7,
      backgroundColor: _getBorderColor(isSelected),
      child: SizedBox(
        width: innerBoxSize,
        height: isSelected ? innerBoxSize : innerBoxSize / 2,
        child: CircleAvatar(
          radius: innerRadius,
          backgroundColor: isSelected
              ? selectedBackgroundColor ?? theme.selectedItemBackgroundColor
              : theme.unselectedItemBackgroundColor,
          child: _makeIcon(iconData),
        ),
      ),
    );
  }

  Widget _makeIcon(
    IconData iconData,
  ) {
    bool isSelected = _isItemSelected();
    return Icon(
      iconData,
      color: isSelected
          ? selectedForegroundColor ?? theme.selectedItemIconColor
          : theme.unselectedItemIconColor,
    );
  }

  Widget _makeShadow() {
    bool isSelected = _isItemSelected();
    double height = isSelected ? 4 : 0;
    double width = isSelected ? itemWidth + 6 : 0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(itemWidth / 2, 2)),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<FFNavigationBarTheme>(context);
    showSelectedItemShadow = theme.showSelectedItemShadow;
    itemWidth = theme.itemWidth;
    selectedIndex = Provider.of<int>(context);

    selectedBackgroundColor =
        selectedBackgroundColor ?? theme.selectedItemBackgroundColor;
    selectedForegroundColor =
        selectedForegroundColor ?? theme.selectedItemIconColor;
    selectedLabelColor = selectedLabelColor ?? theme.selectedItemLabelColor;

    bool isSelected = _isItemSelected();
    double itemHeight = itemWidth - 20;
    double topOffset = isSelected ? -20 : -10;
    double iconTopSpacer = isSelected ? 0 : 2;
    double shadowTopSpacer = 4;

    Widget labelWidget = _makeLabel(label!);
    Widget iconAreaWidget = _makeIconArea(itemWidth, iconData!);
    Widget shadowWidget = showSelectedItemShadow ? _makeShadow() : Container();

    return AnimatedContainer(
      width: itemWidth,
      height: double.maxFinite,
      duration: animationDuration,
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: Stack(
          clipBehavior: Clip.none,
          // overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: topOffset,
              left: -itemWidth / 2,
              right: -itemWidth / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: iconTopSpacer),
                  iconAreaWidget,
                  labelWidget,
                  SizedBox(height: shadowTopSpacer),
                  shadowWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
