rollout MainRollout "Prop Thief Tool" width: 300 height: 300 
(
	--HUD
	groupbox groupBox "Instructions" width: 250 height: 105
    label labelOne "1." pos:[20,28] width:24 height:24
    
	pickbutton referenceObject "< Pick Reference Object >" pos: [35,20] width:190
	
	label labelTwo "2.     Select objects to change" pos:[20,52] width:190 height:15
	
	label labelThree "3." pos:[20,80] width:24 height:24
    button thiefButton "Thief!" enabled:false pos:[35,75] width:190
	--HUD
	

	on referenceObject picked refmesh do
	(
		modPanel.setCurrentObject referenceObject.object.baseObject
		
		try
        (
			modPanel.setCurrentObject referenceObject.object.edit_mesh
        ) 
		catch 
		(
			addmodifier referenceObject.object (Edit_Mesh())
        )
		
		if classOf referenceObject.object == Editable_mesh then 
		(
			referenceObject.text = "Reference -> " + refmesh.name
		    thiefButton.enabled = true
		)
		else 
		(
			messagebox "Object should be Editable Mesh !" title: "Thief error"
			thiefButton.enabled = false
			referenceObject.caption = "< Pick Reference Object >"	
		)
	)
	
	
	on thiefButton pressed do 
	(
		--disableSceneRedraw()
		
		selectedObjects = getcurrentselection()
			
		for i = 1 to selectedObjects.count do 
		(
			max modify mode
			
			try
            (
                modPanel.setCurrentObject selectedObjects[i].edit_mesh
            ) 
			catch 
			(
                addmodifier selectedObjects[i] (Edit_Mesh())
            )
			
			modPanel.setCurrentObject selectedObjects[i].baseObject
			
			for j = 1 to selectedObjects[i].numverts do 
			(
				newVertice = getVert selectedObjects[i] j
				
				modPanel.setCurrentObject referenceObject.object.baseObject
				
				for k = 1 to referenceObject.object.numverts do 
				(
					referenceVertice = getVert referenceObject.object k
					--referenceColor = getVertColor referenceObject.object k
					
					if newVertice.x == referenceVertice.x then 
					(
						if newVertice.y == referenceVertice.y then 
						(
							if newVertice.z == referenceVertice.z then 
							(								
								modPanel.setCurrentObject selectedObjects[i].
								
								polyop.setVertColor selectedObjects[i] 0 j [0,250,0]
							)
						)
					)
				)
			)
		)
		
		enableSceneRedraw()
	)
)

createdialog MainRollout