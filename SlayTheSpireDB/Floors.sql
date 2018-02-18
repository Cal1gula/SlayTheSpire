CREATE TABLE [dbo].[Floors]
(
	[floornumber] INT NOT NULL  IDENTITY, 
    [play_id] UNIQUEIDENTIFIER NOT NULL, 
    [path_taken] NVARCHAR(50) NOT NULL, 
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
    @value = N'The path choice the player took for this floor',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'path_taken'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The unique id for this run references Runs table',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Floors',
    @level2type = N'COLUMN',
    @level2name = N'play_id'