-- Springfield South Primary School (All conditions New (1-2))
-- Target Internal Building items to have a lower duty factor using a case when statement
-- Randomization of Surveycondition data on a per item basis with a range of 1 to 2\
-- Target Area is Springfield South Primary School ('237.5.6')

Update I
Set surveycondition = Rand(convert(varbinary, newid()))*(1.01)+1, 
DutyFactor = (case 
when a.type in (808,
810,
813,
814,
817,
818,
830,
833) then 0.8
else 1
End)
From sel.items I
Join sel.areas A on A.id = I.area
Where A.id like '237.5.6.%'

--Springfield Central High School
UPDATE I
SET surveycondition =(
CASE
WHEN A.[Type] in (792,795) 
		THEN	RAND(CONVERT(VARBINARY, NEWID()))*(1.51)+2
WHEN A.[Type]  in (817)
		THEN	RAND(CONVERT(VARBINARY, NEWID()))*(1.51)+3.5
ELSE			RAND(CONVERT(VARBINARY, NEWID()))*(1.01)+3
END),
DutyFactor = (
CASE 
WHEN A.[Type] in (808,810,813,814,817,818,830,833) THEN 1
													ELSE 1
END)
			     From sel.items I
Join sel.areas A on A.id = I.area
Where A.id like '237.5.4.%'
			     
UPDATE I
SET surveycondition =(
CASE
-- EXTERNALS
WHEN A.[Type] in (792,795) 
		THEN	RAND(CONVERT(VARBINARY, NEWID()))*(1.51)+2
ELSE	CASE
-- RANDOMIZER FOR NEED TO REFURB
			WHEN A.Id IN  (SELECT CASE
						WHEN RAND(CONVERT(VARBINARY, NEWID()))<0.3
						THEN Id
								END AS Id
						FROM sel.areas) THEN RAND(CONVERT(VARBINARY, NEWID()))*(1.01)+4
-- RANDOMIZER FOR REFURBED
			WHEN A.Id IN (SELECT CASE
						WHEN RAND(CONVERT(VARBINARY, NEWID()))>0.7
						Then Id
								END As Id
						From sel.areas) then RAND(CONVERT(VARBINARY, NEWID()))*(1.51)+1
-- EVERYTHING ELSE
						ELSE RAND(CONVERT(VARBINARY, NEWID()))*(2.01)+2
						END
			END),
						
DutyFactor = (
CASE 
WHEN A.[Type] in (808,810,813,814,817,818,830,833) THEN 1.2
													ELSE 1
END)
From sel.items I
Join sel.areas A on A.id = I.area
Where A.id like '237.5.2.%'

Select *
From Sel.areas
Where Id IN (Select case
When rand(convert(varbinary, newid()))>0.5
Then Id
end As Id
From sel.areas) and ID like '237.5.2.%' 
