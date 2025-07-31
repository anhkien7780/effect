import 'package:flutter/material.dart';

class LocationListItem extends StatelessWidget {
  LocationListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.country,
  });

  final GlobalKey _backgroundImageKey = GlobalKey();

  final String imageUrl;
  final String name;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(imageUrl, fit: BoxFit.cover, key: _backgroundImageKey),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            country,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  void paintChildren(FlowPaintingContext context) {
    // Tìm RenderBox của SingleChildrenListView
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    // Tìm RenderBox của LocationListItem ở trong SingleChildListView đó
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    // Từ đoạ độ cục bộ RenderBox của LocationListItem,
    // ta tìm toạ độ trung điểm bên trái của nó ở bên ngoài SingleChildListView
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    // Tính kích thước của SingleChildListView
    final viewportDimension = scrollable.position.viewportDimension;
    // Tính phần trăm tỷ lệ giữa LocationListItem và kích thước của SingleChildListView.
    // Dùng clamp để tránh nó vượt qua được giá trị bên trong.
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(
      0.0,
      1.0,
    );
    // Tính toán vị trị của bức ảnh nên được hiển thị trong LocationListView từ tỷ lệ phần trăm của nó so với SingleChildListView
    // (Do ảnh nó BoxFit.cover nên nó hiển thị vừa width nên tràn height)
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
    // Lấy kích thước của ảnh
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    // Lấy kích thước của LocationListItem
    final listItemSize = context.size;
    // Từ kích thước ảnh, ví trí phần ảnh nên hiển thị
    // và kích thước thứ chứa nó (Kích thước LocationListView)
    // ta tính ra được một hình chữ nhật cần vẽ.
    final childRect = verticalAlignment.inscribe(
      backgroundSize,
      Offset.zero & listItemSize,
    );
    // Đậy là vẽ lại thành phần thứ 0 (Tức là LocationListItem đó, do nó được bọc bởi một Flow)
    // Sử dụng một phép biến đổi ma trận Translate đi với toạ độ mới là
    // vị trí (0, Đỉnh đầu của hình chữ nhật mới tính)
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, childRect.top),
      ).transform,
    );
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
