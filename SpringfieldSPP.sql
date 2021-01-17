-- Springfield South Primary School (All conditions New (1-2)

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
