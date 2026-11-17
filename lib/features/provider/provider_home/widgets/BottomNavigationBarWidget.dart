import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 78,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          // color: Ivory,
          color: SeaShell,
          boxShadow: [
            BoxShadow(
              color: Boxshadowcolor,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              icon: Icons.home_rounded,
              label: "الرئيسية",
              isSelected: true,
            ),
            _BottomNavItem(
              icon: Icons.work_outline_rounded,
              label: "أعمالي",
              isSelected: false,
              // gifAsset: 'assets/images/icons8-accordion-quad-box-grid-loader.gif',
            ),
            _BottomNavItem(
              icon: Icons.settings_applications,
              label: "تخصصي",
              isSelected: false,
            ),
            _BottomNavItem(
              icon: Icons.person_outline_rounded,
              label: "حسابي",
              isSelected: false,
            ),
            
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  // final String? gifAsset;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    // this.gifAsset,
  });

  @override
  Widget build(BuildContext context) {
    final Color labelColor = isSelected ? Cream : DarkTeal;
    final Color iconColor = isSelected ? Cream : DarkTeal;
    final Color backgroundColor = isSelected ? DarkTeal : Colors.transparent;

    return Expanded(
      child: Center(
        child: Container(
          width: isSelected ? 86 : 70,
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (gifAsset case final asset?)
                // Image.asset(asset, width: 23, height: 23, fit: BoxFit.contain)
              // else
                Icon(icon, color: iconColor, size: 23),
              SizedBox(height: 2),
              Text(
                label,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  shadows: [
                  Shadow(
                    color: Boxshadowcolor,
                    offset: Offset(5, 5),
                    blurRadius: 5
                  )
                ],
                  color: labelColor,
                  fontSize: 11,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
