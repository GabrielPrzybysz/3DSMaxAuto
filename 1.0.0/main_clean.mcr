-- This function was made by:
-- The Thief  v1.0
-- By Gabriel P. G. Junior 
-- gabrielgprzy@gmail.com
-- 11/20

rollout the_thief "The Thief 1.0" width: 300 height: 300 
(
    pickbutton victim_object "< Pick Victim Object >" pos:[75,120] width:150
    button thief_button "Thief!" enabled:false pos:[75,150] width:150

    global top_offset = [0, 20, 0]
    global left_offset = [20, 0, 0]
    
    on victim_object picked obj do 
    (
        thief_button.enabled = true
    )

    on thief_button pressed do 
    (


        --Functions
        function copy_vertex_colors ref_ob =
        ( 

            for vert_index = 1 to victim_object.object.numverts do 
            (
                vert = polyop.getVert victim_object.object vert_index
            
                for ref_vert_index = 1 to ref_ob.numverts do 
                (
                    ref_vert = polyop.getVert ref_ob ref_vert_index
                
                    if vert.x == ref_vert.x and  vert.y == ref_vert.y and  vert.z == ref_vert.z then 
                    (
                        macros.run "Modifier Stack" "Convert_to_Mesh"
                        addmodifier ref_ob (Edit_Mesh())
                    
                        mod_color = getVertColor ref_ob ref_vert_index
                    
                        print ((mod_color) as string)
                    
                        macros.run "Modifier Stack" "Convert_to_Poly"
                    
                        polyop.setVertSelection victim_object.object vert_index
                        polyop.setvertcolor victim_object.object 0 victim_object.object.selectedVerts mod_color      
                    )
                )
            )
        )

        function copy_normals ref_ob = 
        (
                -- This function was made by:
            	-- Normal Thief  v1.0
	            -- By Mauricio B. G. 
	            -- mbg@southlogic.com
	            -- 02/04

            for vert_index = 1 to victim_object.object.numverts do 
            (
                vert = polyop.getVert victim_object.object vert_index

                for ref_vert_index = 1 to ref_ob.numverts do 
                (
                    ref_vert = polyop.getVert ref_ob ref_vert_index

                    if vert.x == ref_vert.x and  vert.y == ref_vert.y and  vert.z == ref_vert.z then 
                    (
                        try 
                        (
                            modPanel.setCurrentObject ref_ob.edit_normals
                        )
                        catch 
                        (
                            addModifier ref_ob (editNormals())
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
                        modPanel.setCurrentObject ref_ob.edit_normals
                        subobjectlevel = 1
                        max select all
                        victim_object.object.modifiers[#Edit_Normals].EditNormalsMod.MakeExplicit ()

                        vertn = 1
                        vert_array = #{vertn}
                        normal_array = #{}
                        ref_ob.Edit_Normals.ConvertVertexSelection &vert_array &normal_array
                        normal_result = normal_array as array

                        normalt = ref_ob.modifiers[#Edit_Normals].EditNormalsMod.Getnormal normal_result[1]  * victim_object.object.rotation

                        modPanel.setCurrentObject ref_ob.baseObject

                        modPanel.setCurrentObject ref_ob.edit_normals 
                        vertn = ref_vert_index
                        vert_array = #{vertn}
                        normal_array = #{}
                        ref_ob.Edit_Normals.ConvertVertexSelection &vert_array &normal_array
                        normal_result = normal_array as array 

                        normalt = ref_ob.modifiers[#Edit_Normals].EditNormalsMod.Getnormal normal_result[1] * victim_object.object.rotation

                        modPanel.setCurrentObject ref_ob.baseObject


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

        function bring_ref_object ref_obj offset = 
        (
            select ref_obj
            $.pos = victim_object.object.pos
            move $ offset
        )

        -- 1.First keep the first position of ref_objects
        -- 2.Move the ref_object
        -- 3.Select ref_object
        -- 4.Copy colors
        -- 5.Copy normals
        -- 6.Reset position of ref_objects

        local ref9_start_pos = $Ref9.pos
        local ref3_start_pos = $Ref3.pos

        bring_ref_object $Ref9 top_offset
        bring_ref_object $Ref3 left_offset
        
        select $Ref9
        copy_vertex_colors $Ref9
        
        select $Ref3
        copy_vertex_colors $Ref3
        
        copy_normals $Ref9
        copy_normals $Ref3

        select $Ref9
        $.pos = ref9_start_pos
        select $Ref3
        $.pos = ref3_start_pos
        
    )   
)


createdialog the_thief
