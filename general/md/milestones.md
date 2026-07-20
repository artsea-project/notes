## Summary of Milestones

| Milestone | Core Objective |
|---|---|
| **Phase 2: Core CMS & Public Pages** | Deploy the artist's administration dashboard and standard public pages, enabling creation, retrieval, updating, and deletion (CRUD) of portfolio works, custom categories, personal bio details, public gallery, and social media/contact links. |
| **Phase 3: Bento Box & Personalization** | Establish the interactive grid customization UI (Bento Box layout editor), dynamic category layout settings, theme color/font variables, micro-animations, and visual customization. |
| **Phase 4: Optimization, Testing & Release** | Deliver multilingual support (Polish/English), server-side image/video compression, offline form persistence, E2E testing suite, RWD validation, and production deployment configuration (Docker & VPS / Vercel). |


---

## Detailed Technical Tasks (Issues)

### Phase 2: Core CMS & Standard Public Application

#### 2.1 Public Header & Navigation Bar
* **Description:** Implement the main responsive site header and navigation bar for public visitors.
* **Technical Implementation Details:**
  * Create header component with artist brand logo, navigation links (`Home`, `Portfolio`, `O Mnie`), language toggle button (`PL`/`EN`), and an Admin Login shortcut link.
* **Acceptance Criteria:**
  - [ ] Navigation bar is visible across all public pages.
  - [ ] Navigating between `Home`, `Portfolio`, and `O Mnie` highlights active routes correctly.

#### 2.2 Global Footer Component
* **Description:** Build the site footer component containing copyright info and social media/contact links.
* **Technical Implementation Details:**
  * Query external links (`links` table) and render icons (Instagram, Behance, Email `mailto:`, LinkedIn, etc.). Display copyright notice.
* **Acceptance Criteria:**
  - [ ] Footer renders on all public pages.
  - [ ] Social and contact links dynamically load from the database and open in new tabs / email client via `mailto:`.

#### 2.3 Public "O Mnie" (About Me & Contact Links) Page
* **Description:** Build the public `/about` page displaying artist bio and media/contact links.
* **Technical Implementation Details:**
  * Fetch profile data (`profile` table) and render profile picture (`profileImageUrl`), dual-language biograms (`bioPln`, `bioEng`), and social/contact media links (Instagram, Behance, Email, etc.). *(Note: No contact form; contact is via direct email/media links).*
* **Acceptance Criteria:**
  - [ ] Visiting `/about` loads the artist's photo, dual-language bio text, and interactive media/contact links.

#### 2.4 Standard Public Gallery / Portfolio (`/portfolio`) Page
* **Description:** Implement the baseline public gallery page with category filter tabs.
* **Technical Implementation Details:**
  * Fetch all published works (`isVisible: true`) and display in a standard responsive grid layout. Add category filtering controls at the top. *(Note: Advanced Bento Grid canvas customization is deferred to Phase 3).*
* **Acceptance Criteria:**
  - [ ] Visiting `/portfolio` displays all visible works.
  - [ ] Clicking a category tab filters works by selected category.

#### 2.5 Work Detail (`/work/[id]`) Page & Modal
* **Description:** Create artwork details view with media gallery and metadata display.
* **Technical Implementation Details:**
  * Render media carousel (PNG, JPG, GIF, MP4), title, year of execution, dimensions, category, and full description. Setup Parallel/Intercepting route `@modal/(.)work/[id]` for in-page popups when opened from `/portfolio`.
* **Acceptance Criteria:**
  - [ ] Clicking an artwork in the gallery opens the detail pop-up overlay.
  - [ ] Direct URL `/work/[id]` loads as a full standalone page.

#### 2.6 Setup Auth & Admin Protection Middleware
* **Description:** Configure BetterAuth credentials/Google login and route protection.
* **Technical Implementation Details:**
  * Setup `/login` and `/register` pages. Add Next.js middleware restricting `/admin/*` routes to authenticated sessions only.
* **Acceptance Criteria:**
  - [ ] Unauthenticated requests to `/admin/*` redirect to `/login`.
  - [ ] Logged-in admin is redirected to `/admin` when attempting to visit `/login`.

#### 2.7 Admin Shell & Navigation Sidebar
* **Description:** Build the admin dashboard main shell and responsive navigation menu.
* **Technical Implementation Details:**
  * Sidebar layout with menu items (`Przegląd`, `Prace`, `Kategorie`, `Profil`), header user badge, and Logout button.
* **Acceptance Criteria:**
  - [ ] Sidebar allows seamless navigation across all admin CMS modules.

#### 2.8 Admin Dashboard Overview (`/admin`) Page
* **Description:** Create the main dashboard overview page.
* **Technical Implementation Details:**
  * Display summary metrics (total works, visible works count, category count) and quick action shortcuts.
* **Acceptance Criteria:**
  - [ ] Dashboard displays accurate DB count statistics upon login.

#### 2.9 Add Work to Portfolio
* **Description:** Implement frontend form and backend API endpoints to upload a new portfolio piece.
* **Technical Implementation Details:**
  * **Frontend:** Create `/admin/works/new` form with inputs for titles (`titlePln`, `titleEng`), descriptions (`descriptionPln`, `descriptionEng`), dimensions, year of execution, category dropdown, visibility toggle (`isVisible`), featured toggle (`isFeatured`), and file dropzone.
  * **Backend & DB:** Insert record into `art_piece` table and associated rows into `media` table.
* **Acceptance Criteria:**
  - [ ] Logged-in artist can upload new works with image/video files.
  - [ ] Endpoint returns `201 Created` and redirects back to `/admin/works`.

#### 2.10 Edit & Delete Work Details
* **Description:** Implement metadata editing, media replacement, and deletion modal with cleanup.
* **Technical Implementation Details:**
  * `/admin/works/[id]/edit` pre-populated with work data.
  * Confirmation modal for deletion firing `DELETE /api/works/[id]` with cloud media cleanup.
* **Acceptance Criteria:**
  - [ ] Editing updates DB records in `art_piece` and `media`.
  - [ ] Deleting removes database rows and deletes files from object storage.

#### 2.11 Category CRUD Management (PU9, PU10)
* **Description:** Manage dual-language categories (`namePln`, `nameEng`).
* **Technical Implementation Details:**
  * Dedicated `/admin/categories` page for adding/editing categories. Block deleting categories containing active works without prior reassignment.
* **Acceptance Criteria:**
  - [ ] Categories can be created, updated, and assigned to works.
  - [ ] Deleting an active category blocks deletion or requires reassigning works.

#### 2.12 Manage Profile & Bio Section (PU11)
* **Description:** Implement author bio editor in the admin panel with rich text support.
* **Technical Implementation Details:**
  * Profile form on `/admin/profile` storing `fullName`, `bioPln`, `bioEng`, and `profileImageUrl` in the `profile` table.
* **Acceptance Criteria:**
  - [ ] Artist can edit Polish/English bio text and upload profile picture.

#### 2.13 Social & Contact Media Links Manager
* **Description:** Manage external social profile and contact media links (`links` table).
* **Technical Implementation Details:**
  * Sub-view on `/admin/profile` to add, edit, or delete external links (Instagram, Behance, Email `mailto:`, etc.).
* **Acceptance Criteria:**
  - [ ] Links update correctly and reflect instantly on the public website footer and "O Mnie" page.

---

### Phase 3: Bento Box & Personalization

#### 3.1 Public Bento Grid Component (`BentoGrid` & `BentoCard`)
* **Description:** Build the public grid component that reads stored Bento layout coordinates and renders responsive cards.
* **Technical Implementation Details:**
  * Read `siteSettings.layoutBentoBox` JSON (desktop/mobile arrays). Render dynamic grid cells using Tailwind CSS grid column/row spans based on coordinates (`x`, `y`, `w`, `h`).
* **Acceptance Criteria:**
  - [ ] `/portfolio` displays artworks matching the stored Bento grid layout positions.
  - [ ] Grid seamlessly switches between Desktop layout (4-6 cols) and Mobile layout (1-2 cols) based on viewport breakpoint.

#### 3.2 Interactive Bento Box Canvas Editor (`/admin/layout`) (PU12)
* **Description:** Build the drag-and-drop personalization canvas in the admin dashboard.
* **Technical Implementation Details:**
  * Interactive canvas powered by grid drag-and-drop library (e.g. `@dnd-kit` or `react-grid-layout`). Toggles for **Desktop Canvas** and **Mobile Canvas**.
  * "Save Layout" action sends `PUT /api/site-settings` updating `layoutBentoBox` column in `site_settings` table.
* **Acceptance Criteria:**
  - [ ] Admin can drag, resize, and reorder artwork cards on both Desktop and Mobile canvases.
  - [ ] Clicking save persists updated coordinate arrays to PostgreSQL.

#### 3.3 Category View Layout Customizer (`layoutCategoryView`)
* **Description:** Allow the artist to customize default grid settings when visitors filter by a specific category.
* **Technical Implementation Details:**
  * Option to set target column count (2, 3, or 4 columns), aspect ratio constraint, and card gap size. Saves to `layoutCategoryView` JSONB column in `site_settings`.
* **Acceptance Criteria:**
  - [ ] Custom category grid settings apply when filtering works by category on `/portfolio`.

#### 3.4 Dynamic Theme & Color Palette Customizer
* **Description:** Allow the artist to configure theme colors (background, card background, primary text, accent color).
* **Technical Implementation Details:**
  * Inject CSS custom properties (`:root { --bg-color: ...; --accent-color: ...; }`) dynamically on page load based on `siteSettings.theme`. Provide 5 preset color palettes + custom color inputs in `/admin/layout`.
* **Acceptance Criteria:**
  - [ ] Color changes in admin theme customizer immediately reflect across the public site.

#### 3.5 Typography & Font Pairings Customizer
* **Description:** Allow the artist to select typography font pairings for headings and body text.
* **Technical Implementation Details:**
  * Load selected Google Fonts dynamically via `next/font` (e.g., Inter, Playfair Display, Space Grotesk, Outfit) based on `siteSettings.theme.fontFamily`.
* **Acceptance Criteria:**
  - [ ] Selected font pairing applies cleanly to headings and body text across the portfolio.

#### 3.6 Micro-animations & Visual Polish
* **Description:** Enhance user experience with smooth transitions and subtle micro-animations.
* **Technical Implementation Details:**
  * Add Framer Motion / Tailwind animations for artwork hover states (subtle image scale), category filter transitions, and modal pop-up backdrop fade-ins.
* **Acceptance Criteria:**
  - [ ] Hovering over gallery cards smoothly scales images without layout shift.
  - [ ] Category tab filtering and modal popups animate smoothly.

---

### Phase 4: Optimization, i18n, Testing & Release

#### 4.1 Multilingual (i18n) Engine & Locale Switcher (PU3)
* **Description:** Implement dynamic language toggling (PL/EN) with localized routes and translation fallbacks.
* **Technical Implementation Details:**
  * Setup locale prefixing (`/pl/...` and `/en/...`) or middleware locale detection. Static system texts (nav, buttons, labels) resolved from `locales/pl.json` and `locales/en.json`.
  * Fallback logic: If custom artist content (title, description, bio) lacks an English translation, render Polish content without throwing errors.
* **Acceptance Criteria:**
  - [ ] Toggling language switcher immediately updates UI labels and route locale.
  - [ ] Missing translations fallback gracefully to Polish.

#### 4.2 Media Compression & Pipeline Optimization
* **Description:** Optimize image and video loading for sub-2-second First Contentful Paint (FCP).
* **Technical Implementation Details:**
  * Server-side image conversion to WebP/AVIF via `sharp` in Next.js upload API route. Generate low-resolution blur placeholders (`blurDataURL`) for Next.js `<Image>` components.
  * Optimize MP4 video loops (muted, autoplay, inline play, compressed bitrate).
* **Acceptance Criteria:**
  - [ ] Uploaded images are compressed to WebP/AVIF with reduced file sizes.
  - [ ] FCP loads under 2 seconds on 4G connection.

#### 4.3 Offline Form Draft Persistence
* **Description:** Prevent loss of un-submitted form data during network drops or accidental tab closes.
* **Technical Implementation Details:**
  * React hook saving form field state to `localStorage` on input change. Add network status listener (`online`/`offline` events) displaying a warning banner if connection drops. Restore draft prompt on mount.
* **Acceptance Criteria:**
  - [ ] Disconnecting internet while writing a bio or work description displays an offline status indicator.
  - [ ] Reloading the page restores draft data from `localStorage`.
  - [ ] Successful submission clears the local draft.

#### 4.4 Automated E2E & Component Testing Suite
* **Description:** Establish automated test suite with Playwright, React Testing Library, and MSW.
* **Technical Implementation Details:**
  * **Playwright E2E:** Test admin login -> create work -> view in public portfolio -> edit work -> delete work.
  * **RTL & MSW:** Unit test Bento Grid coordinate renderer, category filter, and API route handlers.
* **Acceptance Criteria:**
  - [ ] Playwright E2E suite passes all key user journeys.
  - [ ] Unit tests pass with clean test coverage.

#### 4.5 Responsive Web Design (RWD) & Cross-Browser Validation
* **Description:** Audit layout responsiveness and cross-browser functionality.
* **Technical Implementation Details:**
  * Validate viewports from 320px (mobile) up to 1920px+ (desktop). Test on Chrome, Firefox, Safari (macOS & iOS), and Edge.
* **Acceptance Criteria:**
  - [ ] App renders without horizontal scrollbars or broken layouts on all target devices.

#### 4.6 Containerized Deployment (Docker & VPS / Vercel)
* **Description:** Package app in multi-stage Docker setup and author deployment documentation.
* **Technical Implementation Details:**
  * Create multi-stage `Dockerfile` and `docker-compose.yml` linking Next.js app container with PostgreSQL database container (with mapped data volume). Include Vercel cloud deployment guide in `deployment.md`.
* **Acceptance Criteria:**
  - [ ] `docker compose up` builds and runs both webapp and database seamlessly.
  - [ ] Database data persists across container restarts.
  - [ ] `deployment.md` documentation is ready in repository.
