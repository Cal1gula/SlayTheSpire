CREATE TABLE [dbo].[Floors]
(
	[floornumber] INT NOT NULL  IDENTITY, 
    [play_id] UNIQUEIDENTIFIER NOT NULL, 
    [path_per_floor] NVARCHAR(50) NULL, 
    [gold_per_floor] NVARCHAR(50) NULL, 
    [max_hp_per_floor] INT NULL, 
    [current_hp_per_floor] INT NULL, 
    [vhp_percentage_per_floor] AS CONVERT(DECIMAL(18,2), (current_hp_per_floor * 1.0 / max_hp_per_floor * 1.0) * 100), 
    CONSTRAINT [PK_Floors] PRIMARY KEY ([floornumber], [play_id]), 
    CONSTRAINT [FK_Floors_Runs] FOREIGN KEY ([play_id]) REFERENCES [Runs]([play_id]) ON DELETE CASCADE
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Floor number value for this run',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'floornumber'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The chosen path for this floor',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = 'path_per_floor'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The unique id for this run references Runs table',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'play_id'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The player gold at this floor',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'gold_per_floor'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Maximum player hp at this floor',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'max_hp_per_floor'