rollout the_thief "The Thief 1.0" width: 300 height: 300 
(
    pickbutton victim_object "< Pick Victim Object >" pos:[75,120] width:150
    button thief_button "Thief!" enabled:false pos:[75,150] width:150

    global top_offset = [0, 20, 0]
    
    on victim_object picked obj do 
    (
        thief_button.enabled = true
    )

    on thief_button pressed do 
    (
        -- copy top values

        select $Ref9
        $.pos = victim_object.object.pos
        move $ top_offset

        for vert_index = 1 to victim_object.object.numverts do 
        (
            vert = polyop.getVert victim_object.object vert_index

            for ref_vert_index = 1 to $.numverts do 
            (
                ref_vert = polyop.getVert $ ref_vert_index

                if vert.x == ref_vert.x and  vert.y == ref_vert.y and  vert.z == ref_vert.z then 
                (
                    macros.run "Modifier Stack" "Convert_to_Mesh"
                    addmodifier $ (Edit_Mesh())

                    mod_color = getVertColor $ ref_vert_index

                    print ((mod_color) as string)

                    macros.run "Modifier Stack" "Convert_to_Poly"

                    polyop.setVertSelection victim_object.object vert_index
                    polyop.setvertcolor victim_object.object 0 victim_object.object.selectedVerts mod_color      
                )
            )
        )

        for vert_index = 1 to victim_object.object.numverts do 
        (
            vert = polyop.getVert victim_object.object vert_index

            for ref_vert_index = 1 to $Ref9.numverts do 
            (
                ref_vert = polyop.getVert $Ref9 ref_vert_index

                if vert.x == ref_vert.x and  vert.y == ref_vert.y and  vert.z == ref_vert.z then 
                (
                    try 
                    (
                        modPanel.setCurrentObject $Ref9.edit_normals
                    )
                    catch 
                    (
                        addModifier $Ref9 (editNormals())
                    )

                    try 
                    (
                        modPanel.setCurrentObject victim_object.object.edit_normals
                    )
                    catch 
                    (
                        addModifier victim_object.object (editNormals())
                    )

                    max modify mode
                    modPanel.setCurrentObject $Ref9.edit_normals
                    subobjectlevel = 1
                    max select all
                    victim_object.object.modifiers[#Edit_Normals].EditNormalsMod.MakeExplicit ()

                    vertn = 1
                    vert_array = #{vertn}
                    normal_array = #{}
                    $Ref9.Edit_Normals.ConvertVertexSelection &vert_array &normal_array
                    normal_result = normal_array as array

                    normalt = $Ref9.modifiers[#Edit_Normals].EditNormalsMod.Getnormal normal_result[1]  * victim_object.object.rotation

                    modPanel.setCurrentObject $Ref9.baseObject

                    modPanel.setCurrentObject $Ref9.edit_normals 
                    vertn = ref_vert_index
                    vert_array = #{vertn}
                    normal_array = #{}
                    $Ref9.Edit_Normals.ConvertVertexSelection &vert_array &normal_array
                    normal_result = normal_array as array 

                    normalt = $Ref9.modifiers[#Edit_Normals].EditNormalsMod.Getnormal normal_result[1] * victim_object.object.rotation

                    modPanel.setCurrentObject $Ref9.baseObject


                    modPanel.setCurrentObject victim_object.object.edit_normals

                    vertn = vert_index
                    vert_array = #{vertn}
                    normal_array = #{}
                    victim_object.object.Edit_Normals.ConvertVertexSelection &vert_array &normal_array
                    normal_result = normal_array as array --

                    victim_object.object.modifiers[#Edit_Normals].EditNormalsMod.Setnormal normal_result[1] normalt   
                    
                )
            )
        )

    )   
)


createdialog the_thief