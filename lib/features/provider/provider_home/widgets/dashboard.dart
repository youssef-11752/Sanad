import 'package:material_ui/material_ui.dart';
import 'package:sanad/core/constants/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        const Expanded(
          child: _DashboardMetric(value: '٤.٩', label: 'تقييمك'),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: _DashboardMetric(value: '٣', label: 'زيارات الأسبوع'),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: _DashboardMetric(value: '٢', label: 'طلبات متطابقة'),
        ),
      ],
    );
  }
}

class _DashboardMetric extends StatelessWidget {
  const _DashboardMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: StoneWhite,
        border: Border.all(width: 2, color: Cream),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Boxshadowcolor,
            offset: const Offset(5, 5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: DimGray,
              fontSize: 24,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                textDirection: TextDirection.rtl,
                maxLines: 1,
                style: const TextStyle(
                  color: DimGray,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
