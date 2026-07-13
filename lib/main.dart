import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

// Visual Theme Palette Colors
const Color kCreamBg = Color(0xFFFAF6EE);
const Color kTerracotta = Color(0xFFD36135);
const Color kSageGreen = Color(0xFF7A8B7B);
const Color kWarmWood = Color(0xFF2F251E);
const Color kSandSurface = Color(0xFFEAE3D2);
const Color kSageGreenLight = Color(0xFFE8ECE8);
const Color kTerracottaLight = Color(0xFFFBF1EC);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R. Borger-Johnson | Developer & Designer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kCreamBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kTerracotta,
          primary: kTerracotta,
          secondary: kSageGreen,
          surface: kSandSurface,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: kWarmWood,
        ),
        textTheme:
            GoogleFonts.plusJakartaSansTextTheme(
              Theme.of(context).textTheme,
            ).copyWith(
              displayLarge: GoogleFonts.fraunces(
                textStyle: const TextStyle(
                  color: kWarmWood,
                  fontWeight: FontWeight.bold,
                ),
              ),
              displayMedium: GoogleFonts.fraunces(
                textStyle: const TextStyle(
                  color: kWarmWood,
                  fontWeight: FontWeight.bold,
                ),
              ),
              displaySmall: GoogleFonts.fraunces(
                textStyle: const TextStyle(
                  color: kWarmWood,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titleLarge: GoogleFonts.fraunces(
                textStyle: const TextStyle(
                  color: kWarmWood,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for each section to achieve smooth jumping
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _csProjectsKey = GlobalKey();
  final GlobalKey _designGalleryKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNavItemPressed(GlobalKey key, BuildContext context) {
    if (Scaffold.of(context).isEndDrawerOpen) {
      Navigator.of(context).pop();
    }
    _scrollToSection(key);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCreamBg.withValues(alpha: 0.95),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: kSandSurface.withValues(alpha: 0.7),
            height: 1,
          ),
        ),
        title: Text(
          "Rory Borger-Johnson",
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: isMobile
            ? null
            : [
                HoverNavButton(
                  label: "Home",
                  onTap: () => _scrollToSection(_homeKey),
                ),
                HoverNavButton(
                  label: "About",
                  onTap: () => _scrollToSection(_aboutKey),
                ),
                HoverNavButton(
                  label: "CS Projects",
                  onTap: () => _scrollToSection(_csProjectsKey),
                ),
                HoverNavButton(
                  label: "Design",
                  onTap: () => _scrollToSection(_designGalleryKey),
                ),
                HoverNavButton(
                  label: "Skills",
                  onTap: () => _scrollToSection(_skillsKey),
                ),
                HoverNavButton(
                  label: "Contact",
                  onTap: () => _scrollToSection(_contactKey),
                ),
                const SizedBox(width: 24),
              ],
      ),
      endDrawer: isMobile ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildSection(
              key: _homeKey,
              child: HeroSection(
                csKey: _csProjectsKey,
                contactKey: _contactKey,
                onScroll: _scrollToSection,
              ),
            ),
            _buildSection(
              key: _aboutKey,
              child: AboutSection(
                onViewResume: () => _showResumeDialog(context),
              ),
            ),
            _buildSection(
              key: _csProjectsKey,
              child: const CSProjectsSection(),
            ),
            _buildSection(
              key: _designGalleryKey,
              child: const DesignGallerySection(),
            ),
            _buildSection(key: _skillsKey, child: const SkillsSection()),
            _buildSection(key: _contactKey, child: const ContactSection()),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required GlobalKey key, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24.0),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kCreamBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: kSandSurface),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "R. Borger-Johnson",
                  style: GoogleFonts.fraunces(
                    color: kWarmWood,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Developer & Designer",
                  style: GoogleFonts.plusJakartaSans(
                    color: kSageGreen,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          _drawerTile(context, "Home", _homeKey),
          _drawerTile(context, "About", _aboutKey),
          _drawerTile(context, "CS Projects", _csProjectsKey),
          _drawerTile(context, "Design Work", _designGalleryKey),
          _drawerTile(context, "Skills", _skillsKey),
          _drawerTile(context, "Contact", _contactKey),
        ],
      ),
    );
  }

  Widget _drawerTile(BuildContext context, String title, GlobalKey key) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          color: kWarmWood,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () => _onNavItemPressed(key, context),
    );
  }

  void _showResumeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: kCreamBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Resume Summary",
                        style: GoogleFonts.fraunces(
                          color: kWarmWood,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: kWarmWood),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Text(
                    "R. BORGER-JOHNSON | DEVELOPER & DESIGNER",
                    style: GoogleFonts.plusJakartaSans(
                      color: kSageGreen,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: kSandSurface, thickness: 1.5),
                  const SizedBox(height: 16),

                  // Education Section
                  _resumeSectionTitle("EDUCATION"),
                  _resumeItem(
                    title: "B.S. in Computer Science",
                    subtitle: "University of Design & Technology",
                    period: "2022 - 2026",
                    details:
                        "Specialized in Software Engineering and Human-Computer Interaction. GPA: 3.8/4.0.",
                  ),
                  _resumeItem(
                    title: "Minor in Graphic Design",
                    subtitle: "Fine Arts Institute",
                    period: "2023 - 2025",
                    details:
                        "Focused on Brand Identity, Grid Systems, Typography, and UI/UX.",
                  ),
                  const SizedBox(height: 16),

                  // Experience Section
                  _resumeSectionTitle("EXPERIENCE"),
                  _resumeItem(
                    title: "Full-Stack Software Engineer Intern",
                    subtitle: "Aesthetic Systems Inc.",
                    period: "Summer 2025",
                    details:
                        "Developed user-facing Flutter applications, optimized dashboard queries, and participated in frontend design refactoring.",
                  ),
                  _resumeItem(
                    title: "Freelance Graphic Designer & Web Developer",
                    subtitle: "Self-Employed",
                    period: "2023 - Present",
                    details:
                        "Designed brand logos, promotional poster systems, and implemented responsive portfolio/landing sites for local clients.",
                  ),

                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kTerracotta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.download, size: 20),
                      label: const Text("Download Full PDF"),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Resume PDF download simulated. (Linked asset active in build)",
                            ),
                            backgroundColor: kSageGreen,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _resumeSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          color: kTerracotta,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget _resumeItem({
    required String title,
    required String subtitle,
    required String period,
    required String details,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: kWarmWood,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                period,
                style: GoogleFonts.plusJakartaSans(
                  color: kSageGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: kWarmWood.withValues(alpha: 0.7),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: GoogleFonts.plusJakartaSans(
              color: kWarmWood.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// Custom Hover Widgets & Animations
// ----------------------------------------------------

class HoverNavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const HoverNavButton({super.key, required this.label, required this.onTap});

  @override
  State<HoverNavButton> createState() => _HoverNavButtonState();
}

class _HoverNavButtonState extends State<HoverNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.plusJakartaSans(
                  color: _isHovered ? kTerracotta : kWarmWood,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 24 : 0,
                color: kTerracotta,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HoverableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleAmount;
  final Offset translationOffset;
  const HoverableCard({
    super.key,
    required this.child,
    this.onTap,
    this.scaleAmount = 1.03,
    this.translationOffset = const Offset(0, -6),
  });

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? (Matrix4.identity()
                  ..translate(
                    widget.translationOffset.dx,
                    widget.translationOffset.dy,
                  )
                  ..scale(widget.scaleAmount))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: kWarmWood.withValues(alpha: 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: kWarmWood.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// Section 1: Hero Landing Section
// ----------------------------------------------------

class HeroSection extends StatelessWidget {
  final GlobalKey csKey;
  final GlobalKey contactKey;
  final Function(GlobalKey) onScroll;
  const HeroSection({
    super.key,
    required this.csKey,
    required this.contactKey,
    required this.onScroll,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CreativeHeroGraphic(),
              const SizedBox(height: 40),
              _buildHeroText(context, isMobile: true),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildHeroText(context, isMobile: false)),
              const SizedBox(width: 40),
              const Expanded(child: Center(child: CreativeHeroGraphic())),
            ],
          );
  }

  Widget _buildHeroText(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "DEVELOPER & DESIGNER",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5,
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        Text(
              "Bridging technical complexity and visual harmony.",
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.fraunces(
                color: kWarmWood,
                fontSize: isMobile ? 36 : 54,
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.15, end: 0),
        const SizedBox(height: 24),
        Text(
              "Hi, I'm R. Borger-Johnson. I build performant backend and mobile systems while maintaining a high standard for editorial typography and graphic design.",
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.plusJakartaSans(
                color: kWarmWood.withValues(alpha: 0.85),
                fontSize: 16,
                height: 1.6,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 32),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTerracotta,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () => onScroll(csKey),
                child: Text(
                  "View Projects",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: kTerracotta,
                  side: const BorderSide(color: kTerracotta, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => onScroll(contactKey),
                child: Text(
                  "Get in Touch",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        ),
      ],
    );
  }
}

class CreativeHeroGraphic extends StatelessWidget {
  const CreativeHeroGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 360,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Terracotta Circle (Sun/Canvas)
          Positioned(
            left: 30,
            top: 30,
            child:
                Container(
                      width: 220,
                      height: 220,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kTerracottaLight,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(begin: const Offset(0.5, 0.5)),
          ),
          // 2. Sage Green Arc/Rotated Box
          Positioned(
            right: 20,
            bottom: 40,
            child:
                RotationTransition(
                      turns: const AlwaysStoppedAnimation(15 / 360),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: kSageGreen.withValues(alpha: 0.2),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),
          ),
          // 3. Grid representation (Logic)
          Positioned(
            left: 60,
            bottom: 60,
            child: SizedBox(
              width: 120,
              height: 120,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 16,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kWarmWood.withValues(alpha: 0.08),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
          ),
          // 4. Overlapping accent shapes
          Positioned(
            right: 60,
            top: 60,
            child:
                Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [kTerracotta, kSageGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 800.ms)
                    .scale(begin: const Offset(0.2, 0.2)),
          ),
          // 5. Code bracket symbol floating
          Positioned(
            left: 90,
            top: 110,
            child:
                Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kWarmWood.withValues(alpha: 0.06),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.code, color: kWarmWood, size: 24),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 800.ms)
                    .slideX(begin: -0.2, end: 0),
          ),
          // 6. Paint brush symbol floating
          Positioned(
            right: 90,
            bottom: 90,
            child:
                Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kWarmWood.withValues(alpha: 0.06),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.palette,
                        color: kTerracotta,
                        size: 24,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 900.ms, duration: 800.ms)
                    .slideX(begin: 0.2, end: 0),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// Section 2: About Me Section
// ----------------------------------------------------

class AboutSection extends StatelessWidget {
  final VoidCallback onViewResume;
  const AboutSection({super.key, required this.onViewResume});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    final imageCard = Container(
      height: 380,
      width: 310,
      decoration: BoxDecoration(
        color: kSandSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kSandSurface, width: 1.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Elegant terracotta arch in background
          Positioned(
            bottom: 0,
            child: Container(
              width: 220,
              height: 290,
              decoration: const BoxDecoration(
                color: kTerracottaLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(110),
                  topRight: Radius.circular(110),
                ),
              ),
            ),
          ),
          // Floating stylized card with brief profile details
          Positioned(
            bottom: 40,
            child: Container(
              width: 230,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: kWarmWood.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: kCreamBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_pin,
                      color: kSageGreen,
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "R. Borger-Johnson",
                    style: GoogleFonts.fraunces(
                      color: kWarmWood,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Batavia, IL",
                    style: GoogleFonts.plusJakartaSans(
                      color: kWarmWood.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoBadge("Logic", Icons.code),
                      _infoBadge("Form", Icons.palette),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final narrative = Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "ABOUT ME",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Dual-minded by nature, structured by choice.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I have always felt split between the engineering laboratory and the design studio. Rather than choosing one, I decided to master both. My technical focus is on performance-sensitive applications, interactive interfaces, and robust systems architecture.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.85),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "On the design side, I curate brand assets, design clean user experiences (UI/UX), and draft grid-based editorial prints. This duality lets me build developer-friendly APIs and user-friendly products without compromising on either side.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.85),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: kWarmWood,
            foregroundColor: kCreamBg,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.description, size: 20),
          label: Text(
            "View Resume Summary",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
          onPressed: onViewResume,
        ),
      ],
    );

    return isMobile
        ? Column(children: [imageCard, const SizedBox(height: 48), narrative])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Center(child: imageCard)),
              const SizedBox(width: 48),
              Expanded(child: narrative),
            ],
          );
  }

  Widget _infoBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kSageGreenLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: kSageGreen),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              color: kSageGreen,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// Section 3: Computer Science Projects Section
// ----------------------------------------------------

class CSProjectsSection extends StatelessWidget {
  const CSProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;
    final projectsData = [
      {
        "icon": Icons.analytics_outlined,
        "title": "Aesthetic Data Visualizer",
        "description":
            "A custom data analytics dashboard parsing massive CSV/JSON datasets and rendering them via high-framerate custom animations and SVG graphics.",
        "tags": ["Dart", "Flutter Web", "SQLite"],
      },
      {
        "icon": Icons.psychology_outlined,
        "title": "Neural Style Transfer API",
        "description":
            "An advanced PyTorch service allowing graphic designers to transfer visual styling from classic poster layouts onto modern digital photos in real-time.",
        "tags": ["Python", "PyTorch", "FastAPI"],
      },
      {
        "icon": Icons.blur_linear,
        "title": "Interactive Physics Engine",
        "description":
            "A 2D particle and rigid-body simulator built in Go and compiled into WebAssembly for high-performance physics in web browsers.",
        "tags": ["Go", "WebAssembly", "Canvas"],
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "COMPUTER SCIENCE",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "System logic and architectural code.",
          textAlign: TextAlign.center,
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "A selection of software engineering projects, showing a mix of Flutter development, backend architecture, and graphics programming.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 48),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 2000),
          child: MasonryGridView.count(
            crossAxisCount: isMobile ? 1 : (screenWidth < 950 ? 2 : 3),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              final project = projectsData[index];
              return _buildCSProjectCard(
                icon: project["icon"] as IconData,
                title: project["title"] as String,
                description: project["description"] as String,
                tags: project["tags"] as List<String>,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCSProjectCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> tags,
  }) {
    return HoverableCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kSandSurface.withValues(alpha: 0.4),
          border: Border.all(
            color: kSandSurface.withValues(alpha: 0.8),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: kCreamBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: kTerracotta, size: 26),
              ),
              const SizedBox(height: 18),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  title,
                  style: GoogleFonts.fraunces(
                    color: kWarmWood,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 12),
                child: Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    color: kWarmWood.withValues(alpha: 0.8),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: kSageGreenLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.plusJakartaSans(
                            color: kSageGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 18),
              const Divider(color: kSandSurface, height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 15,
                      color: kWarmWood,
                    ),
                    label: Text(
                      "GitHub",
                      style: GoogleFonts.plusJakartaSans(
                        color: kWarmWood,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                      size: 12,
                      color: kTerracotta,
                    ),
                    label: Text(
                      "Live Demo",
                      style: GoogleFonts.plusJakartaSans(
                        color: kTerracotta,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// Section 4: Graphic Design Gallery Section
// ----------------------------------------------------

class DesignGallerySection extends StatelessWidget {
  const DesignGallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "GRAPHIC DESIGN",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Visual communication and layout grid.",
          textAlign: TextAlign.center,
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "A selection of graphic design files rendered natively in Flutter, illustrating my approach to branding, interfaces, and poster layouts.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 48),
        GridView.count(
          crossAxisCount: isMobile ? 1 : (screenWidth < 900 ? 2 : 4),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.0,
          children: const [
            GalleryItemFrame(
              visualWidget: SustainaBrandCard(),
              title: "Sustaina Brand Identity",
              category: "Logo, Guidelines & Print Assets",
            ),
            GalleryItemFrame(
              visualWidget: AuraAppCard(),
              title: "Aura Meditation App",
              category: "UI/UX & Interactive Design",
            ),
            GalleryItemFrame(
              visualWidget: AbstractGeometryCard(),
              title: "Abstract Geometry Poster",
              category: "Editorial & Grid Layouts",
            ),
            GalleryItemFrame(
              visualWidget: VectorIllustrationCard(),
              title: "Earthy Geometric Landscapes",
              category: "Vector Illustration Series",
            ),
          ],
        ),
      ],
    );
  }
}

class GalleryItemFrame extends StatefulWidget {
  final Widget visualWidget;
  final String title;
  final String category;
  const GalleryItemFrame({
    super.key,
    required this.visualWidget,
    required this.title,
    required this.category,
  });

  @override
  State<GalleryItemFrame> createState() => _GalleryItemFrameState();
}

class _GalleryItemFrameState extends State<GalleryItemFrame> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: HoverableCard(
        scaleAmount: 1.02,
        translationOffset: const Offset(0, -4),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kSandSurface, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Positioned.fill(child: widget.visualWidget),
                  // Muted shade cover on hover with description info
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    left: 0,
                    right: 0,
                    bottom: _isHovered ? 0 : -90,
                    height: 90,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kWarmWood.withValues(alpha: 0.95),
                            kWarmWood.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.fraunces(
                              color: kCreamBg,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.category,
                            style: GoogleFonts.plusJakartaSans(
                              color: kSageGreenLight,
                              fontSize: 11,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// Graphic Design Vector Cards
// ----------------------------------------------------

class SustainaBrandCard extends StatelessWidget {
  const SustainaBrandCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSageGreenLight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kSageGreen.withValues(alpha: 0.12),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: kSageGreen,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(27),
                    bottomRight: Radius.circular(27),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kSageGreen.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "sustaina",
                style: GoogleFonts.fraunces(
                  color: kWarmWood,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "BRAND IDENTITY",
                style: GoogleFonts.plusJakartaSans(
                  color: kSageGreen,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuraAppCard extends StatelessWidget {
  const AuraAppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEADBCE), Color(0xFFD4E2E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Smartphone shell
          Container(
            width: 100,
            height: 170,
            decoration: BoxDecoration(
              color: kWarmWood,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kWarmWood, width: 3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.white.withValues(alpha: 0.95),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF9EAE1),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 76,
                        height: 86,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: kTerracotta,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.spa_outlined,
                                color: Colors.white,
                                size: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 40,
                              height: 5,
                              color: kWarmWood.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 26,
                              height: 4,
                              color: kWarmWood.withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AbstractGeometryCard extends StatelessWidget {
  const AbstractGeometryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTerracottaLight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Intersecting spheres
          Positioned(
            left: 30,
            top: 20,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kTerracotta.withValues(alpha: 0.85),
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kWarmWood.withValues(alpha: 0.9),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: GridPainter()),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BAUHAUS 26",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  "GEOMETRY POSTER",
                  style: GoogleFonts.plusJakartaSans(
                    color: kTerracotta,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kWarmWood
      ..strokeWidth = 1.0;
    for (double i = 0; i < size.width; i += 18) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 18) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VectorIllustrationCard extends StatelessWidget {
  const VectorIllustrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWarmWood,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 30,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kTerracotta,
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -20,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: kSageGreen.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -30,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(35 / 360),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: kSandSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 2,
                  color: kCreamBg.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 45,
                  height: 2,
                  color: kCreamBg.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 25,
                  height: 2,
                  color: kCreamBg.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// Section 5: Skills Section
// ----------------------------------------------------

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    final logicSkills = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "THE LOGIC • COMPUTER SCIENCE",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 24),
        _buildSkillBar(
          label: "Flutter & Dart Development",
          percentage: 0.95,
          barColor: kSageGreen,
        ),
        _buildSkillBar(
          label: "Python & Machine Learning APIs",
          percentage: 0.85,
          barColor: kSageGreen,
        ),
        _buildSkillBar(
          label: "Go & WebAssembly Engine",
          percentage: 0.75,
          barColor: kSageGreen,
        ),
        _buildSkillBar(
          label: "Database Design & SQL (Postgres / SQLite)",
          percentage: 0.80,
          barColor: kSageGreen,
        ),
      ],
    );

    final formSkills = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "THE FORM • GRAPHIC DESIGN",
          style: GoogleFonts.plusJakartaSans(
            color: kTerracotta,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 24),
        _buildSkillBar(
          label: "Figma (Interactive UI/UX Design)",
          percentage: 0.90,
          barColor: kTerracotta,
        ),
        _buildSkillBar(
          label: "Adobe Illustrator (Vector Layouts)",
          percentage: 0.85,
          barColor: kTerracotta,
        ),
        _buildSkillBar(
          label: "Adobe Photoshop (Post-Processing)",
          percentage: 0.80,
          barColor: kTerracotta,
        ),
        _buildSkillBar(
          label: "Typography & Print Grid Systems",
          percentage: 0.90,
          barColor: kTerracotta,
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "SKILLS & TOOLS",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Professional capabilities and stack.",
          textAlign: TextAlign.center,
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Dividing skills into technical and graphic domains to present a dual specialization in software build processes and visual aesthetics.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 48),
        isMobile
            ? Column(
                children: [logicSkills, const SizedBox(height: 48), formSkills],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: logicSkills),
                  const SizedBox(width: 64),
                  Expanded(child: formSkills),
                ],
              ),
      ],
    );
  }

  Widget _buildSkillBar({
    required String label,
    required double percentage,
    required Color barColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: kWarmWood,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                "${(percentage * 100).toInt()}%",
                style: GoogleFonts.plusJakartaSans(
                  color: barColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kSandSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      height: 8,
                      width: constraints.maxWidth * percentage,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// Section 6: Contact Section
// ----------------------------------------------------

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GET IN TOUCH",
          style: GoogleFonts.plusJakartaSans(
            color: kSageGreen,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Let's create something together.",
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Have a project in mind, want to collaborate on open-source code, or discuss a design request? Drop me a message below.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: kWarmWood.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: kSandSurface, width: 1.5),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  label: "Name",
                  controller: _nameController,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: "Email",
                  controller: _emailController,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!regex.hasMatch(val)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  label: "Message",
                  controller: _messageController,
                  maxLines: 5,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return "Please enter a message";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTerracotta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kSageGreen,
                          content: Text(
                            "Message sent! Thank you, ${_nameController.text}.",
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                      _nameController.clear();
                      _emailController.clear();
                      _messageController.clear();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.send_outlined, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        "Send Message",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(color: kWarmWood),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.6),
          ),
          filled: true,
          fillColor: kSandSurface.withValues(alpha: 0.25),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kSandSurface, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kTerracotta, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// Section 7: Footer Section
// ----------------------------------------------------

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: kWarmWood,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Text(
            "R. Borger-Johnson",
            style: GoogleFonts.fraunces(
              color: kCreamBg,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Bridging code and creative aesthetics.",
            style: GoogleFonts.plusJakartaSans(
              color: kCreamBg.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  _socialIcon(FontAwesomeIcons.github, screenWidth),
                  _socialIcon(FontAwesomeIcons.linkedinIn, screenWidth),
                  _socialIcon(FontAwesomeIcons.behance, screenWidth),
                  _socialIcon(FontAwesomeIcons.dribbble, screenWidth),
                  _socialIcon(FontAwesomeIcons.envelope, screenWidth),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 24),
          Text(
            "© ${DateTime.now().year} R. Borger-Johnson. All rights reserved. Built with Flutter Web.",
            style: GoogleFonts.plusJakartaSans(
              color: kCreamBg.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(FaIconData icon, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12).clamp(
        EdgeInsets.symmetric(horizontal: 2),
        EdgeInsets.symmetric(horizontal: 15 - (10 - screenWidth / 200)),
      ),
      child: HoverableCard(
        scaleAmount: 1.15,
        translationOffset: const Offset(0, -3),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.06),
          ),
          child: FaIcon(icon, color: kCreamBg, size: 18),
        ),
      ),
    );
  }
}
