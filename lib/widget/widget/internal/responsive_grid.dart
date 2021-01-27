library responsive_grid;

import 'package:flutter/widgets.dart';

/// This script is a customized version of responsive_grid
/// [https://pub.dev/packages/responsive_grid].
/// For the source, see the corresponding page.
///
///
/// MIT License
///
/// Copyright (c) 2019 Mohamed Selim
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

double _refWidth = 375;

double _scalingFactor;
double _width;

void initScaling(BuildContext context) {
  var mq = MediaQuery.of(context);
  _width = mq.size.width < mq.size.height ? mq.size.width : mq.size.height;
  _scalingFactor = _width / _refWidth;

  print("width => $_width");
}

double scale(double dimension) {
  if (_width == null) {
    throw Exception("You must call init() before any use of scale()");
  }
  //
  return dimension * _scalingFactor;
}

//
// responsive grid layout
//

enum _GridTier { xs, sm, md, lg, xl }

_GridTier _currentSize(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  double width = mediaQueryData.size.width;

//  print(
//      "INFO orientation: ${mediaQueryData.orientation} , width: ${mediaQueryData.size.width}, height: ${mediaQueryData.size.height}");

  if (width < 576) {
    return _GridTier.xs;
  } else if (width < 768) {
    return _GridTier.sm;
  } else if (width < 992) {
    return _GridTier.md;
  } else if (width < 1200) {
    return _GridTier.lg;
  } else {
    // width >= 1200
    return _GridTier.xl;
  }
}

int _totalSegments = 12;

class ResponsiveGridRow extends StatelessWidget {
  final List<ResponsiveGridCol> children;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;

  ResponsiveGridRow(
      {@required this.children,
      this.rowMainAxisAlignment = MainAxisAlignment.center,
      this.rowCrossAxisAlignment = CrossAxisAlignment.start,
      this.columnMainAxisAlignment = MainAxisAlignment.start,
      this.columnCrossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = List<Widget>();

    int accumulatedWidth = 0;
    List<Widget> cols = List<Widget>();

    children.forEach((col) {
      var colWidth = col.currentConfig(context);
      //
      if (accumulatedWidth + colWidth > _totalSegments) {
        if (accumulatedWidth < _totalSegments) {
          cols.add(Spacer(
            flex: _totalSegments - accumulatedWidth,
          ));
        }
        rows.add(Row(
          children: cols,
        ));
        // clear
        cols = List<Widget>();
        accumulatedWidth = 0;
      }
      //
      cols.add(col);
      accumulatedWidth += colWidth;
    });

    if (accumulatedWidth >= 0) {
      if (accumulatedWidth < _totalSegments) {
        cols.add(Spacer(
          flex: _totalSegments - accumulatedWidth,
        ));
      }
      rows.add(Row(
        mainAxisAlignment: this.rowMainAxisAlignment,
        crossAxisAlignment: this.rowCrossAxisAlignment,
        children: cols,
      ));
    }

    return Column(
      mainAxisAlignment: this.columnMainAxisAlignment,
      crossAxisAlignment: this.columnCrossAxisAlignment,
      children: rows,
    );
  }
}

class ResponsiveGridCol extends StatelessWidget {
  final List<int> _config = new List(5);
  final Widget child;

  ResponsiveGridCol(
      {int xs = 12, int sm, int md, int lg, int xl, @required this.child}) {
    _config[_GridTier.xs.index] = xs;
    _config[_GridTier.sm.index] = sm ?? _config[_GridTier.xs.index];
    _config[_GridTier.md.index] = md ?? _config[_GridTier.sm.index];
    _config[_GridTier.lg.index] = lg ?? _config[_GridTier.md.index];
    _config[_GridTier.xl.index] = xl ?? _config[_GridTier.lg.index];
  }

  int currentConfig(BuildContext context) {
    return _config[_currentSize(context).index];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: currentConfig(context),
      child: child,
    );
  }
}

//
// responsive grid list
//

class ResponsiveGridList extends StatelessWidget {
  final double desiredItemWidth, minSpacing;
  final List<Widget> children;
  final bool squareCells, scroll;

  ResponsiveGridList(
      {this.desiredItemWidth = 1,
      this.minSpacing = 0,
      this.squareCells = false,
      this.scroll = true,
      this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (children.length == 0) return Container();

        double width = constraints.maxWidth;

        double N = (width - minSpacing) / (desiredItemWidth + minSpacing);

        int n;
        double spacing, itemWidth;

        if (N % 1 == 0) {
          n = N.floor();
          spacing = minSpacing;
          itemWidth = desiredItemWidth;
        } else {
          n = N.floor();

          double dw =
              width - (n * (desiredItemWidth + minSpacing) + minSpacing);

          itemWidth = desiredItemWidth +
              (dw / n) * (desiredItemWidth / (desiredItemWidth + minSpacing));

          spacing = (width - itemWidth * n) / (n + 1);
        }

        if (scroll) {
          return ListView.separated(
              itemCount: (children.length / n).ceil(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: minSpacing,
                );
              },
              itemBuilder: (context, index) {
                if (index * n >= children.length) return null;
                //
                var rowChildren = List<Widget>();
                for (int i = index * n; i < (index + 1) * n; i++) {
                  if (i >= children.length) break;
                  rowChildren.add(children[i]);
                }
                return _ResponsiveGridListItem(
                  itemWidth: itemWidth,
                  spacing: spacing,
                  squareCells: squareCells,
                  children: rowChildren,
                );
              });
        } else {
          var rows = List<Widget>();
          rows.add(SizedBox(
            height: minSpacing,
          ));
          //
          for (int j = 0; j < (children.length / n).ceil(); j++) {
            var rowChildren = List<Widget>();
            //
            for (int i = j * n; i < (j + 1) * n; i++) {
              if (i >= children.length) break;
              rowChildren.add(children[i]);
            }
            //
            rows.add(_ResponsiveGridListItem(
              itemWidth: itemWidth,
              spacing: spacing,
              squareCells: squareCells,
              children: rowChildren,
            ));

            rows.add(SizedBox(
              height: minSpacing,
            ));
          }

          return Column(
            children: rows,
          );
        }
      },
    );
  }
}

class _ResponsiveGridListItem extends StatelessWidget {
  final double spacing, itemWidth;
  final List<Widget> children;
  final bool squareCells;

  _ResponsiveGridListItem(
      {this.itemWidth, this.spacing, this.squareCells, this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    var list = List<Widget>();

    list.add(SizedBox(
      width: spacing,
    ));

    children.forEach((child) {
      list.add(SizedBox(
        width: itemWidth,
        height: squareCells ? itemWidth : null,
        child: child,
      ));
      list.add(SizedBox(
        width: spacing,
      ));
    });

    return list;
  }
}
