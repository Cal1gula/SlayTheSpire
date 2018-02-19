CREATE TABLE [dbo].[Decks]
(
	[play_id] UNIQUEIDENTIFIER NOT NULL , 
    [card] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Decks] PRIMARY KEY ([play_id]), 
    CONSTRAINT [FK_Decks_Runs] FOREIGN KEY ([play_id]) REFERENCES [Runs]([play_id]) ON DELETE CASCADE
)

GO

CREATE INDEX [IX_Decks_card] ON [dbo].[Decks] ([card])

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'The play_id from Runs table',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Decks',
    @level2type = N'COLUMN',
    @level2name = N'play_id'