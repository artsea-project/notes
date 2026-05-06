## Database Project

### ERD diagram
```mermaid
erDiagram
    USER {
        string user_id PK
        string email
        string password_hash
        datetime created_at
    }

    PROFILE {
        string profile_id PK
        string user_id FK
        string full_name
        jsonb bio_PLN
        jsonb bio_ENG
        string profile_image_url
    }

    LINKS {
        string link_id PK
        string profile_id FK
        string name
        string url
    }
    
    CATEGORY {
        string category_id PK
        string user_id FK
        string name_PLN
        string name_ENG 
    }

    ART_PIECE {
        string art_piece_id PK
        string user_id FK
        string category_id FK
        string title_PLN
        string title_ENG
        string dimensions
        jsonb mini_description_PLN
        jsonb mini_description_ENG
        jsonb description_PLN
        jsonb description_ENG
        datetime uploaded_at
    }

    MEDIA {
        string media_id PK
        string art_piece_id FK
        string file_url
        string file_type "png | jpg | gif | mp4 | pdf"
        int order_index 
    }

    TAG {
        string tag_id PK
        string user_id FK
        string name_PLN
        string name_ENG
    }

    ART_PIECE_TAGS {
        string art_piece_id PK, FK
        string tag_id PK, FK
    }

    SITE_SETTINGS {
        string site_settings_id PK
        string user_id FK
        jsonb theme "colors, fonts, spacing"
        jsonb layout_bento_box "grid configuration"
        jsonb layout_category_view "Pinterest-like grid configuration"
    }

    USER ||--o| PROFILE : "owns"
    USER ||--o{ CATEGORY : "creates"
    USER ||--o{ ART_PIECE : "uploads"
    ART_PIECE }o--|| CATEGORY : "belongs to"
    ART_PIECE ||--o{ MEDIA : "has"
    ART_PIECE ||--o{ ART_PIECE_TAGS : "tagged with"
    TAG ||--|{ ART_PIECE_TAGS : "tags"
    USER ||--o| SITE_SETTINGS : "configures"
    PROFILE ||--o{ LINKS : "has"
```

### Table Descriptions
- **USER**: Stores user account information including email and password hash.
- **PROFILE**: Contains user profile details such as full name, bio, profile image, and social media links.
- **CATEGORY**: Represents categories created by users to organize their art pieces.
- **ART_PIECE**: Stores information about individual art pieces uploaded by users.
- **MEDIA**: Contains media files associated with art pieces, including images and videos.
- **TAG**: Represents tags created by users to categorize their art pieces.
- **ART_PIECE_TAGS**: A join table to associate art pieces with multiple tags.
- **SITE_SETTINGS**: Stores user-specific site settings such as theme and layout configurations.
- **Relationships**:
  - A user can have one profile, multiple categories, and multiple art pieces.
  - An art piece belongs to one category and can have multiple media files and tags.
  - A tag can be associated with multiple art pieces through the ART_PIECE_TAGS join table.
