CREATE PROCEDURE InsertDecks
@play_id as uniqueidentifier = 'DB1EFD71-7C8B-458C-A415-B90D112A75D5'

AS
BEGIN
DECLARE @Rawjson as NVARCHAR(MAX) = (SELECT json_raw FROM Runs WHERE play_id = @play_id);

INSERT INTO Cards 
([card])

SELECT DISTINCT
	CASE 
	WHEN CHARINDEX('+', d.[Value]) > 0 THEN SUBSTRING(d.[Value], 0, CHARINDEX('+', d.[Value])) 
	ELSE SUBSTRING(d.[Value], CHARINDEX('+', d.[Value])  + 1, LEN(d.[Value]))
	END AS [card]
FROM 
	OPENJSON(@Rawjson, '$.master_deck') AS d
LEFT JOIN 
	Cards c 
	ON 	CASE 
	WHEN CHARINDEX('+', d.[Value]) > 0 THEN SUBSTRING(d.[Value], 0, CHARINDEX('+', d.[Value])) 
	ELSE SUBSTRING(d.[Value], CHARINDEX('+', d.[Value])  + 1, LEN(d.[Value]))
	END  = d.[Value]
WHERE 
	D.[Value] IS NULL;


INSERT INTO
	Decks 
	(play_id
	,key_index
	,card_full)

SELECT 
	[play_id] = @play_id
	,[key_index] = c.[Key]
	,card_full = c.[Value]
FROM 
	OPENJSON(@Rawjson, '$.master_deck') AS c
LEFT JOIN 
	Decks d
	ON d.play_id = @play_id AND d.key_index = c.[Key]
WHERE 
	d.key_index IS NULL
	AND d.play_id IS NULL

END