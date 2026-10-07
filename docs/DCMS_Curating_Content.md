# DCMS - Dynamic Content and Menuing System

## Curating Content

### Overview

A flexible content delivery system that stores various content types in the database and displays them through a unified card-based viewer interface. 
Each dynamically created menu item contains a slug value that locates the content for display in a card based on content type.

## Database Schema

### Table: Content

| Column Name      | Data Type          | Constraints                    | Description                           |
|------------------|--------------------|--------------------------------|---------------------------------------|
| ContentId        | int                | PK, IDENTITY(1,1)              | Primary key                           |
| MenuItemID       | int                | FK → MenuItem.MenuID, NOT NULL | MenuItem that triggered the content   |
| ContentCode      | nvarchar(10)       | FK → ContentType.Code          | Type of content (HTM, MD, IMG, etc.)  |
| Description      | nvarchar(500)      | NULL                           | Brief description/summary             |
| Slug             | nvarchar(100)      | UNIQUE, NOT NULL, INDEXED      | Matches slug from menuitem URL        |
| TextContent      | nvarchar(max)      | NULL                           | Text content (HTML, Markdown)         |
| BinaryContent    | varbinary(max)     | NULL                           | Binary file content (images, PDFs)    |
| Metadata         | nvarchar(100)      | NOT NULL                       | Set by currator, Author, Readtime etc |
| LocalFilePath    | nvarchar(255)      | NULL                           | Reference to original source file     |
| ExternalFilePath | nvarchar(500)      | NULL                           | Reference to external content         |
| MimeType         | nvarchar(100)      | NULL                           | MIME type (text/html, image/jpeg)     |
| IsPublished      | bit                | NOT NULL, DEFAULT 1            | Active/inactive flag          
| CreatedDate      | datetime2          | NOT NULL, DEFAULT GETDATE()    | Creation timestamp                    |
| ModifiedDate     | datetime2          | NULL                           | Last modification timestamp           |
* indicates not yet implemented

**Indexes:**
- `IX_ContentItems_Slug` (UNIQUE, NONCLUSTERED)
- `IX_ContentItems_ContentType` (NONCLUSTERED)
- `IX_ContentItems_IsPublished` (NONCLUSTERED)

### Table: MenuItem association with Slug values in Content

Each content menu item has a Url that is created from a normalized menu item title. For example, 'What is PG?' creates a query string with 'C=What%20is%20PG', which strips special characters and replaces blanks with %20.  This works will for creating the dynamic menu items.  Those menu items must match to content in the Content table by doing a search on the 'Slug', which is generated from the menu item Url.
Given a Title of 'What is PG?', it would generate a Url = '/Content?C=What%20is%20PG'.  There is a direct link between the Menu Item Slug and the Content Slug to where you could search the Content table or even do an inner join from MenuItem to the Content table. 
A SQL routine exists called NormalizeSlugFromUrl that is used in the MenuItemList view to generate the Slug value from the menu item URL.  This same routine can be used to generate the Slug value for the Content table when content is created.  This will ensure that the Slug values are consistent between the MenuItem and Content tables.

### Update Existing: ContentTypes

Add new rows for content types:

| Code | Name              | Description                       | SortOrder |
|------|-------------------|-----------------------------------|-----------|
| HTM  | HTML Document     | Filtered HTML files (.htm)        | 10        |
| MD   | Markdown          | Markdown documents (.md)          | 20        |
| IMG  | Image             | Single image display              | 30        |
| GAL  | Image Gallery     | Collection of images              | 40        |
| VID  | Video             | Video content                     | 50        |
| PDF  | PDF Document      | PDF files                         | 60        |

## Navigation Flow

| Step | Action                                      | Details                                    |
|------|---------------------------------------------|--------------------------------------------|
| 1    | User clicks menu item                       | MenuItem with RouteType='C'                |
| 2    | Navigate to `/Content?C=<slug>`             | Slug passed as query parameter             |
| 3    | Content/Index.cshtml loads                  | Page handler executes                      |
| 4    | Fetch ContentItem by slug                   | Query: `WHERE Slug = @slug AND IsPublished=1` |
| 5    | Check visitor permissions                   | Validate VisitorMask against CurrentVisitor|
| 6    | Route to appropriate viewer                 | Based on ContentType                   |
| 7    | Render in PG-branded card layout            | Consistent UI across content types         |

## Rendering Strategy

### Option 1: Single Page with Conditional Rendering (Recommended)
- /Content/Index.cshtml loads content metadata
- Renders appropriate Razor Component based on ContentType
- Uses shared _ContentCard.razor component for consistent branding
- Each content type has a specialized inner component

### Option 2: Type-Specific Pages
- /Content/Index.cshtml redirects to type-specific viewers
- /Content/Html.cshtml, /Content/Markdown.cshtml, etc.
- More pages to maintain, but cleaner separation

### Option 3: Hybrid Approach (Most Flexible)
- Default to Option 1 for standard content
- Special content types redirect to custom pages
- Allows for content-specific features (e.g., gallery navigation)

## Card Component Structure

ContentCardBase.razor (shared layout)
- Header (Title, metadata)
- ContentViewerSlot (content-type specific)
  - HtmlViewer.razor
  - MarkdownViewer.razor
  - ImageViewer.razor
  - GalleryViewer.razor
- Footer (actions, tags, breadcrumbs)

## Implementation Phases

### Phase 1: Foundation
- Create ContentItems table
- Update MenuItem and ContentTypes
- Build basic Content/Index page
- Create ContentCardBase component

### Phase 2: Content Viewers
- HTML viewer (render stored HTML)
- Markdown viewer (use Markdig library)
- Image viewer (single image display)

### Phase 3: Advanced Features
- Gallery viewer (multiple images, carousel)
- Video player integration
- PDF viewer

### Phase 4: Content Management
- Admin page to upload/edit content
- Bulk import utility
- Content versioning

## Future Use Cases

1. **Content Series/Collections**
   - Group related content (e.g., tutorial series)
   - Previous/Next navigation

2. **Search & Tagging**
   - Full-text search across content
   - Tag-based filtering

3. **Dynamic Menus**
   - Auto-generate menu items from content folders
   - Content categories as submenu items

4. **User-Generated Content**
   - Comments/feedback on content
   - Content ratings

5. **Content Analytics**
   - Track views, popular content
   - Visitor engagement metrics

6. **Multi-Language Support**
   - Store content in multiple languages
   - Visitor language preference

7. **Content Scheduling**
   - Publish/expire dates
   - Draft/Published workflow

8. **External Content Integration**
   - Link to external resources
   - Embed third-party content (YouTube, etc.)

## Technical Considerations

- **Security**: Validate/sanitize HTML content before rendering
- **Performance**: Cache rendered content, lazy-load images
- **Responsive**: Card layout adapts to mobile/tablet/desktop
- **Accessibility**: Proper ARIA labels, keyboard navigation
- **SEO**: Meta tags, semantic HTML structure

## Dependencies

- **Markdig** (NuGet) - Markdown to HTML conversion
- Consider: BlazorMonaco for code syntax highlighting
- Consider: Swiper.js or similar for gallery carousel

## Notes

- Start with simple read-only display
- Content upload can be manual SQL inserts initially
- Build admin interface in Phase 4
- Keep card styling consistent with Dashboard project