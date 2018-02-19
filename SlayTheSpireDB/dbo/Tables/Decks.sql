CREATE TABLE [dbo].[Decks]
(
	[play_id] UNIQUEIDENTIFIER NOT NULL,
	[key_index] INT NOT NULL,
    [card_full] NVARCHAR(50) NOT NULL, 
	[card] AS			CASE 
						WHEN CHARINDEX('+', [card_full]) > 0
						THEN SUBSTRING([card_full], 0, CHARINDEX('+', [card_full])) 
						ELSE SUBSTRING([card_full], CHARINDEX('+', [card_full])  + 1, LEN([card_full]))
						END PERSISTED,
    [upgrade_level] AS	CASE 
						WHEN CHARINDEX('+', [card_full]) > 0
						THEN SUBSTRING([card_full], CHARINDEX('+', [card_full])  + 1, LEN([card_full]))
						ELSE SUBSTRING([card_full], 0, CHARINDEX('+', [card_full])) 
						END PERSISTED

    CONSTRAINT [PK_Decks] PRIMARY KEY ([play_id], [key_index]), 
    CONSTRAINT [FK_Decks_Runs] FOREIGN KEY ([play_id]) REFERENCES [Runs]([play_id]) ON DELETE CASCADE, 
    CONSTRAINT [FK_Decks_Cards] FOREIGN KEY ([card]) REFERENCES [Cards]([card])
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