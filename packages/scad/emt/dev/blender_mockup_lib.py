import bpy
import math
import os
import random

class MockupGenerator:
    """
    A library for generating professional 3D mockups of STL files in Blender.
    """
    def __init__(self):
        # Default Configuration
        self.render_engine = 'BLENDER_EEVEE' # 'BLENDER_EEVEE' or 'CYCLES'
        self.resolution_base = 1600
        self.samples = 64
        self.use_gpu = True
        
        # Backdrop Settings
        self.backdrop_color = (0.01, 0.01, 0.01, 1) # Pitch black/Dark Grey
        self.backdrop_roughness = 0.4
        self.world_color = (0.0, 0.0, 0.0, 1)
        self.world_strength = 0.0
        
        # Material Settings
        self.material_color = (0.9, 0.9, 0.9, 1)
        self.material_roughness = 0.4
        
        # State
        self.imported_objects = []

    def initialize_scene(self):
        """Cleans the scene and sets up the environment."""
        self._clean_scene()
        self._setup_render_settings()
        self._create_backdrop()
        self._setup_lighting()
        self._setup_camera()

    def import_stls(self, directory, scale=0.001, length_variation_range=(0.7, 1.3)):
        """Imports all STL files from a directory."""
        files = [f for f in os.listdir(directory) if f.lower().endswith(".stl")]
        if not files:
            print(f"No STL files found in {directory}")
            return

        mat = self._create_plastic_material()
        
        for filename in files:
            filepath = os.path.join(directory, filename)
            
            # Handle different Blender versions for STL import
            if hasattr(bpy.ops.wm, "stl_import"):
                bpy.ops.wm.stl_import(filepath=filepath)
            elif hasattr(bpy.ops.import_mesh, "stl"):
                bpy.ops.import_mesh.stl(filepath=filepath)
            else:
                print(f"Could not find STL importer for {filename}")
                continue

            obj = bpy.context.selected_objects[0]
            obj.name = filename
            
            # Scale and vary
            length_variation = random.uniform(*length_variation_range) if length_variation_range else 1.0
            obj.scale = (scale, scale, scale * length_variation)
            bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
            
            # Center geometry
            bpy.ops.object.origin_set(type='ORIGIN_GEOMETRY', center='BOUNDS')
            obj.rotation_euler = (0, 0, 0)
                
            # Apply Material
            if obj.data.materials:
                obj.data.materials[0] = mat
            else:
                obj.data.materials.append(mat)
                
            # Add Bevel
            bevel = obj.modifiers.new(name="Bevel", type='BEVEL')
            bevel.width = 0.0005 # 0.5mm
            bevel.segments = 2
            bevel.limit_method = 'ANGLE'
                
            bpy.ops.object.shade_smooth()
            self.imported_objects.append(obj)

    def arrange_objects_radial(self, padding=0.002):
        """Arranges imported objects in a radial cluster."""
        print("Arranging with Radial Packing...")
        random.shuffle(self.imported_objects)
        
        placed_objects = []
        
        for obj in self.imported_objects:
            radius = max(obj.dimensions.x, obj.dimensions.y) / 2
            
            found_spot = False
            r = 0
            step_r = 0.005
            max_iter = 1000
            iter_count = 0
            
            while not found_spot and iter_count < max_iter:
                if r == 0:
                    num_steps = 1
                else:
                    circumference = 2 * math.pi * r
                    num_steps = int(circumference / step_r)
                    if num_steps < 1: num_steps = 1
                
                for i in range(num_steps):
                    theta = 2 * math.pi * i / num_steps
                    theta += random.uniform(0, 2*math.pi/num_steps)
                    
                    x = r * math.cos(theta)
                    y = r * math.sin(theta)
                    
                    collision = False
                    for p_obj in placed_objects:
                        p_radius = max(p_obj.dimensions.x, p_obj.dimensions.y) / 2
                        dist = math.sqrt((x - p_obj.location.x)**2 + (y - p_obj.location.y)**2)
                        if dist < (radius + p_radius + padding):
                            collision = True
                            break
                    
                    if not collision:
                        obj.location.x = x
                        obj.location.y = y
                        obj.location.z = obj.dimensions.z / 2
                        placed_objects.append(obj)
                        found_spot = True
                        break
                
                r += step_r
                iter_count += 1
        
        self._center_cluster()

    def render_variations(self, output_dir):
        """Renders the scene in standard aspect ratios."""
        scene = bpy.context.scene
        base = self.resolution_base
        
        variations = [
            ("4_3", base, int(base * 0.75)),
            ("1_1", base, base),
            ("3_4", int(base * 0.75), base)
        ]
        
        for name, w, h in variations:
            scene.render.resolution_x = w
            scene.render.resolution_y = h
            
            filepath = os.path.join(output_dir, f"render_{name}.png")
            scene.render.filepath = filepath
            
            print(f"Rendering {name} ({w}x{h})...")
            bpy.ops.render.render(write_still=True)

    # --- Internal Helpers ---

    def _clean_scene(self):
        if bpy.context.active_object and bpy.context.active_object.mode == 'EDIT':
            bpy.ops.object.mode_set(mode='OBJECT')
        bpy.ops.object.select_all(action='SELECT')
        bpy.ops.object.delete(use_global=False)
        for block in (bpy.data.meshes, bpy.data.materials, bpy.data.cameras, bpy.data.lights):
            for item in block:
                block.remove(item)

    def _setup_render_settings(self):
        scene = bpy.context.scene
        scene.render.engine = self.render_engine
        scene.render.film_transparent = True
        
        if self.render_engine == 'CYCLES':
            scene.cycles.device = 'GPU'
            scene.cycles.samples = self.samples
            scene.cycles.use_denoising = True
            if self.use_gpu:
                self._configure_gpu()
        else:
            # EEVEE settings
            if hasattr(scene, 'eevee'):
                if hasattr(scene.eevee, 'use_gtao'):
                    scene.eevee.use_gtao = True
                elif hasattr(scene.eevee, 'use_raytracing'):
                    scene.eevee.use_raytracing = True

        # Color Management
        if hasattr(scene.view_settings, 'view_transform'):
            scene.view_settings.view_transform = 'AgX' if 'AgX' in scene.view_settings.bl_rna.properties['view_transform'].enum_items else 'Filmic'
        scene.view_settings.look = 'Medium High Contrast'

    def _configure_gpu(self):
        try:
            prefs = bpy.context.preferences
            cprefs = prefs.addons['cycles'].preferences
            cprefs.get_devices()
            for device_type in ('OPTIX', 'CUDA', 'HIP', 'METAL'):
                if device_type in cprefs.get_device_types(bpy.context):
                    cprefs.compute_device_type = device_type
                    break
            for device in cprefs.devices:
                device.use = True
        except Exception:
            pass

    def _create_backdrop(self):
        bpy.ops.mesh.primitive_plane_add(size=100, location=(0, 0, 0))
        floor = bpy.context.active_object
        floor.name = "Backdrop_Floor"
        
        mat = bpy.data.materials.new(name="Backdrop_Mat")
        mat.use_nodes = True
        nodes = mat.node_tree.nodes
        bsdf = nodes.get("Principled BSDF")
        bsdf.inputs['Base Color'].default_value = self.backdrop_color
        bsdf.inputs['Roughness'].default_value = self.backdrop_roughness
        bsdf.inputs['Specular IOR Level'].default_value = 0.5
        floor.data.materials.append(mat)
        
        world = bpy.context.scene.world or bpy.data.worlds.new("World")
        bpy.context.scene.world = world
        world.use_nodes = True
        bg = world.node_tree.nodes.get("Background")
        if bg:
            bg.inputs['Color'].default_value = self.world_color
            bg.inputs['Strength'].default_value = self.world_strength
            
        # Physics
        bpy.context.view_layer.objects.active = floor
        if not bpy.context.scene.rigidbody_world:
            bpy.ops.rigidbody.world_add()
        bpy.ops.rigidbody.object_add()
        floor.rigid_body.type = 'PASSIVE'
        floor.rigid_body.collision_shape = 'MESH'

    def _setup_lighting(self):
        # Dramatic Gradient Style
        
        # Key Light (Spot)
        bpy.ops.object.light_add(type='SPOT', radius=0.2, location=(1.5, -1.5, 2.5))
        key = bpy.context.active_object
        key.data.energy = 800 if self.render_engine == 'CYCLES' else 150
        key.data.spot_size = math.radians(40)
        key.data.spot_blend = 0.3
        self._track_to(key, (0,0,0))

        # Fill Light (Area)
        bpy.ops.object.light_add(type='AREA', radius=3.0, location=(-2.0, -1.0, 2.0))
        fill = bpy.context.active_object
        fill.data.energy = 30 if self.render_engine == 'CYCLES' else 10
        self._track_to(fill, (0,0,0))

        # Rim Light (Area)
        bpy.ops.object.light_add(type='AREA', radius=0.5, location=(0, 2.0, 1.5))
        rim = bpy.context.active_object
        rim.data.energy = 400 if self.render_engine == 'CYCLES' else 100
        rim.data.use_shadow = False
        self._track_to(rim, (0,0,0))
        
        # Top Gradient Light (Spot)
        bpy.ops.object.light_add(type='SPOT', radius=0.5, location=(0, 0, 4.0))
        bg = bpy.context.active_object
        bg.data.energy = 300 if self.render_engine == 'CYCLES' else 100
        bg.data.spot_size = math.radians(50)
        bg.data.spot_blend = 1.0
        bg.data.use_shadow = False
        bg.rotation_euler = (0, 0, 0)

    def _setup_camera(self):
        bpy.ops.object.camera_add(location=(0.6, -0.6, 0.45))
        cam = bpy.context.active_object
        bpy.context.scene.camera = cam
        self._track_to(cam, (0,0,0.02))
        cam.data.lens = 60

    def _create_plastic_material(self):
        mat = bpy.data.materials.new(name="Mockup_Plastic")
        mat.use_nodes = True
        nodes = mat.node_tree.nodes
        links = mat.node_tree.links
        nodes.clear()
        
        out = nodes.new(type='ShaderNodeOutputMaterial')
        out.location = (600, 0)
        
        bsdf = nodes.new(type='ShaderNodeBsdfPrincipled')
        bsdf.location = (300, 0)
        bsdf.inputs['Base Color'].default_value = self.material_color
        bsdf.inputs['Roughness'].default_value = self.material_roughness
        
        noise = nodes.new(type='ShaderNodeTexNoise')
        noise.location = (-200, 100)
        noise.inputs['Scale'].default_value = 100.0
        noise.inputs['Detail'].default_value = 15.0
        
        bump = nodes.new(type='ShaderNodeBump')
        bump.location = (0, -100)
        bump.inputs['Strength'].default_value = 0.05
        
        links.new(noise.outputs['Fac'], bump.inputs['Height'])
        links.new(bump.outputs['Normal'], bsdf.inputs['Normal'])
        links.new(bsdf.outputs['BSDF'], out.inputs['Surface'])
        return mat

    def _track_to(self, obj, target_loc):
        target_name = "Focus_Target"
        target = bpy.data.objects.get(target_name)
        if not target:
            bpy.ops.object.empty_add(location=target_loc)
            target = bpy.context.active_object
            target.name = target_name
        
        const = obj.constraints.new(type='TRACK_TO')
        const.target = target
        const.track_axis = 'TRACK_NEGATIVE_Z'
        const.up_axis = 'UP_Y'

    def _center_cluster(self):
        if self.imported_objects:
            min_x = min(o.location.x - o.dimensions.x/2 for o in self.imported_objects)
            max_x = max(o.location.x + o.dimensions.x/2 for o in self.imported_objects)
            min_y = min(o.location.y - o.dimensions.y/2 for o in self.imported_objects)
            max_y = max(o.location.y + o.dimensions.y/2 for o in self.imported_objects)
            
            center_x = (min_x + max_x) / 2
            center_y = (min_y + max_y) / 2
            
            for obj in self.imported_objects:
                obj.location.x -= center_x
                obj.location.y -= center_y
