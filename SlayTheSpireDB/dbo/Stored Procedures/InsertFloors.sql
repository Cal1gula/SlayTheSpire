CREATE PROCEDURE [dbo].[InsertFloors] 
@play_id as uniqueidentifier = 'DB1EFD71-7C8B-458C-A415-B90D112A75D5'
AS
BEGIN

DECLARE @Rawjson as NVARCHAR(MAX) = (SELECT json_raw FROM Runs WHERE play_id = @play_id);
INSERT INTO Floors 
	(play_id
	,floornumber
	,path_per_floor
	,gold_per_floor
	,max_hp_per_floor
	,current_hp_per_floor
	)
SELECT 
	r.play_id
	,floornumber = n.Number
	,path_per_floorMOD = CASE
						WHEN n.Number = 0
						THEN 'ACT 1' /* zero divided by anything is zero so we can't use modulus lets just hard code this one */
						WHEN n.Number = 1
						THEN p.[Value]
						WHEN ((n.Number)%17) = 0 /* Every 17 floors is a new act so we use mod to check for a remainder*/
						THEN 'ACT ' + CAST(((n.Number / 17) + 1) AS nvarchar(50))  /* act 1 starts at 0, act 2 starts at floor 17 which means we need to add 1 after dividing */
						ELSE p.[Value]
					  END
	,gold_per_floor = CASE
						WHEN n.Number = 0 
						THEN 99 /* starting gold */
						ELSE g.[Value]
					  END 
	,max_hp_per_floor = CASE
						WHEN n.Number = 0 
						THEN 80 /* starting hp */
						ELSE hpm.[Value]
					  END 
	,current_hp_per_floor = CASE
						WHEN n.Number = 0 
						THEN 80
						ELSE hpc.[Value]
					  END 
FROM 
	Runs r
CROSS JOIN 
	Numbers n
LEFT JOIN OPENJSON(@Rawjson, '$.path_per_floor') AS p
	ON p.[Key] = (n.Number - 1)
LEFT JOIN OPENJSON(@Rawjson, '$.gold_per_floor') AS g
	ON g.[Key] = (n.Number - 1)
LEFT JOIN OPENJSON(@Rawjson, '$.max_hp_per_floor') AS hpm
	ON hpm.[Key] = (n.Number - 1)
LEFT JOIN OPENJSON(@Rawjson, '$.current_hp_per_floor') AS hpc
	ON hpc.[Key] = (n.Number - 1)
LEFT JOIN Floors f
	ON f.play_id = r.play_id 
	AND f.floornumber = n.Number
WHERE 
	r.play_id = @play_id
	AND N.Number < r.floor_reached 
	AND f.play_id IS NULL;

END


	--SELECT * FROM OPENJSON(@Rawjson, '$.path_per_floor')

	--SELECT JSON_QUERY(@Rawjson, 'lax $.path_per_floor') as ppf
	
	--SELECT @Rawjson

	--["M","M","$","M","?","R","E","R","T","R","M","M","M","M","R"]
	
	--{"path_per_floor":["M","?","?","?","M","R","M","M","T","R","M","R","M","$","R","B",null,"M","M","M","$","M","R","?","E","T","R","$","R","$","M","R","B",null,"M","$","M","?"],"character_chosen":"IRONCLAD","items_purchased":["Bandage Up","Sadistic Nature","Good Instincts","Meat on the Bone","Thinking Ahead"],"gold_per_floor":[113,113,113,113,134,134,152,165,465,465,479,479,492,392,392,518,518,533,546,565,4,29,29,29,69,69,69,69,69,69,88,88,212,212,237,51,71,71],"floor_reached":39,"campfire_rested":1,"playtime":6319,"current_hp_per_floor":[80,80,73,73,74,74,74,74,74,74,70,70,66,66,66,9,74,70,56,34,34,23,53,53,43,43,53,53,63,63,58,68,45,74,62,62,53,53],"items_purged":[],"gold":71,"score":341,"play_id":"db1efd71-7c8b-458c-a415-b90d112a75d5","is_prod":false,"is_daily":false,"is_ascension_mode":false,"campfire_upgraded":7,"path_taken":["M","?","?","?","M","R","M","M","T","R","?","R","M","$","R","BOSS","M","M","M","$","M","R","?","E","T","R","$","R","?","M","R","BOSS","M","$","M","?","?"],"build_version":"2018-02-15-PROD1","purchased_purges":1,"victory":false,"master_deck":["Strike_R","Strike_R","Strike_R","Strike_R","Strike_R","Defend_R","Defend_R","Defend_R","Bash+1","Pommel Strike","Uppercut+1","Flex+1","Infernal Blade","Cleave+1","Iron Wave+1","Bandage Up","Demon Form+1","Cleave","Anger","Shockwave","Sadistic Nature","Good Instincts","Headbutt+1","Flame Barrier+1","Clash+1","Anger","Feed","Thinking Ahead","Metallicize"],"max_hp_per_floor":[80,80,80,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74,74],"relics":["Black Blood","Bronze Scales","Golden Idol","Old Coin","Eternal Feather","Meat on the Bone","Vajra","Bag of Marbles"],"card_choices":[{"not_picked":["Searing Blow","Dual Wield"],"picked":"Pommel Strike"},{"not_picked":["Dropkick","Pommel Strike"],"picked":"Uppercut"},{"not_picked":["Rage","Sword Boomerang"],"picked":"Flex"},{"not_picked":["Headbutt","Clothesline"],"picked":"Infernal Blade"},{"not_picked":["Armaments","Hemokinesis"],"picked":"Cleave"},{"not_picked":["Shrug It Off","Sword Boomerang"],"picked":"Iron Wave"},{"not_picked":["Fiend Fire","Reaper"],"picked":"Demon Form"},{"not_picked":["Corruption","Pommel Strike"],"picked":"Cleave"},{"not_picked":["Cleave","Thunderclap"],"picked":"Anger"},{"not_picked":["True Grit","Clothesline"],"picked":"Shockwave"},{"not_picked":["True Grit","Twin Strike"],"picked":"Headbutt"},{"not_picked":["Thunderclap","Blood for Blood"],"picked":"Clash"},{"not_picked":["Dark Embrace","Shrug It Off"],"picked":"Anger"},{"not_picked":["Brutality","Juggernaut"],"picked":"Feed"},{"not_picked":["Flame Barrier","Thunderclap"],"picked":"Metallicize"}],"player_experience":0,"potions_floor_usage":[20,20,31,31,31,37],"damage_taken":[{"damage":3,"enemies":"Jaw Worm","floor":1,"turns":4},{"damage":2,"enemies":"2 Louse","floor":5,"turns":3},{"damage":0,"enemies":"Small Slimes","floor":7,"turns":2},{"damage":6,"enemies":"3 Louse","floor":8,"turns":3},{"damage":10,"enemies":"Large Slime","floor":11,"turns":5},{"damage":10,"enemies":"Looter","floor":13,"turns":3},{"damage":67,"enemies":"The Guardian","floor":16,"turns":9},{"damage":14,"enemies":"Chosen","floor":18,"turns":4},{"damage":24,"enemies":"Shell Parasite","floor":19,"turns":5},{"damage":38,"enemies":"Sentry and Sphere","floor":20,"turns":4},{"damage":29,"enemies":"Snecko","floor":22,"turns":5},{"damage":32,"enemies":"Book of Stabbing","floor":25,"turns":5},{"damage":21,"enemies":"Centurion and Healer","floor":31,"turns":4},{"damage":45,"enemies":"Champ","floor":33,"turns":8},{"damage":22,"enemies":"Orb Walker","floor":35,"turns":4},{"damage":31,"enemies":"3 Darklings","floor":37,"turns":5},{"damage":66,"enemies":"Maw","floor":39,"turns":9}],"event_choices":[{"event_name":"Shining Light","player_choice":"Ignored","floor":2,"damage_taken":0},{"event_name":"Scrap Ooze","player_choice":"success","floor":3,"damage_taken":7},{"event_name":"Golden Idol","player_choice":"Lose Max HP","floor":4,"damage_taken":0},{"event_name":"The Library","player_choice":"Read","floor":24,"damage_taken":0}],"boss_relics":[{"not_picked":["White Beast Statue","Runic Dome"],"picked":"Eternal Feather"},{"not_picked":["Runic Pyramid","Calling Bell"],"picked":"Black Blood"}],"potions_floor_spawned":[7,8,11,20,22,25,35],"seed_played":"-2006109867098053626","killed_by":"Maw","ascension_level":0,"is_trial":false}