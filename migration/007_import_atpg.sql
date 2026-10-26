use Migration
go

/****************************************************************************
****************************************************************************
Procedure:          Import_ATPG
Author:             Dave DePottie
Date Created:       2026-10-24

Description:        Returns the visible Phase 1 menu in the column order and
                    data types expected by AllThingsPG.dbo.MasterMenuStage.

Dependencies:

    Tables:
    - HtmlMenu
    - HtmlPages
    - HtmlPageUrl

Notes:
    - Reads only tables in the Migration database.
    - Returns one stable result set consumed by AllThingsPG.dbo.Import_Migration.
    - RouteType is C, VisitorMask is ALL, and the canonical source URL is
      returned in Notes when it fits the target column.
****************************************************************************
****************************************************************************/

create or alter procedure Import_ATPG
as begin
    set nocount on
    declare @errorMessage nvarchar(1000) = ''

    create table #VisibleMenu
    (
        HtmlMenuID int not null primary key,
        ParentHtmlMenuID int null,
        MenuLabel nvarchar(200) not null,
        DisplayOrder int not null,
        PageName nvarchar(200) not null,
        SourceUrl nvarchar(1000) null,
        MenuDepth int not null,
        SortPath varchar(max) not null,
        ParentLabel nvarchar(200) not null,
        ChildLabel nvarchar(200) not null,
        SubMenuLabel nvarchar(200) not null
    )

    if exists
    (
        select 1
        from dbo.HtmlMenu m
        inner join dbo.HtmlPages p on p.HtmlPageID = m.HtmlPageID
        where m.IsVisible = 1
            and (nullif(ltrim(rtrim(m.MenuLabel)), N'') is null
                or len(m.MenuLabel) > 100
                or nullif(ltrim(rtrim(p.PageName)), N'') is null
                or len(p.PageName) > 200)
    )
    begin
        set @errorMessage = 'Visible menu labels must be 1 to 100 characters and page names must be 1 to 200 characters';
        throw 50001, @errorMessage, 1
    end

    ;with MenuTree as
    (
        select
            m.HtmlMenuID,
            m.ParentHtmlMenuID,
            m.MenuLabel,
            m.DisplayOrder,
            p.PageName,
            pageUrl.SourceUrl,
            1 as MenuDepth,
            cast(concat(right(replicate('0', 10) + convert(varchar(10), m.DisplayOrder), 10), '.', right(replicate('0', 10) + convert(varchar(10), m.HtmlMenuID), 10)) as varchar(max)) as SortPath,
            cast(m.MenuLabel as nvarchar(200)) as ParentLabel,
            cast(N'' as nvarchar(200)) as ChildLabel,
            cast(N'' as nvarchar(200)) as SubMenuLabel,
            cast(concat('|', m.HtmlMenuID, '|') as varchar(max)) as IdPath
        from dbo.HtmlMenu m
        inner join dbo.HtmlPages p on p.HtmlPageID = m.HtmlPageID
        outer apply
        (
            select top (1) u.SourceUrl
            from dbo.HtmlPageUrl u
            where u.HtmlPageID = p.HtmlPageID
            order by u.IsCanonical desc, u.HtmlPageUrlID
        ) pageUrl
        where m.IsVisible = 1 and m.ParentHtmlMenuID is null

        union all

        select
            child.HtmlMenuID,
            child.ParentHtmlMenuID,
            child.MenuLabel,
            child.DisplayOrder,
            p.PageName,
            pageUrl.SourceUrl,
            parent.MenuDepth + 1,
            cast(concat(parent.SortPath, '.', right(replicate('0', 10) + convert(varchar(10), child.DisplayOrder), 10), '.', right(replicate('0', 10) + convert(varchar(10), child.HtmlMenuID), 10)) as varchar(max)),
            cast(N'' as nvarchar(200)),
            cast(case when parent.MenuDepth = 1 then child.MenuLabel else N'' end as nvarchar(200)),
            cast(case when parent.MenuDepth = 2 then child.MenuLabel else N'' end as nvarchar(200)),
            cast(concat(parent.IdPath, child.HtmlMenuID, '|') as varchar(max))
        from dbo.HtmlMenu child
        inner join dbo.HtmlPages p on p.HtmlPageID = child.HtmlPageID
        inner join MenuTree parent on parent.HtmlMenuID = child.ParentHtmlMenuID
        outer apply
        (
            select top (1) u.SourceUrl
            from dbo.HtmlPageUrl u
            where u.HtmlPageID = p.HtmlPageID
            order by u.IsCanonical desc, u.HtmlPageUrlID
        ) pageUrl
        where child.IsVisible = 1
            and charindex(concat('|', child.HtmlMenuID, '|'), parent.IdPath) = 0
    )
    insert into #VisibleMenu
    (
        HtmlMenuID, ParentHtmlMenuID, MenuLabel, DisplayOrder, PageName, SourceUrl,
        MenuDepth, SortPath, ParentLabel, ChildLabel, SubMenuLabel
    )
    select
        HtmlMenuID, ParentHtmlMenuID, MenuLabel, DisplayOrder, PageName, SourceUrl,
        MenuDepth, SortPath, ParentLabel, ChildLabel, SubMenuLabel
    from MenuTree
    option (maxrecursion 32767)

    if (select count(*) from #VisibleMenu) <> (select count(*) from dbo.HtmlMenu where IsVisible = 1)
    begin
        set @errorMessage = 'Visible menu has an orphaned parent or hierarchy cycle; every visible menu row must descend from a root';
        throw 50002, @errorMessage, 1
    end

    if exists (select 1 from #VisibleMenu where MenuDepth > 3)
    begin
        set @errorMessage = 'Visible menu hierarchy exceeds the three levels supported by MasterMenuStage';
        throw 50003, @errorMessage, 1
    end

    if exists (select 1 from #VisibleMenu where SourceUrl is not null and len(SourceUrl) > 200)
    begin
        set @errorMessage = 'A canonical source URL exceeds the 200-character MasterMenuStage.Notes field';
        throw 50004, @errorMessage, 1
    end

    select
        cast(ParentLabel as nvarchar(100)) as Parent,
        cast(ChildLabel as nvarchar(100)) as Child,
        cast(SubMenuLabel as nvarchar(100)) as SubMenu,
        cast(N'ALL' as nvarchar(20)) as VisitorMask,
        cast(N'C' as nvarchar(10)) as RouteType,
        cast(N'' as nvarchar(200)) as RouteTarget,
        cast(coalesce(nullif(PageName, N''), MenuLabel) as nvarchar(200)) as Description,
        cast(SourceUrl as nvarchar(200)) as Notes
    from #VisibleMenu
    order by SortPath
end
go

-- Preview the result-set contract consumed by Import_Migration.
exec Import_ATPG
go