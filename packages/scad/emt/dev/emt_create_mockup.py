import sys
import os

# Add current directory to path so we can import the library
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from blender_mockup_lib import MockupGenerator

# --- Configuration ---
# Calculate paths relative to the script location
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
# Assumes structure: packages/scad/emt/dev/scripts/emt_create_mockup.py
# But we are in packages/scad/emt/dev/emt_create_mockup.py
# So parent is emt. build is in emt/build.
EMT_ROOT = os.path.dirname(SCRIPT_DIR) # packages/scad/emt
BUILD_DIR = os.path.join(EMT_ROOT, "build")

# PROJECT_ROOT was used to look for STLs. We should look in build.
STL_SOURCE_DIR = BUILD_DIR

def main():
    # Initialize the generator
    generator = MockupGenerator()
    
    # Configure settings (optional, defaults are good)
    generator.render_engine = 'BLENDER_EEVEE' # Fast
    # generator.render_engine = 'CYCLES'      # High Quality
    
    # Setup the scene
    generator.initialize_scene()
    
    # Import and arrange
    generator.import_stls(STL_SOURCE_DIR)
    generator.arrange_objects_radial()
    
    # Render
    generator.render_variations(STL_SOURCE_DIR)
    
    print("Mockup generation complete.")

if __name__ == "__main__":
    main()
