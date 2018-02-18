CREATE PROCEDURE [dbo].[InsertRun]

@JSON NVARCHAR(MAX) = N''

AS

BEGIN

SET NOCOUNT ON;

DECLARE @SQL NVARCHAR(MAX) = N'';
DECLARE @JSONTest NVARCHAR(MAX) = N'';
--SET @JSON = N'D:\Steam\steamapps\common\SlayTheSpire\runs\IRONCLAD\1518908754.run';
SET @SQL = N'SELECT * FROM OPENROWSET (BULK ''' + @JSON + ''', SINGLE_CLOB) AS j';

DROP TABLE IF EXISTS #JSON;
CREATE TABLE #JSON
(RAWJSON NVARCHAR(MAX));

INSERT INTO #JSON
EXEC(@SQL);

SET @JSONTest = (SELECT RAWJSON FROM #JSON)
IF ISJSON((SELECT RAWJSON FROM #JSON)) = 0
RETURN 2

INSERT INTO Runs 
	(
	 [play_id]    
	,[seed_played]
    ,[build_version]
    ,[character_chosen]
    ,[playtime]
    ,[victory]
    ,[score]
    ,[gold]
    ,[floor_reached]
    ,[campfire_rested]
    ,[campfire_upgraded]
    ,[purchased_purges]
    ,[player_experience]
    ,[killed_by]
    ,[ascension_level]
    ,[is_prod]
    ,[is_daily]
    ,[is_ascension_mode]
    ,[is_trial]
    ,[json_raw]
	)
SELECT 
	 [play_id] = JSON_VALUE(RAWJSON, '$.play_id')
    ,[seed_played] = JSON_VALUE(RAWJSON, '$.seed_played')
    ,[build_version] = JSON_VALUE(RAWJSON, '$.build_version')
    ,[character_chosen] = JSON_VALUE(RAWJSON, '$.character_chosen')
    ,[playtime] = JSON_VALUE(RAWJSON, '$.playtime')
    ,[victory] = JSON_VALUE(RAWJSON, '$.victory') 
    ,[score] = JSON_VALUE(RAWJSON, '$.score')
    ,[gold] = JSON_VALUE(RAWJSON, '$.gold')
    ,[floor_reached] = JSON_VALUE(RAWJSON, '$.floor_reached')
    ,[campfire_rested] = JSON_VALUE(RAWJSON, '$.campfire_rested')
    ,[campfire_upgraded] = JSON_VALUE(RAWJSON, '$.campfire_upgraded')
    ,[purchased_purges] = JSON_VALUE(RAWJSON, '$.purchased_purges')
    ,[player_experience] = JSON_VALUE(RAWJSON, '$.player_experience')
    ,[killed_by] = JSON_VALUE(RAWJSON, '$.killed_by')
    ,[ascension_level] = JSON_VALUE(RAWJSON, '$.ascension_level')
    ,[is_prod] = JSON_VALUE(RAWJSON, '$.is_prod')
    ,[is_daily] = JSON_VALUE(RAWJSON, '$.is_daily')
    ,[is_ascension_mode] = JSON_VALUE(RAWJSON, '$.is_ascension_mode')
    ,[is_trial] = JSON_VALUE(RAWJSON, '$.is_trial')
    ,[json_raw] = RAWJSON
FROM 
	#JSON j
LEFT JOIN 
	Runs r
ON 
	r.play_id = JSON_VALUE(j.RAWJSON, '$.play_id')
WHERE 
	r.play_id IS NULL;

END
