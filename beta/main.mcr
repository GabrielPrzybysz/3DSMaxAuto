rollout NormalThief "Normal Thief"  width:258
(

	groupbox grp1 "Instructions" width: 229 height: 105
    label lb1 "1." pos:[20,28] width:24 height:24
    
	pickbutton pick "< Pick Reference Object >" pos: [34,24] width:190
    label lbl2 "2. Select objects to change normals. [mesh]" pos:[20,54] width:216 height:16
    
	label lbl3 "3." pos:[20,80] width:24 height:24
    button btn "<< - A C T I O N - >>" enabled:false pos:[35,76] width:190
    
	label label "Current Vert:"  pos:[20, 115] width:216
    progressbar progressVert width:210 offset:[8,0] color:(color 0 100 240) 
    
	label label2 "Current Obj:" pos:[20, 150] width:216
	progressbar progressObj width:210 offset:[8,0] color:(color 211 0 0) 



    on pick picked refmesh do 
    (
        modPanel.setCurrentObject pick.object.baseObject
    
        if classof pick.object != Editable_mesh then 
        (
			messagebox "Object should be Editable Mesh !" title: "Normal Thief"
			btn.enabled = false
			pick.caption = "< Pick Reference Object >"
		)
        else    
        (
		    pick.text = "Reference -> " + refmesh.name
		    btn.enabled = true
		)
    )

    on btn pressed do
    (
        label.caption = "Current Vert:"
		progressVert.value = 0
		label2.caption = "Current Obj:"
        progressObj.value = 0
        

        selectedObjects = getcurrentselection()

        try 
        (
            disableSceneRedraw()

            For objectIndex = 1 to selectedObjects.count do 
            (
                select selectedObjects[objectIndex]

                        

                try
                (
                    modPanel.setCurrentObject selectedObjects[objectIndex].edit_normals

                ) catch (

                    addmodifier selectedObjects[objectIndex] (editnormals())
                )

                selectedObjects[objectIndex].modifiers[#Edit_Normals].EditNormalsMod.MakeExplicit ()
    
                modPanel.setCurrentObject selectedObjects[objectIndex].baseObject 

                For vertice = 1 to selectedObjects[objectIndex].numverts do 
                (
                    modPanel.setCurrentObject selectedObjects[objectIndex].baseObject 
                    vertice = getvert selectedObjects[objectIndex] x 

                    modPanel.setCurrentObject selectedObjects[objectIndex].baseObject  
                    referenceVertice = getvert selectedObjects[objectIndex] x 

                    try
                    (

                        modPanel.setCurrentObject pick.object.edit_normals

                    ) catch (

                        addmodifier pick.object (editnormals())
                    )

                    modPanel.setCurrentObject pick.object.edit_normals 
					
					

                )
            )

        ) catch (
            enableSceneRedraw()
            messagebox "Error! All objects should be Editable Mesh!" title: "Normal Thief"
        )
        
    )
)

createdialog NormalThief