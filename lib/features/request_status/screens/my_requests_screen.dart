import 'package:flutter/material.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';

enum _RequestTab { current, previous }

const _pageColor = Color(0xFFFBF3DF);
const _cardColor = Color(0xFFFFFCF5);
const _tealColor = Color(0xFF0D554E);
const _redColor = Color(0xFFC63A26);
const _borderColor = Color(0xFFE8D9B9);
const _mutedColor = Color(0xFF888A7F);

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  _RequestTab _selectedTab = _RequestTab.current;

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final pastRequests = [
      _PastRequest(
        id: 'SN-1982',
        status: localizations.completedStatus,
        title: localizations.pastRepairTitle,
        provider: localizations.pastRepairProvider,
        date: localizations.pastRepairDate,
      ),
      _PastRequest(
        id: 'SN-1843',
        status: localizations.completedRatedStatus,
        title: localizations.pastFridgeTitle,
        provider: localizations.pastFridgeProvider,
        date: localizations.pastFridgeDate,
      ),
      _PastRequest(
        id: 'SN-1760',
        status: localizations.cancelledStatus,
        title: localizations.pastLightTitle,
        provider: localizations.pastLightProvider,
        date: localizations.pastLightDate,
        isCancelled: true,
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: _pageColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _RequestsHeader(
                            localizations: localizations,
                            isArabic: isArabic,
                          ),
                          const SizedBox(height: 18),
                          _RequestsTabs(
                            selectedTab: _selectedTab,
                            currentLabel: localizations.currentRequestsTab,
                            previousLabel: localizations.pastRequestsTab,
                            onSelected: (tab) {
                              setState(() {
                                _selectedTab = tab;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          if (_selectedTab == _RequestTab.current) ...[
                            _SectionTitle(localizations.currentOrdersSection),
                            const SizedBox(height: 10),
                            _CurrentRequestCard(
                              status: localizations.scheduledVisitStatus,
                              title: localizations.currentServiceTitle,
                              provider: localizations.currentProviderInfo,
                              date: localizations.currentVisitDate,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 42,
                              child: FilledButton(
                                onPressed: () => _showComingSoon(
                                  localizations.trackRequestComingSoon(
                                    'SN-2048',
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: _redColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                                child: Text(
                                  localizations.trackRequestButton('SN-2048'),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            _SectionTitle(localizations.pastVisitsSection),
                          ] else ...[
                            _SectionTitle(localizations.pastVisitsSection),
                          ],
                          const SizedBox(height: 10),
                          for (final request in pastRequests) ...[
                            _PastRequestCard(request: request),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 4),
                          OutlinedButton(
                            onPressed: () => _showComingSoon(
                              localizations.newRequestComingSoon,
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _tealColor,
                              backgroundColor: _cardColor,
                              side: const BorderSide(color: _borderColor),
                              minimumSize: const Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            child: Text(
                              localizations.newRequestButton,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _RequestsBottomNavigation(localizations: localizations),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestsHeader extends StatelessWidget {
  const _RequestsHeader({required this.localizations, required this.isArabic});

  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
          color: _tealColor,
          size: 19,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.requestsTitle,
                style: TextStyle(
                  color: _tealColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                localizations.requestsSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _mutedColor.withValues(alpha: 0.9),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RequestsTabs extends StatelessWidget {
  const _RequestsTabs({
    required this.selectedTab,
    required this.currentLabel,
    required this.previousLabel,
    required this.onSelected,
  });

  final _RequestTab selectedTab;
  final String currentLabel;
  final String previousLabel;
  final ValueChanged<_RequestTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RequestTabButton(
            label: currentLabel,
            isSelected: selectedTab == _RequestTab.current,
            onTap: () => onSelected(_RequestTab.current),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _RequestTabButton(
            label: previousLabel,
            isSelected: selectedTab == _RequestTab.previous,
            onTap: () => onSelected(_RequestTab.previous),
          ),
        ),
      ],
    );
  }
}

class _RequestTabButton extends StatelessWidget {
  const _RequestTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : _tealColor,
          backgroundColor: isSelected ? _redColor : _cardColor,
          side: BorderSide(color: isSelected ? _redColor : _borderColor),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: _tealColor,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _CurrentRequestCard extends StatelessWidget {
  const _CurrentRequestCard({
    required this.status,
    required this.title,
    required this.provider,
    required this.date,
  });

  final String status;
  final String title;
  final String provider;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'SN-2048',
                style: TextStyle(color: _mutedColor, fontSize: 9),
              ),
              const Spacer(),
              _StatusBadge(
                label: status,
                backgroundColor: Color(0xFFE5EED9),
                foregroundColor: _tealColor,
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              color: _tealColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(provider, style: TextStyle(color: _mutedColor, fontSize: 10)),
          const SizedBox(height: 3),
          Text(date, style: TextStyle(color: _mutedColor, fontSize: 10)),
        ],
      ),
    );
  }
}

class _PastRequest {
  const _PastRequest({
    required this.id,
    required this.status,
    required this.title,
    required this.provider,
    required this.date,
    this.isCancelled = false,
  });

  final String id;
  final String status;
  final String title;
  final String provider;
  final String date;
  final bool isCancelled;
}

class _PastRequestCard extends StatelessWidget {
  const _PastRequestCard({required this.request});

  final _PastRequest request;

  @override
  Widget build(BuildContext context) {
    final statusColor = request.isCancelled
        ? const Color(0xFFF9E0D0)
        : const Color(0xFFE5EED9);
    final statusTextColor = request.isCancelled ? _redColor : _tealColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                request.id,
                style: const TextStyle(color: _mutedColor, fontSize: 9),
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _StatusBadge(
                    label: request.status,
                    backgroundColor: statusColor,
                    foregroundColor: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            request.title,
            style: const TextStyle(
              color: _tealColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            request.provider,
            style: const TextStyle(color: _mutedColor, fontSize: 9),
          ),
          const SizedBox(height: 2),
          Text(
            request.date,
            style: TextStyle(
              color: request.isCancelled ? _redColor : _mutedColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _RequestsBottomNavigation extends StatelessWidget {
  const _RequestsBottomNavigation({required this.localizations});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _cardColor,
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          _BottomNavigationItem(
            icon: Icons.home_outlined,
            label: localizations.homeNavigation,
          ),
          _BottomNavigationItem(
            icon: Icons.grid_view_outlined,
            label: localizations.categoriesNavigation,
          ),
          _BottomNavigationItem(
            icon: Icons.receipt_long_outlined,
            label: localizations.myRequestsNavigation,
            isSelected: true,
          ),
          _BottomNavigationItem(
            icon: Icons.person_outline,
            label: localizations.accountNavigation,
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? _redColor : _mutedColor;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 14,
              height: 2,
              decoration: BoxDecoration(
                color: _redColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
