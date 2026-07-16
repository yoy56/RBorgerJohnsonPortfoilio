import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rborgerjohnsonportfoilio/main.dart';

class GraphicDesignPage extends StatefulWidget {
  const GraphicDesignPage({super.key});

  @override
  State<GraphicDesignPage> createState() => _GraphicDesignPageState();
}

class _GraphicDesignPageState extends State<GraphicDesignPage> {
  String _activeFilter = 'All';

  // Project data list
  final List<ProjectData> _projects = [
    ProjectData(
      id: 'sustaina',
      title: 'Sustaina Brand Identity',
      category: 'Logo, Guidelines & Print Assets',
      categoryTags: ['Branding','Print'],
      description:
          'A comprehensive brand identity design for Sustaina, an eco-friendly retail initiative. The design features a modern minimalist aesthetic with earthy greens and organic geometry, reflecting clean living and environmental responsibility. Designed with an emphasis on sustainable packaging, letterpress textures, and high-end natural paper assets.',
      role: 'Lead Visual Designer',
      deliverables: 'Logo, Brand Guidelines, Packaging, Typography',
      tools: 'Adobe Illustrator, Photoshop',
      year: '2025',
      largeImagePath: 'images/sustainaLarge.jpg',
      smallImagePath: 'images/sustainaSmall.jpg',
    ),
    ProjectData(
      id: 'aura',
      title: 'Aura Meditation App',
      category: 'UI/UX & Interactive Design',
      categoryTags: ['UI/UX', 'App Design'],
      description:
          'A calming, minimalist interface design for Aura, a meditation and wellness application. Built upon a warm terracotta and sage gradient, the interface leverages soft shadows, spacious layouts, and gentle micro-animations to induce a state of tranquility for users navigating the wellness courses and tracking their mental habits.',
      role: 'UI/UX Designer',
      deliverables: 'Wireframes, High-Fidelity Screens, Prototypes',
      tools: 'Figma, Adobe XD, Flutter',
      year: '2026',
      largeImagePath: 'images/meditationLarge.jpg',
      smallImagePath: 'images/meditationSmall.jpg',
    ),
    ProjectData(
      id: 'bauhaus',
      title: 'Abstract Geometry Poster',
      category: 'Editorial & Grid Layouts',
      categoryTags: ['Editorial', 'Print', 'Posters'],
      description:
          'An editorial graphic design poster series inspired by the Bauhaus school, exploring intersecting geometry, line grids, and distressed typography. Renders a stark juxtaposition of deep warm charcoal shapes with bright terracotta accents over a sand-textured surface to evoke classical modernist design principles.',
      role: 'Graphic Artist',
      deliverables: 'Poster Layouts, Exhibition Guide, Grid Systems',
      tools: 'Adobe Illustrator, InDesign',
      year: '2025',
      largeImagePath: 'images/geometricLarge.jpg',
      smallImagePath: 'images/geometricSmall.jpg',
    ),
    ProjectData(
      id: 'landscapes',
      title: 'Earthy Geometric Landscapes',
      category: 'Vector Illustration Series',
      categoryTags: ['Illustration', 'Digital Art'],
      description:
          'A series of vector landscape illustrations utilizing organic curves, layered earth-toned shapes, and flat vector silhouettes. The series experiments with visual depth by layering clean geometric curves, terracotta suns, and sage hills to build a harmonious natural landscape that bridges graphic minimalism with classical art.',
      role: 'Vector Illustrator',
      deliverables: 'Vector Asset Library, Wall Art Prints, Wallpapers',
      tools: 'Adobe Illustrator, Procreate',
      year: '2026',
      largeImagePath: 'images/abstractLarge.jpg',
      smallImagePath: 'images/abstractSmall.jpg',
    ),
    ProjectData(
      id: 'bubblrhalloween',
      title: 'Bubblr: Halloween Campain',
      category: 'Packaging Design',
      categoryTags: ['Illustration', 'Packaging', 'Branding'],
      description:
          'A Halloween campaign for Bubblr, a children\'s soap brand, featuring playful packaging design. The campaign includes a custom ghost-shaped soap bottle and themed soap wrappers. The packaging design focuses on a friendly, cute ghost character with big eyes and soft rounded shapes, appealing to children. The color palette uses Bubblr\'s signature bright colors combined with Halloween-appropriate accents like orange, black, and purple. The project involved designing the bottle shape, creating the packaging artwork, and ensuring the design was both fun and suitable for a children\'s product.',
      role: 'Packaging Designer',
      deliverables: 'Packaging Design, Illustration, Brand Identity',
      tools: 'Adobe Illustrator, Procreate',
      year: '2025',
      largeImagePath: 'images/BubblrCansFront-05.jpg',
      smallImagePath: 'images/BubblrCansFront-01.jpg',
    ),
  ];

  late final List<ProjectData> mainProjects = _projects
      .where((p) => const [
            'Sustaina Brand Identity',
            'Aura Meditation App',
            'Abstract Geometry Poster',
          ].contains(p.title))
      .toList();
  late final Set<String> filterTags = _projects
      .map((p) => p.categoryTags)
      .expand((tags) => tags)
      .toSet();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    // Filter projects for the bottom file browser grid
    List<ProjectData> filteredProjects = _activeFilter == 'All'
        ? _projects
        : _projects.where((p) => p.categoryTags.contains(_activeFilter)).toList();

    return Scaffold(
      backgroundColor: kCreamBg,
      appBar: AppBar(
        backgroundColor: kCreamBg.withValues(alpha: 0.95),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWarmWood),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: kSandSurface.withValues(alpha: 0.7),
            height: 1,
          ),
        ),
        title: Text(
          "Graphic Design Portfolio",
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          // Persistent Home button in the appbar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton.icon(
              icon: const Icon(Icons.home_outlined, color: kTerracotta, size: 18),
              label: Text(
                "Home",
                style: GoogleFonts.plusJakartaSans(
                  color: kWarmWood,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "CREATIVE EXHIBITION",
                      style: GoogleFonts.plusJakartaSans(
                        color: kSageGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ).animate().fadeIn(duration: 400.ms),
                    const SizedBox(height: 16),
                    Text(
                      "Editorial Gallery",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fraunces(
                        color: kWarmWood,
                        fontSize: isMobile ? 36 : 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        "An immersive presentation of graphic design layouts, branding identity materials, and user interfaces, rendered natively using Flutter.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          color: kWarmWood.withValues(alpha: 0.7),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
                  ],
                ),
              ),
            ),

            // Split Screen Projects (Section B style)
            ...List.generate(mainProjects.length, (index) {
              final project = mainProjects[index];
              final isEven = index % 2 == 0;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: _buildSplitScreenProject(context, project, isEven, isMobile),
                ),
              );
            }),

            // File Browser Gallery Section (Section C style)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 64.0, bottom: 80.0, left: 24.0, right: 24.0),
              color: kSandSurface.withValues(alpha: 0.3),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PROJECT EXPLORER",
                      style: GoogleFonts.plusJakartaSans(
                        color: kTerracotta,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "File Browser",
                      style: GoogleFonts.fraunces(
                        color: kWarmWood,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Select a filter to explore design files. Clicking an item will show project details.",
                      style: GoogleFonts.plusJakartaSans(
                        color: kWarmWood.withValues(alpha: 0.7),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFileBrowserWindow(context, filteredProjects, isMobile),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitScreenProject(
      BuildContext context, ProjectData project, bool isEven, bool isMobile) {
    Widget visualPanel = Hero(
      tag: 'editorial_${project.id}',
      child: HoverableCard(
        scaleAmount: 1.02,
        translationOffset: const Offset(0, -6),
        child: Container(
          height: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kSandSurface, width: 2),
            boxShadow: [
              BoxShadow(
                color: kWarmWood.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              project.largeImagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    Widget textPanel = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kSageGreenLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "| " + project.categoryTags.join(" | ") + " | ".toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  color: kSageGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              project.year,
              style: GoogleFonts.plusJakartaSans(
                color: kWarmWood.withValues(alpha: 0.5),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          project.title,
          style: GoogleFonts.fraunces(
            color: kWarmWood,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          project.category,
          style: GoogleFonts.plusJakartaSans(
            color: kTerracotta,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: GoogleFonts.plusJakartaSans(
            color: kWarmWood.withValues(alpha: 0.85),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kCreamBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kSandSurface.withValues(alpha: 0.6)),
          ),
          child: Column(
            children: [
              _buildMetadataRow('Role', project.role),
              const Divider(color: kSandSurface, height: 16),
              _buildMetadataRow('Deliverables', project.deliverables),
              const Divider(color: kSandSurface, height: 16),
              _buildMetadataRow('Tools', project.tools),
            ],
          ),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          visualPanel,
          const SizedBox(height: 32),
          textPanel,
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isEven) ...[
            Expanded(flex: 11, child: visualPanel),
            const SizedBox(width: 64),
            Expanded(flex: 12, child: textPanel),
          ] else ...[
            Expanded(flex: 12, child: textPanel),
            const SizedBox(width: 64),
            Expanded(flex: 11, child: visualPanel),
          ]
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
    }
  }

  Widget _buildMetadataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: kSageGreen,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: kWarmWood,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileBrowserWindow(
      BuildContext context, List<ProjectData> filteredProjects, bool isMobile) {
    List<String> filters = ['All'] + filterTags.toList();

    return Container(
      decoration: BoxDecoration(
        color: kCreamBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kSandSurface, width: 2),
        boxShadow: [
          BoxShadow(
            color: kWarmWood.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Simulated Window Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: kSandSurface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                // macOS window controls style
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFED6A5E),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF4BF4F),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF61C554),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Window Path Bar
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: kCreamBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.folder_open, size: 14, color: kSageGreen),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "root / graphic_design / ${_activeFilter.toLowerCase()}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: kWarmWood.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filters / Toolbar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kCreamBg,
              border: Border(
                bottom: BorderSide(color: kSandSurface.withValues(alpha: 0.6)),
              ),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filters.map((filter) {
                bool isActive = _activeFilter == filter;
                return ChoiceChip(
                  label: Text(
                    filter,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : kWarmWood,
                    ),
                  ),
                  selected: isActive,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _activeFilter = filter;
                      });
                    }
                  },
                  selectedColor: kTerracotta,
                  backgroundColor: kSandSurface.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isActive ? kTerracotta : kSandSurface,
                      width: 1,
                    ),
                  ),
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ),

          // File Grid Area
          Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(minHeight: 200),
            child: filteredProjects.isEmpty
                ? Center(
                    child: Text(
                      "No design files match this filter.",
                      style: GoogleFonts.plusJakartaSans(
                        color: kWarmWood.withValues(alpha: 0.5),
                        fontSize: 15,
                      ),
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Dynamically calculate grid column count: 3-5 across on desktop, 1-2 on mobile
                      double width = constraints.maxWidth;
                      int crossAxisCount = 4;
                      if (width < 450) {
                        crossAxisCount = 2;
                      } else if (width < 768) {
                        crossAxisCount = 3;
                      } else if (width < 1000) {
                        crossAxisCount = 4;
                      } else {
                        crossAxisCount = 5;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProjects.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, idx) {
                          final project = filteredProjects[idx];
                          return FileGridItem(
                            project: project,
                            onTap: () => _showProjectDetailDialog(context, project),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showProjectDetailDialog(BuildContext context, ProjectData project) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: kCreamBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: kSandSurface, width: 2),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dialog Window Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: kSandSurface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "📁 project_file_${project.id}.dart",
                          style: GoogleFonts.plusJakartaSans(
                            color: kWarmWood,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 18, color: kWarmWood),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  // Visual preview
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: kSandSurface),
                      ),
                    ),
                    child: Image.asset(project.smallImagePath),
                  ),
                  // Details Content
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: kSageGreenLight,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "| " + project.categoryTags.join(" | ") + " |".toUpperCase(),
                                style: GoogleFonts.plusJakartaSans(
                                  color: kSageGreen,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              project.year,
                              style: GoogleFonts.plusJakartaSans(
                                color: kWarmWood.withValues(alpha: 0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.title,
                          style: GoogleFonts.fraunces(
                            color: kWarmWood,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.category,
                          style: GoogleFonts.plusJakartaSans(
                            color: kTerracotta,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.description,
                          style: GoogleFonts.plusJakartaSans(
                            color: kWarmWood.withValues(alpha: 0.8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: kSandSurface),
                        const SizedBox(height: 8),
                        Text(
                          "Note: In a future iteration, clicking this file will route directly to a dedicated showcase page for ${project.title}.",
                          style: GoogleFonts.plusJakartaSans(
                            color: kSageGreen,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
}


class ProjectData {
  final String id;
  final String title;
  final String category;
  final List<String> categoryTags;
  final String description;
  final String role;
  final String deliverables;
  final String tools;
  final String year;
  final String largeImagePath;
  final String smallImagePath;

  ProjectData({
    required this.id,
    required this.title,
    required this.category,
    required this.categoryTags,
    required this.description,
    required this.role,
    required this.deliverables,
    required this.tools,
    required this.year,
    required this.largeImagePath,
    required this.smallImagePath,
  });
}

class FileGridItem extends StatefulWidget {
  final ProjectData project;
  final VoidCallback onTap;
  const FileGridItem({super.key, required this.project, required this.onTap});

  @override
  State<FileGridItem> createState() => _FileGridItemState();
}

class _FileGridItemState extends State<FileGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? kTerracottaLight
                      : kSandSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered
                        ? kTerracotta
                        : kSandSurface.withValues(alpha: 0.7),
                    width: 1.5,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: kTerracotta.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Positioned.fill(child: Image.asset(widget.project.smallImagePath, fit: BoxFit.cover)),
                      // Overlay to make thumbnail look cohesive
                      Container(
                        color: Colors.black.withValues(alpha: 0.02),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: kWarmWood,
                fontWeight: _isHovered ? FontWeight.bold : FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
