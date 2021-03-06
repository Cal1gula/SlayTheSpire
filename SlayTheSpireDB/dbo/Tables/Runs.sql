﻿CREATE TABLE [dbo].[Runs] (
    [play_id]           UNIQUEIDENTIFIER NOT NULL,
    [seed_played]       BIGINT           NOT NULL,
    [build_version]     NVARCHAR (255)   NOT NULL,
    [character_chosen]  NVARCHAR (50)    NOT NULL,
    [playtime]          INT              NOT NULL,
    [victory]           BIT              DEFAULT ((0)) NULL,
    [score]             INT              DEFAULT ((0)) NULL,
    [gold]              INT              DEFAULT ((0)) NULL,
    [floor_reached]     INT              DEFAULT ((0)) NULL,
    [campfire_rested]   INT              DEFAULT ((0)) NULL,
    [campfire_upgraded] INT              DEFAULT ((0)) NULL,
    [purchased_purges]  INT              DEFAULT ((0)) NULL,
    [player_experience] INT              DEFAULT ((0)) NULL,
    [killed_by]         NVARCHAR (255)   NULL,
    [ascension_level]   INT              DEFAULT ((0)) NULL,
    [is_prod]           BIT              DEFAULT ((0)) NULL,
    [is_daily]          BIT              DEFAULT ((0)) NULL,
    [is_ascension_mode] BIT              DEFAULT ((0)) NULL,
    [is_trial]          BIT              DEFAULT ((0)) NULL,
    [json_raw]          NVARCHAR (MAX)   NOT NULL,
    CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED ([play_id] ASC),
    CONSTRAINT [CK_json_raw_validation] CHECK (isjson([json_raw])>(0))
);



GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Play time in seconds',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'playtime'
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique identifier of the Slay The Spire run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'play_id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Internal game seed number',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'seed_played'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Slay The Spire build number',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'build_version'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The character the player chose for the run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'character_chosen'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Final score',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'score'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Final gold amount',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'gold'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Final floor reached by the player in the run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'floor_reached'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Win or loss',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'victory'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Number of times the player upgraded cards at a campfire',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'campfire_upgraded'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Number of item purges the player purchased',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'purchased_purges'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Experience value for the player',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'player_experience'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Thing that killed the player and ended the run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'killed_by'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Level of ascension',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'ascension_level'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Is this a prod run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'is_prod'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Is the run for the daily quest',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'is_daily'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Is ascension mode on for this run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'is_ascension_mode'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Is this a trial run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'is_trial'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Raw JSON data',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Runs',
    @level2type = N'COLUMN',
    @level2name = N'json_raw'
GO

--CREATE INDEX [IX_Runs_vpath_per_floor] ON [dbo].[Runs] ([vpath_per_floor])


--GO

--CREATE INDEX [IX_Runs_vgold_per_floor] ON [dbo].[Runs] ([vgold_per_floor])

--GO

--CREATE INDEX [IX_Runs_vmax_hp_per_floor] ON [dbo].[Runs] ([vmax_hp_per_floor])

--GO

--CREATE INDEX [IX_Runs_vcurrent_hp_per_floor] ON [dbo].[Runs] ([vcurrent_hp_per_floor])

--GO


CREATE FULLTEXT INDEX ON [dbo].[Runs]
    ([json_raw] LANGUAGE 1033)
    KEY INDEX [PK_ID]
    ON [ftCatalog];


