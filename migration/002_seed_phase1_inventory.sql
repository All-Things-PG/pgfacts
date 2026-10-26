-- Idempotent Phase 1 URL and record classification seed.
-- Uses the existing 32-page inventory and 23 list rows in Migration.
SET NOCOUNT ON;
SET XACT_ABORT ON;
IF DB_NAME() <> N'Migration'
    THROW 51001, 'Run this script only in the Migration database.', 1;
BEGIN TRANSACTION;

UPDATE dbo.HtmlList SET ItemTitle=Description WHERE ItemTitle IS NULL AND Description IS NOT NULL;

DECLARE @PageSeed TABLE (PageName nvarchar(200), SourceType nvarchar(40), SourceUrl nvarchar(1000), IsCanonical bit);
INSERT INTO @PageSeed (PageName, SourceType, SourceUrl, IsCanonical) VALUES
(N'Home', N'Home', N'https://www.allthingspg.org/', 1),
(N'News & Events', N'Listing', N'https://www.allthingspg.org/news-and-events', 1),
(N'Contact Us', N'Page', N'https://www.allthingspg.org/contact', 1),
(N'Donate', N'Page', N'https://www.allthingspg.org/donate', 1),
(N'Subscribe for Updates', N'Page', N'https://www.allthingspg.org/subscribe', 1),
(N'Data and Privacy', N'Page', N'https://www.allthingspg.org/data-and-privacy', 1),
(N'What is PG?', N'Page', N'https://www.allthingspg.org/what-is-pg', 1),
(N'PG Symptoms', N'Page', N'https://www.allthingspg.org/pg-symptoms', 1),
(N'PG Causes', N'Page', N'https://www.allthingspg.org/pg-causes', 1),
(N'Diagnosis of PG', N'Page', N'https://www.allthingspg.org/diagnosis-of-pg', 1),
(N'Treatment of PG', N'Page', N'https://www.allthingspg.org/treatment-of-pg', 1),
(N'Associated Health Issues', N'Page', N'https://www.allthingspg.org/associated-health-issues', 1),
(N'Take the PG Survey', N'Survey', N'https://www.allthingspg.org/take-the-pg-survey', 1),
(N'Talking About PG', N'Page', N'https://www.allthingspg.org/talking-about-pg', 1),
(N'How to Identify PG', N'Page', N'https://www.allthingspg.org/how-to-identify-pg', 1),
(N'Rare Disease Affiliates', N'Page', N'https://www.allthingspg.org/rare-disease-affiliates', 1),
(N'Pyoderma Gangrenosum Clinic Finder', N'Directory', N'https://www.allthingspg.org/pyoderma-gangrenosum-clinic-finder', 1),
(N'Industry Partners', N'Page', N'https://www.allthingspg.org/industry-partners', 1),
(N'Our People', N'Directory', N'https://www.allthingspg.org/our-people', 1),
(N'Mission Statement', N'Page', N'https://www.allthingspg.org/mission-statement', 1),
(N'Dr. Alex Ortega Loayza', N'Profile', N'https://www.allthingspg.org/dr-alex-ortega-loayza', 1),
(N'Corlis Watkins-Nass', N'Profile', N'https://www.allthingspg.org/corlis-watkins-nass', 1),
(N'Dave DePottie', N'Profile', N'https://www.allthingspg.org/dave-depottie', 1),
(N'Lasaunia Thompson', N'Profile', N'https://www.allthingspg.org/lasaunia-thompson', 1),
(N'LaGail Odoms', N'Profile', N'https://www.allthingspg.org/lagail-odoms', 1),
(N'Gina Castelli', N'Profile', N'https://www.allthingspg.org/gina-castelli', 1),
(N'November 14 PFAC', N'Event', N'https://www.allthingspg.org/november-pfac', 1),
(N'Phase 3 Clinical Trial for Spesolimab', N'Research', N'https://www.allthingspg.org/phase-3-clinical-trial-for-spesolimab', 1),
(N'First PFAC Meeting in Michigan', N'Event', N'https://www.allthingspg.org/first-pfac-meeting-in-michigan', 1),
(N'July 2026 All Things PG Newsletter', N'Newsletter', N'https://www.allthingspg.org/1-yr-anniversary-celebration-newsletter', 1),
(N'First Year Anniversary Celebration', N'Event', N'https://www.allthingspg.org/anniversary-celebration', 1),
(N'Welcome to All Things PG', N'NewsItem', N'https://www.allthingspg.org/welcome-to-all-things-pg', 1);

UPDATE p SET SourceType=s.SourceType
FROM dbo.HtmlPages p JOIN @PageSeed s ON s.PageName=p.PageName;

INSERT INTO dbo.HtmlPageUrl (HtmlPageID, SourceUrl, IsCanonical)
SELECT p.HtmlPageID,s.SourceUrl,s.IsCanonical
FROM @PageSeed s JOIN dbo.HtmlPages p ON p.PageName=s.PageName
WHERE NOT EXISTS (SELECT 1 FROM dbo.HtmlPageUrl u WHERE u.SourceUrl=s.SourceUrl);

-- The two observed July newsletter URLs resolve to the same page.
INSERT INTO dbo.HtmlPageUrl (HtmlPageID, SourceUrl, IsCanonical)
SELECT p.HtmlPageID,N'https://www.allthingspg.org/july-2026-all-things-pg-newsletter',0
FROM dbo.HtmlPages p
WHERE p.PageName=N'July 2026 All Things PG Newsletter'
AND NOT EXISTS (SELECT 1 FROM dbo.HtmlPageUrl u WHERE u.SourceUrl=N'https://www.allthingspg.org/july-2026-all-things-pg-newsletter');

UPDATE l
SET ItemTitle=l.Description,
    ItemType=CASE p.PageName
        WHEN N'Our People' THEN N'Person'
        WHEN N'Pyoderma Gangrenosum Clinic Finder' THEN N'Provider'
        ELSE CASE
            WHEN l.Description LIKE N'%PFAC%' OR l.Description LIKE N'%Anniversary Celebration%' THEN N'Event'
            WHEN l.Description LIKE N'%Newsletter%' THEN N'Newsletter'
            WHEN l.Description LIKE N'%Clinical Trial%' THEN N'Research'
            WHEN l.Description LIKE N'%Survey%' THEN N'Survey'
            WHEN l.Description LIKE N'%Podcast%' OR l.Description LIKE N'%Journey%' OR l.Description LIKE N'%Doc Talk%' THEN N'ExternalResource'
            ELSE N'NewsItem'
        END
    END
FROM dbo.HtmlList l JOIN dbo.HtmlPages p ON p.HtmlPageID=l.HtmlPageID;

DECLARE @ListUrl TABLE (PageName nvarchar(200), ItemTitle nvarchar(500), SourceUrl nvarchar(1000));
INSERT INTO @ListUrl (PageName,ItemTitle,SourceUrl) VALUES
(N'News & Events',N'Alimond Studio Podcast: Go Through to Get Through - Turning Seven Years of Pain Into a Movement for Women',N'https://alimondphotography.com/lasaunia-thompson/'),
(N'News & Events',N'Doc Talk: Local woman wins battle against rare skin disease that grew from a mosquito bite',N'https://wwmt.com/features/doc-talk/doc-talk-local-woman-wins-battle-against-rare-skin-disease-that-grew-from-a-mosquito-bite-12-07-2018'),
(N'News & Events',N'First ever Patient and Family Advisory Committee (PFAC) for PG',N'https://us06web.zoom.us/rec/share/tshxigOft-wJ7iqdcieseyJOF71E2mTK9VL0YMslD4roxL2cg4oT_xme3Dmo0HNG.qigH2ORaBLyjoG5A'),
(N'News & Events',N'First PFAC Meeting in Michigan',N'https://www.allthingspg.org/first-pfac-meeting-in-michigan'),
(N'News & Events',N'First Year Anniversary Celebration',N'https://www.allthingspg.org/anniversary-celebration'),
(N'News & Events',N'July 2026 All Things PG Newsletter',N'https://www.allthingspg.org/1-yr-anniversary-celebration-newsletter'),
(N'News & Events',N'November 14 PFAC',N'https://www.allthingspg.org/november-pfac'),
(N'News & Events',N'One Woman''s Journey with Pyoderma Gangrenosum',N'https://youtu.be/eOZ2ddLsa1A'),
(N'News & Events',N'Phase 3 Clinical Trial for Spesolimab',N'https://www.allthingspg.org/phase-3-clinical-trial-for-spesolimab'),
(N'News & Events',N'Take the PG Survey',N'https://www.allthingspg.org/take-the-pg-survey'),
(N'News & Events',N'Welcome to All Things PG',N'https://www.allthingspg.org/welcome-to-all-things-pg'),
(N'Our People',N'Corlis Watkins-Nass',N'https://www.allthingspg.org/corlis-watkins-nass'),
(N'Our People',N'Dave DePottie',N'https://www.allthingspg.org/dave-depottie'),
(N'Our People',N'Dr. Alex Ortega Loayza',N'https://www.allthingspg.org/dr-alex-ortega-loayza'),
(N'Our People',N'Gina Castelli',N'https://www.allthingspg.org/gina-castelli'),
(N'Our People',N'LaGail Odoms',N'https://www.allthingspg.org/lagail-odoms'),
(N'Our People',N'Lasaunia Thompson',N'https://www.allthingspg.org/lasaunia-thompson');

UPDATE l SET SourceUrl=s.SourceUrl
FROM dbo.HtmlList l
JOIN dbo.HtmlPages p ON p.HtmlPageID=l.HtmlPageID
JOIN @ListUrl s ON s.PageName=p.PageName AND s.ItemTitle=l.ItemTitle
WHERE l.SourceUrl IS NULL;

UPDATE dbo.HtmlList SET ItemType=N'ExternalResource' WHERE ItemTitle=N'First ever Patient and Family Advisory Committee (PFAC) for PG';

-- Reuse the same captured directory URL as the source for each provider listing.
UPDATE l SET SourceUrl=u.SourceUrl
FROM dbo.HtmlList l
JOIN dbo.HtmlPages p ON p.HtmlPageID=l.HtmlPageID
JOIN dbo.HtmlPageUrl u ON u.HtmlPageID=p.HtmlPageID AND u.IsCanonical=1
WHERE p.PageName=N'Pyoderma Gangrenosum Clinic Finder' AND l.SourceUrl IS NULL;

-- Create one pending source-to-target mapping for every page and list row.
INSERT INTO dbo.HtmlMigrationMap (HtmlPageID, MappingStatus)
SELECT p.HtmlPageID,'Pending' FROM dbo.HtmlPages p
WHERE NOT EXISTS (SELECT 1 FROM dbo.HtmlMigrationMap m WHERE m.HtmlPageID=p.HtmlPageID);
INSERT INTO dbo.HtmlMigrationMap (HtmlListID, MappingStatus)
SELECT l.HtmlListID,'Pending' FROM dbo.HtmlList l
WHERE NOT EXISTS (SELECT 1 FROM dbo.HtmlMigrationMap m WHERE m.HtmlListID=l.HtmlListID);

COMMIT TRANSACTION;



