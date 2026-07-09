# Portfolio Website Design Style Guide

This document defines the visual design system, typography tokens, layout grid rules, and code patterns for the **R. Borger-Johnson Portfolio Website**. Both developers and AI assistants should refer to this guide when creating new pages or components to maintain pixel-perfect design continuity.

---

## 🎨 Color System (Warm & Earthy Theme)

The palette is designed to look editorial, natural, and warm, avoiding harsh high-contrast blacks or saturated primaries.

| Token | Hex Value | Flutter Constructor | Primary Use Case |
| :--- | :--- | :--- | :--- |
| **Cream Background** | `#FAF6EE` | `Color(0xFFFAF6EE)` | Main scaffold background, high-end negative space. |
| **Terracotta Accent** | `#D36135` | `Color(0xFFD36135)` | Primary buttons, headers, active states, graphic accents. |
| **Sage Green Accent** | `#7A8B7B` | `Color(0xFF7A8B7B)` | Secondary buttons, tags, coding skills, secondary subtitles. |
| **Warm Wood (Charcoal)**| `#2F251E` | `Color(0xFF2F251E)` | Body text, bold headings, dark borders, footer background. |
| **Sand Surface** | `#EAE3D2` | `Color(0xFFEAE3D2)` | Card containers, surface shading, navbar borders. |
| **Sage Green Light** | `#E8ECE8` | `Color(0xFFE8ECE8)` | Badges background, code tags, soft background containers. |
| **Terracotta Light** | `#FBF1EC` | `Color(0xFFFBF1EC)` | Decorative graphic fills, highlights. |

---

## ✍️ Typography Tokens

Always use **Google Fonts** to load custom type styles. Never use system default fonts.

### 1. Headings (Editorial & Serif)
*   **Font Family**: `Fraunces` (Serif)
*   **Color**: `kWarmWood` (`0xFF2F251E`)
*   **Styles**:
    *   **Hero Large Titles**: `fontSize: 54`, `fontWeight: FontWeight.bold`, `height: 1.15`
    *   **Section Headers**: `fontSize: 32`, `fontWeight: FontWeight.bold`
    *   **Card Titles**: `fontSize: 19`, `fontWeight: FontWeight.bold`

### 2. UI Controls & Body Copy (Clean & Sans-Serif)
*   **Font Family**: `Plus Jakarta Sans` (Geometric Sans-Serif)
*   **Styles**:
    *   **Section Overlines**: `fontSize: 13`, `fontWeight: FontWeight.w800`, `letterSpacing: 2.0`, Color: `kSageGreen` or `kTerracotta`
    *   **Body Copy**: `fontSize: 15`, `height: 1.6`, Color: `kWarmWood.withOpacity(0.85)`
    *   **Technical Badges**: `fontSize: 12`, `fontWeight: FontWeight.w600`, Color: `kSageGreen`
    *   **Navbar Buttons**: `fontSize: 15`, `fontWeight: FontWeight.w600`, Color: `kWarmWood` (hover: `kTerracotta`)

---

## 📐 Layout & Spacing

*   **Spacing Grid**: Multiples of `8` (e.g., `8`, `16`, `24`, `32`, `48`, `64`, `80`).
*   **Section Wrapper Padding**: Vertical `80.0`, Horizontal `24.0`.
*   **Page Constraints**: Max width of `1100` on desktop. Wrap section content inside:
    ```dart
    ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: child,
    )
    ```
*   **Responsive Width Threshold**: `768` determines mobile vs desktop layouts.
    *   **Desktop (Width >= 768)**: Columns side-by-side (`Row`), full horizontal navbar.
    *   **Mobile (Width < 768)**: Columns stacked (`Column`), hamburger menu with drawer.

---

## 🖱️ Interactive Micro-Animations

To ensure the page feels interactive and premium, all buttons, links, and cards must implement subtle hover states.

### 1. Hoverable Card Animation
Cards must scale up slightly, slide upwards, and cast a soft shadow when hovered.
*   **Duration**: `250.ms`
*   **Curve**: `Curves.easeOutCubic`
*   **Scale**: `1.03` (x and y)
*   **Translate Offset**: `Offset(0, -6)`
*   **BoxShadow (Default)**: `kWarmWood.withOpacity(0.04)`, blur `8`, offset `(0, 4)`
*   **BoxShadow (Hover)**: `kWarmWood.withOpacity(0.12)`, blur `18`, offset `(0, 10)`

### 2. Nav Underline Animation
Navbar links animate an underline expansion on hover:
*   **Line Height**: `2`
*   **Line Color**: `kTerracotta`
*   **Width transition**: From `0` to `24` on hover.

---

## 🤖 Instructions for AI Generation (System Prompts)

When generating new pages or widgets for this site, follow these instructions:
1.  **Imports**: Always import `google_fonts`, `font_awesome_flutter`, and `flutter_animate`.
2.  **Color Constants**: Read and utilize colors from `package:rborgerjohnsonportfoilio/Style/portfolio_theme.dart` (or copy the constants block directly).
3.  **Contrast**: Never use pure black (`#000`) or pure white (`#FFF`). Use `kWarmWood` and `kCreamBg` for a soft, professional look.
4.  **Entrance Transitions**: Animate elements entering the viewport using:
    ```dart
    widget.animate().fadeIn(duration: 600.ms).slideY(begin: 0.15, end: 0)
    ```
5.  **Responsiveness**: Always use `MediaQuery.of(context).size.width` to check for `screenWidth < 768` and lay out components vertically on mobile.
6.  **Icons**: Always use `FaIcon` (from FontAwesome) with `FaIconData` for brand assets (GitHub, LinkedIn, Behance), and standard `Icon` with `IconData` for generic Material symbols (person, description, arrow).
