<!-- add phasqwe 1-->
## Summary of Milestones

| Milestone | Core Objective |
|---|---|
| **Phase 2: Core CMS** | Deploy the artist's administration dashboard, enabling full creation, retrieval, updating, and deletion (CRUD) of portfolio works, custom categories, and personal bio details. |
| **Phase 3: Bento Box & Personalization** | Establish the interactive grid customization UI (Bento Box layout), dynamic theme variables, custom typography, public page generation, and social media contact links. |
| **Phase 4: Optimization, Testing & Release** | Deliver multilingual support (Polish/English), server-side image compression, offline form persistence, cross-browser/RWD validation, and production deployment configuration (containerized environment and hosting instructions for platforms like Vercel and VPS). |


---

## Detailed Technical Tasks (Issues)

### Phase 2: Core CMS

#### Add Work to Portfolio
* **Description:** Implement the frontend form and backend API endpoints to upload a new portfolio piece.
* **Technical Implementation Details:**
  * **Frontend:** Create an `/admin/portfolio/new` page featuring a multi-part form. Include text inputs for titles (`titlePln`, `titleEng`), descriptions (`descriptionPln`, `descriptionEng`), dimensions (height, width, depth in cm), and year of execution (`yearOfExecution`), along with a dropdown for category selection, a visibility toggle (`isVisible`), and a file dropzone.
  * **Backend API / Upload Strategy:**
    - **Images:** Uploaded to Next.js API route `POST /api/portfolio/work`, validated using Zod, compressed (to WebP/AVIF via `sharp`), and streamed to cloud storage.
    - **Videos (up to 50MB):** Request an S3 pre-signed upload URL from a Next.js endpoint `GET /api/portfolio/upload-url`, and upload the video file directly from the browser client to the S3 bucket to bypass Vercel's 4.5MB serverless function payload limit.
  * **Database:** Using Drizzle ORM, insert a new record into the `art_piece` (`artPieces`) table containing `userId`, `categoryId`, `titlePln`, `titleEng`, `dimensions`, `descriptionPln`, `descriptionEng`, `isVisible` (boolean, default true), and `yearOfExecution` (integer). Then, insert a related record into the `media` (`media`) table mapping `artPieceId`, `fileUrl`, `fileType` ('png', 'jpg', 'gif', or 'mp4'), and `orderIndex`.
* **Acceptance Criteria:**
  - [ ] Logged-in artist can access the creation form via an "Add Work" button in the dashboard.
  - [ ] File dropzone accepts drag-and-drop actions and validates that a file is present.
  - [ ] Next.js endpoint returns a `201 Created` status with the database payload on success, or a `400 Bad Request` with validation errors on failure.
  - [ ] UI shows a success/error toast notification and redirects the user back to the list of works.

#### Edit Work Details
* **Description:** Implement endpoints and interfaces to modify metadata or replace the media file of an existing portfolio piece.
* **Technical Implementation Details:**
  * **Frontend:** Create `/admin/portfolio/edit/[id]` pre-populated with work details retrieved via a server component.
  * **Backend API:** Route Handler  `PUT/PATCH /api/portfolio/work/[id]`.
  * **Replacement Logic:** If a new file is uploaded, update the `fileUrl` and `fileType` in the `media` table. Update the metadata (`titlePln`, `titleEng`, `descriptionPln`, `descriptionEng`, `dimensions`) in the `art_piece` table. Delete the obsolete file from the cloud storage prior to saving the new URL.
* **Acceptance Criteria:**
  - [ ] Clicking the "Edit" button on a work loads its current data into the form inputs.
  - [ ] Modifying text metadata updates the PostgreSQL row in the `art_piece` table.
  - [ ] Replacing the image uploads the new media, deletes the old file from the cloud object storage, and updates the `media` table row.

#### Delete Work
* **Description:** Clean up database records and delete associated files in the cloud object storage.
* **Technical Implementation Details:**
  * **Backend API:** Route Handler `DELETE /api/portfolio/work/[id]`.
  * **Cascading/Cleanup:** Fetch the associated media record first to retrieve the cloud storage reference. Delete the file from the cloud  storage, then execute the Drizzle `delete` statement on the `art_piece` table. The foreign key constraint `.onDelete('cascade')` automatically deletes the associated row in the `media` table.
* **Acceptance Criteria:**
  - [ ] Clicking the "Delete" button displays a modal asking: *"Are you sure you want to permanently delete this work? This action cannot be undone."*
  - [ ] Confirming the deletion fires a request to `DELETE /api/portfolio/work/[id]`.
  - [ ] The row is removed from PostgreSQL and the file is deleted from the cloud object storage.

#### Add, Edit, and Delete Categories
* **Description:** Create management views and APIs to organize works by custom categories.
* **Technical Implementation Details:**
  * **Database Schema:** Use the `category` (`categories`) table which contains `categoryId`, `userId`, `namePln`, and `nameEng`.
  * **Frontend:** Embed a category administration sub-view in the dashboard allowing CRUD operations on categories, supporting text inputs for both Polish (`namePln`) and English (`nameEng`) category names.
  * **Validation & Integrity:** Ensure that duplicate names are blocked. Handle referential integrity when categories with active works are deleted (the database schema uses `.onDelete('restrict')` on the `categoryId` foreign key, blocking deletion if works exist; the application must ensure works are reassigned or deleted prior to category removal).
* **Acceptance Criteria:**
  - [ ] Form validates that the category name is non-empty and unique for the logged-in user.
  - [ ] Art pieces can be assigned to newly created categories dynamically.
  - [ ] Deleting an active category blocks deletion or prompts the user to reassign works to another category (or a default "Uncategorized" state).


#### Multiple Media Format Support (mp4, gif, png, jpg)
* **Description:** Enable support for animations and short video loops in the portfolio, alongside static images.
* **Technical Implementation Details:**
  * **Validation:** Restrict allowed file uploads in frontend dropzone and backend API to `image/png`, `image/jpeg`, `image/gif`, `pdf` and `video/mp4`.
  * **Renderer Component:** Create a unified media renderer component that inspects the `fileType` column ('png', 'jpg', 'gif', 'mp4') in the `media` table and renders a auto play tag for `mp4` and standard `<img>` tags for images/GIFs.
* **Acceptance Criteria:**
  - [ ] Artist can upload `.gif` and `.mp4` files via the dashboard upload form.
  - [ ] Form rejects executable files or unsupported formats.
  - [ ] The dashboard and portfolio pages display `.mp4` items as autoplaying, looping, muted videos.

#### Manage "About me" Section
* **Description:** Implement an author bio editor in the admin panel with support for rich text.
* **Technical Implementation Details:**
  * **Rich Text Integration:** Install and configure a editor bound to a HTML/JSON schema field
  * **Database:** Store the bio contents and avatar URL in the `profile` (`profiles`) table, mapping fields to `fullName`, `bioPln` (JSON representation for Polish), `bioEng` (JSON representation for English), and `profileImageUrl`.
* **Acceptance Criteria:**
  - [ ] Artist can type, bold, italicize, and structure bulleted lists within the bio fields (PL/EN).
  - [ ] Profile information updates correctly in PostgreSQL and renders as HTML in the public view.

---

### Phase 3: Bento Box & Personalization


#### Interactive Bento Box Editor
* **Description:** Build the interactive canvas in the admin dashboard where the artist constructs their Bento Box grid layouts. Based on the Figma design, the artist manually configures two distinct layouts: one for Web (Desktop) and one for Mobile viewports.
* **Technical Implementation Details:**
  * **Grid Engine:** Create a grid layout with resize/drag event listeners supporting responsive column states.
  * **Data Representation:** Represent layout positions as JSON coordinates structured for both viewports: `{ desktop: [{ id: string, x: number, y: number, w: number, h: number }], mobile: [{ id: string, x: number, y: number, w: number, h: number }] }`.
  * **Dual Bento Configuration:** Ensure both desktop and mobile are configured as customized Bento grids. The editor provides separate canvases or canvas modes for Web (e.g., 4-6 columns) and Mobile (e.g., 1-2 columns) so the artist can customize the layout structure for both devices.
  * **Database Integration:** Saving the layout writes this dual-viewport JSON structure to the `layoutBentoBox` (`layout_bento_box`) JSONB column in the `site_settings` table.
* **Acceptance Criteria:**
  - [ ] Admin personalization canvas displays works and bio sections as draggable, resizable grid blocks.
  - [ ] Canvas toggles allow the artist to configure the Web (Desktop) layout and the Mobile layout independently.
  - [ ] Saving the configuration writes both desktop and mobile layout coordinate arrays to the `layoutBentoBox` JSONB column in the `site_settings` table.

#### Theme Customization (Colors & Fonts)
* **Description:** Let the artist choose fonts and colors to reflect their personal brand.
* **Technical Implementation Details:**
  * **Tailwind Variables:** Map background, foreground, primary, border, and font family utilities to CSS variables in `globals.css`.
  * **Theme Configuration:** Save the chosen styling variables or preset ID in the `theme` JSONB column in the `site_settings` table.
* **Acceptance Criteria:**
  - [ ] Configuration page provides options for at least 5 preset color palettes and 3 font pairings.
  - [ ] Selecting a theme updates the admin preview instantly.
  - [ ] Public site loads and applies the user's selected styles on page load.

#### Public Portfolio Gallery View
* **Description:** Implement the  responsive portfolio page.
* **Technical Implementation Details:**
  * **Server Rendering:** Fetch user profile, layout coordinates, and works.
  * **Masonry/Bento Layout:** Render a responsive HTML grid matching the stored coordinates in `layoutBentoBox` (rendering the `desktop` coordinate array on desktop viewports and the `mobile` coordinate array on mobile viewports).
* **Acceptance Criteria:**
  - [ ] Visiting `/u/[username]` renders the public portfolio page matching the Bento layout coordinates.
  - [ ] Both desktop and mobile viewports load their respective custom-designed Bento layouts correctly..


#### Social Media Links Integration
* **Description:** Associate external social account links with the artist's profile to display on the portfolio page.
* **Technical Implementation Details:**
  * **Database Schema:** Store links as separate rows in the `links` table referencing the `profileId`. Each row contains a `name` (e.g., 'instagram', 'facebook', 'email') and `url`.
  * **Frontend Integration:** Query all links associated with the profile ID. Render corresponding icons dynamically.
* **Acceptance Criteria:**
  - [ ] Admin profile page contains input fields for Instagram, Facebook, and contact email.
  - [ ] Public page displays SVGs linked to the configured networks.
  - [ ] E-mail link utilizes the `mailto:` protocol.


---

### Phase 4: Optimization, i18n & Release

#### Multilingual Support (PL/EN)
* **Description:** Add an automated mechanism to detect the browser's local language and a switcher button to manually toggle the language.
* **Technical Implementation Details:**
  * **Locale Detection & Routing:** Parse Accept-Language headers, client language, or path parameters to determine the user's preferred language.
  * **Static UI Routing:** Resolve static system text (such as labels, navigation menus, and buttons) from translation files based on the active route locale.
  * **No Content Translation:** Ensure database schemas and API endpoints remain simple. The application does not translate the artist's custom content (titles, descriptions, bio); it renders the fields exactly as uploaded in the database (`Pln` or `Eng` suffix columns).
* **Acceptance Criteria:**
  - [ ] A language switcher button or toggle is visible in both the admin panel and the public pages.
  - [ ] On first load, the application correctly detects the visitor's browser language (PL or EN) and redirects to the appropriate localized subpath.
  - [ ] Toggling the language switcher transitions the URL subpath (e.g. from `/pl/...` to `/en/...`), updating all static labels, buttons, and system messages immediately.



#### Image and Video Upload Optimization
* **Description:** Optimize media files during upload to minimize bandwidth usage and achieve First Contentful Paint (FCP) under 2 seconds.
* **Technical Implementation Details:**
  <!-- za glupia na to jestem, nie wiem jak -->
* **Acceptance Criteria:**
  - [ ] First Contentful Paint on mobile connections (throttled 3G/4G) is under 2 seconds.

#### Offline Form Data Persistence
* **Description:** Prevent data loss when editing bios or adding new works if the network disconnects.
* **Technical Implementation Details:**
  * **Local State Synchronization:** Implement a hook that saves inputs to `localStorage` periodically (autosave).
  * **Network Status Listener:** Hook up event listeners to flag connection changes in the UI.
  * **Draft Retrieval:** On component mount, check for existing drafts in `localStorage` and display a restore prompt if found.
* **Acceptance Criteria:**
  - [ ] Losing internet connection during form input displays an offline status indicator.
  - [ ] Accidental page reloads or loss of power does not discard form data; values are loaded from `localStorage` upon page restore.
  - [ ] Successfully submitting the form deletes the local backup.

#### Responsive Web Design & Cross-browser Compatibility
* **Description:** Test layout compatibility and responsiveness on mobile/desktop viewports and popular browser engines.
* **Acceptance Criteria:**
  - [ ] Admin panels and portfolios adapt cleanly to viewports ranging from 320px up to 1920px without layout breakage or horizontal scrollbars.
  - [ ] All interactive flows operate normally on Safari (macOS/iOS), Google Chrome, Mozilla Firefox, and Microsoft Edge.

#### Deployment Configuration (Self-Hosting & Cloud Platforms)
* **Description:** Package the Next.js application inside a Docker container for self-hosting setups, and provide clear step-by-step instructions for hosting on private servers (e.g., VPS) using a containerized architecture where a PostgreSQL database container runs alongside the app, as well as instructions for deploying the frontend to cloud platforms (e.g., Vercel).
* **Technical Implementation Details:**
  * **Dockerization:** Create a production multi-stage `Dockerfile` and a `docker-compose.yml` that configures a multi-container stack. This stack must include the Next.js application container and a PostgreSQL database container.L.
  * **Database Integration:** Configure the webapp container to communicate with the PostgreSQL database container via the internal Docker bridge network, using the Postgres service container name as the hostname.
  * **Vercel Hosting Path:** Author a detailed guide explaining how to deploy the Next.js frontend to Vercel.
* **Acceptance Criteria:**
  - [ ] Multi-stage production build compiles successfully and runs inside a Docker Compose setup containing both the Next.js app and the PostgreSQL database service.
  - [ ] Database data persists across container restarts using mapped Docker volumes for the PostgreSQL container.
  - [ ] The repository includes a `deployment.md` guide 


