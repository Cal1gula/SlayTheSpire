CREATE TABLE [dbo].[Runs]
(
	[play_id] UNIQUEIDENTIFIER NOT NULL, 
	[seed_played] BIGINT NOT NULL,
    [build_version] nvarchar(255) NOT NULL,
    [character_chosen] NVARCHAR(50) NOT NULL, 
    [playtime] INT NOT NULL, 
	[victory] BIT NULL DEFAULT 0,
    [score] INT NULL DEFAULT 0, 
    [gold] INT NULL DEFAULT 0, 
    [floor_reached] INT NULL DEFAULT 0, 
    [campfire_rested] INT NULL DEFAULT 0, 
    [campfire_upgraded] INT NULL DEFAULT 0, 
    [purchased_purges] INT NULL DEFAULT 0, 
    [player_experience] INT NULL DEFAULT 0, 
    [killed_by] NVARCHAR(255) NULL, 
    [ascension_level] INT NULL DEFAULT 0, 
    [is_prod] BIT NULL DEFAULT 0, 
    [is_daily] BIT NULL DEFAULT 0, 
    [is_ascension_mode] BIT NULL DEFAULT 0, 
    [is_trial] BIT NULL DEFAULT 0, 
    [json_raw] NVARCHAR(MAX) NOT NULL, 
    PRIMARY KEY  ([play_id]), 
    CONSTRAINT [CK_json_raw_validation] CHECK (ISJSON( json_raw )> 0 ) 
)

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