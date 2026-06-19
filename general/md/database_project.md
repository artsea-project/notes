## Database Project

### ERD diagram
```mermaid
erDiagram
    USER {
        uuid user_id PK
        string username UNIQUE
        string email UNIQUE
        string password_hash
        timestamp email_verified_at
        timestamp created_at
    }

    PROFILE {
        uuid profile_id PK
        uuid user_id FK, UNIQUE
        string full_name
        jsonb bio_pln
        jsonb bio_eng
        string profile_image_url
    }

    EMAIL_VERIFICATION_TOKEN {
        string token PK
        uuid user_id FK
        timestamp expires_at
    }

    LINKS {
        uuid link_id PK
        uuid profile_id FK
        string name
        string url
    }
    
    CATEGORY {
        uuid category_id PK
        uuid user_id FK
        string name_pln
        string name_eng
    }

    ART_PIECE {
        uuid art_piece_id PK
        uuid user_id FK
        uuid category_id FK
        boolean is_featured
        boolean is_visible
        string title_pln
        string title_eng
        string dimensions
        int year_of_execution
        jsonb mini_description_pln
        jsonb mini_description_eng
        jsonb description_pln
        jsonb description_eng
        timestamp uploaded_at
    }

    MEDIA {
        uuid media_id PK
        uuid art_piece_id FK
        string file_url
        string file_type
        int order_index
    }

    TAG {
        uuid tag_id PK
        uuid user_id FK
        string name_pln
        string name_eng
    }

    ART_PIECE_TAGS {
        uuid art_piece_id PK, FK
        uuid tag_id PK, FK
    }

    SITE_SETTINGS {
        uuid site_settings_id PK
        uuid user_id FK, UNIQUE
        jsonb theme
        jsonb layout_bento_box
        jsonb layout_category_view
    }

    USER ||--|| PROFILE : "owns"
    USER ||--o{ EMAIL_VERIFICATION_TOKEN : "receives"
    USER ||--o{ CATEGORY : "creates"
    USER ||--o{ ART_PIECE : "uploads"
    ART_PIECE }o--|| CATEGORY : "belongs_to"
    ART_PIECE ||--o{ MEDIA : "has"
    ART_PIECE ||--o{ ART_PIECE_TAGS : "tagged_with"
    TAG ||--o{ ART_PIECE_TAGS : "associated_with"
    USER ||--|| SITE_SETTINGS : "configures"
    PROFILE ||--o{ LINKS : "contains"
```

### Table Descriptions
- **USER**: Stores user account credentials and authentication metadata (including email, username, password hash, and verification status).
- **PROFILE**: Contains user profile details (full name, multi-language bios, and avatar URL) linked 1:1 with the USER.
- **EMAIL_VERIFICATION_TOKEN**: Stores session-restricted tokens for email validation, expiring after 60 minutes.
- **LINKS**: Stores external social profiles (Instagram, Facebook) or links mapped under the profile.
- **CATEGORY**: Mapped categories used by artists to group their works. Category names are unique per artist.
- **ART_PIECE**: Stores descriptive metadata for art pieces, supporting Polish and English versions and viewport visibility flags.
- **MEDIA**: Associates media URLs (images, mp4 loop assets) with art pieces.
- **TAG**: User-defined tag entities for taxonomy.
- **ART_PIECE_TAGS**: Join table mapping art pieces to tag relations.
- **SITE_SETTINGS**: Stores customized themes (JSON) and Bento Box coordinate definitions.
- **Relationships**:
  - A user has exactly one profile and one set of site settings (1:1).
  - A user can receive verification tokens, create categories, and upload art pieces.
  - An art piece belongs to a single category (restricted deletion rules apply) and features multiple media files/tags.
  - Social links are owned by the profile, and tags are mapped via join tables.

### Drizzle ORM Schema

```typescript
import { pgTable, text, jsonb, boolean, integer, timestamp, uuid, primaryKey, foreignKey, unique } from 'drizzle-orm/pg-core';
import { relations } from 'drizzle-orm';

// User Table
// ALT: userId: serial('user_id').primaryKey().generatedAlwaysAsIdentity()
export const users = pgTable('user', {
    userId: uuid('user_id').primaryKey().defaultRandom(),
    username: text('username').notNull().unique(),
    email: text('email').notNull().unique(),
    passwordHash: text('password_hash').notNull(),
    emailVerified: timestamp('email_verified_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
});

// Profile Table
// ALT: profileId: serial('profile_id').primaryKey().generatedAlwaysAsIdentity()
export const profiles = pgTable(
    'profile',
    {
        profileId: uuid('profile_id').primaryKey().defaultRandom(),
        userId: uuid('user_id').notNull().unique(),
        fullName: text('full_name').notNull(),
        bioPln: jsonb('bio_pln'),
        bioEng: jsonb('bio_eng'),
        profileImageUrl: text('profile_image_url'),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'profile_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Email Verification Token Table
export const emailVerificationTokens = pgTable(
    'email_verification_token',
    {
        token: text('token').primaryKey(),
        userId: uuid('user_id').notNull(),
        expiresAt: timestamp('expires_at', { withTimezone: true }).notNull(),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'email_verification_token_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Links Table
// ALT: linkId: serial('link_id').primaryKey().generatedAlwaysAsIdentity()
export const links = pgTable(
    'links',
    {
        linkId: uuid('link_id').primaryKey().defaultRandom(),
        profileId: uuid('profile_id').notNull(),
        name: text('name').notNull(),
        url: text('url').notNull(),
    },
    (table) => [
        foreignKey({
            columns: [table.profileId],
            foreignColumns: [profiles.profileId],
            name: 'links_profile_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Category Table
// ALT: categoryId: serial('category_id').primaryKey().generatedAlwaysAsIdentity()
export const categories = pgTable(
    'category',
    {
        categoryId: uuid('category_id').primaryKey().defaultRandom(),
        userId: uuid('user_id').notNull(),
        namePln: text('name_pln').notNull(),
        nameEng: text('name_eng').notNull(),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'category_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
        unique('category_user_name_pln_uq').on(table.userId, table.namePln),
        unique('category_user_name_eng_uq').on(table.userId, table.nameEng),
    ]
);

// Tag Table
// ALT: tagId: serial('tag_id').primaryKey().generatedAlwaysAsIdentity()
export const tags = pgTable(
    'tag',
    {
        tagId: uuid('tag_id').primaryKey().defaultRandom(),
        userId: uuid('user_id').notNull(),
        namePln: text('name_pln'),
        nameEng: text('name_eng'),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'tag_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Art Piece Table
// ALT: artPieceId: serial('art_piece_id').primaryKey().generatedAlwaysAsIdentity()
export const artPieces = pgTable(
    'art_piece',
    {
        artPieceId: uuid('art_piece_id').primaryKey().defaultRandom(),
        userId: uuid('user_id').notNull(),
        categoryId: uuid('category_id').notNull(),
        isFeatured: boolean('is_featured').notNull().default(false),
        isVisible: boolean('is_visible').notNull().default(true),
        titlePln: text('title_pln'),
        titleEng: text('title_eng'),
        dimensions: text('dimensions'),
        yearOfExecution: integer('year_of_execution'),
        miniDescriptionPln: jsonb('mini_description_pln'),
        miniDescriptionEng: jsonb('mini_description_eng'),
        descriptionPln: jsonb('description_pln'),
        descriptionEng: jsonb('description_eng'),
        uploadedAt: timestamp('uploaded_at', { withTimezone: true }).notNull().defaultNow(),
        gridWidth: integer('grid_width').default(1),
        gridHeight: integer('grid_height').default(1),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'art_piece_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
        foreignKey({
            columns: [table.categoryId],
            foreignColumns: [categories.categoryId],
            name: 'art_piece_category_fk',
        }).onDelete('restrict').onUpdate('cascade'),
    ]
);

// Media Table
// ALT: mediaId: serial('media_id').primaryKey().generatedAlwaysAsIdentity()
export const media = pgTable(
    'media',
    {
        mediaId: uuid('media_id').primaryKey().defaultRandom(),
        artPieceId: uuid('art_piece_id').notNull(),
        fileUrl: text('file_url').notNull(),
        fileType: text('file_type', { enum: ['png', 'jpg', 'gif', 'mp4'] }).notNull(),
        orderIndex: integer('order_index').notNull(),
    },
    (table) => [
        foreignKey({
            columns: [table.artPieceId],
            foreignColumns: [artPieces.artPieceId],
            name: 'media_art_piece_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Art Piece Tags (Join Table)
export const artPieceTags = pgTable(
    'art_piece_tags',
    {
        artPieceId: uuid('art_piece_id').notNull(),
        tagId: uuid('tag_id').notNull(),
    },
    (table) => [
        primaryKey({
            columns: [table.artPieceId, table.tagId],
            name: 'art_piece_tags_pk',
        }),
        foreignKey({
            columns: [table.artPieceId],
            foreignColumns: [artPieces.artPieceId],
            name: 'art_piece_tags_art_piece_fk',
        }).onDelete('cascade').onUpdate('cascade'),
        foreignKey({
            columns: [table.tagId],
            foreignColumns: [tags.tagId],
            name: 'art_piece_tags_tag_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Site Settings Table
// ALT: siteSettingsId: serial('site_settings_id').primaryKey().generatedAlwaysAsIdentity()
export const siteSettings = pgTable(
    'site_settings',
    {
        siteSettingsId: uuid('site_settings_id').primaryKey().defaultRandom(),
        userId: uuid('user_id').notNull().unique(),
        theme: jsonb('theme'),
        layoutBentoBox: jsonb('layout_bento_box'),
        layoutCategoryView: jsonb('layout_category_view'),
    },
    (table) => [
        foreignKey({
            columns: [table.userId],
            foreignColumns: [users.userId],
            name: 'site_settings_user_fk',
        }).onDelete('cascade').onUpdate('cascade'),
    ]
);

// Relations
export const usersRelations = relations(users, ({ one, many }) => ({
    profile: one(profiles),
    categories: many(categories),
    artPieces: many(artPieces),
    tags: many(tags),
    siteSettings: one(siteSettings),
}));


export const profilesRelations = relations(profiles, ({ one, many }) => ({
    user: one(users, {
        fields: [profiles.userId],
        references: [users.userId],
    }),
    links: many(links),
}));

export const linksRelations = relations(links, ({ one }) => ({
    profile: one(profiles, {
        fields: [links.profileId],
        references: [profiles.profileId],
    }),
}));

export const categoriesRelations = relations(categories, ({ one, many }) => ({
    user: one(users, {
        fields: [categories.userId],
        references: [users.userId],
    }),
    artPieces: many(artPieces),
}));

export const tagsRelations = relations(tags, ({ one, many }) => ({
    user: one(users, {
        fields: [tags.userId],
        references: [users.userId],
    }),
    artPieces: many(artPieceTags),
}));

export const artPiecesRelations = relations(artPieces, ({ one, many }) => ({
    user: one(users, {
        fields: [artPieces.userId],
        references: [users.userId],
    }),
    category: one(categories, {
        fields: [artPieces.categoryId],
        references: [categories.categoryId],
    }),
    media: many(media),
    tags: many(artPieceTags),
}));

export const mediaRelations = relations(media, ({ one }) => ({
    artPiece: one(artPieces, {
        fields: [media.artPieceId],
        references: [artPieces.artPieceId],
    }),
}));

export const artPieceTagsRelations = relations(artPieceTags, ({ one }) => ({
    artPiece: one(artPieces, {
        fields: [artPieceTags.artPieceId],
        references: [artPieces.artPieceId],
    }),
    tag: one(tags, {
        fields: [artPieceTags.tagId],
        references: [tags.tagId],
    }),
}));

export const siteSettingsRelations = relations(siteSettings, ({ one }) => ({
    user: one(users, {
        fields: [siteSettings.userId],
        references: [users.userId],
    }),
}));
```
