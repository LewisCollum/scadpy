#!/usr/bin/env python3
"""
Slide Labels Generator

This script reads a YAML configuration file and generates multiple SCAD files
for slide labels based on the configuration.

Usage:
    python generate_labels.py [config_file]

If no config file is specified, it defaults to 'labels_config.yaml'
"""

import yaml
import os
import sys
from pathlib import Path
import subprocess

def load_config(config_file):
    """Load the YAML configuration file"""
    with open(config_file, 'r') as f:
        return yaml.safe_load(f)

def merge_defaults(label_config, defaults):
    """Merge label parameters with defaults"""
    merged = defaults.copy() if defaults else {}
    if 'parameters' in label_config:
        merged.update(label_config['parameters'])
    return merged

def generate_scad_file(label_name, parameters, output_dir):
    """Generate a SCAD file for a single label"""
    scad_content = generate_label_scad(parameters)

    output_file = output_dir / f"{label_name}.scad"
    with open(output_file, 'w') as f:
        f.write(scad_content)

    print(f"Generated: {output_file}")

def generate_label_scad(params):
    """Generate SCAD content for a label with given parameters"""
    # Extract parameters with defaults
    label_width = params.get('label_width', 50)
    label_height = params.get('label_height', 20)
    label_thickness = params.get('label_thickness', 2)
    label_text = params.get('label_text', 'LABEL')
    text_line_2 = params.get('text_line_2', '')
    text_line_3 = params.get('text_line_3', '')
    text_size = params.get('text_size', 8)
    text_size_2 = params.get('text_size_2', 6)
    text_size_3 = params.get('text_size_3', 6)
    text_font = params.get('text_font', 'Arial')
    text_style = params.get('text_style', 0)

    # Calculate line spacing
    avg_size = (text_size + text_size_2 + text_size_3) / 3
    line_spacing = avg_size * 1.3

    # Generate SCAD content
    scad_lines = []

    # BOSL2 includes
    scad_lines.extend([
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;',
        'include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;',
        '',
        f'$fn = 50;',
        '',
        f'// Label dimensions',
        f'label_width = {label_width};',
        f'label_height = {label_height};',
        f'label_thickness = {label_thickness};',
        '',
        f'// Text content',
        f'label_text = "{label_text}";',
        f'text_line_2 = "{text_line_2}";',
        f'text_line_3 = "{text_line_3}";',
        '',
        f'// Text sizing',
        f'text_size = {text_size};',
        f'text_size_2 = {text_size_2};',
        f'text_size_3 = {text_size_3};',
        '',
        f'// Text appearance',
        f'text_font = "{text_font}";',
        f'text_style = {text_style};',
        '',
        '// Calculate dynamic line spacing',
        f'line_spacing = ((text_size + text_size_2 + text_size_3) / 3) * 1.3;',
        '',
        '// Create the label',
        'union() {',
        '    // Engraved version (scaled by (1-text_style))',
        '    scale(v = [(1 - text_style), (1 - text_style), (1 - text_style)]) {',
        '        difference() {',
        '            cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);',
        '            translate(v = [0, 0, -label_thickness/2]) {',
        '                union() {',
        f'                    translate(v = [0, line_spacing, 0]) {{',
        '                        linear_extrude(height = label_thickness + 1) {',
        f'                            text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");',
        '                        }',
        '                    }',
        '                    translate(v = [0, 0, 0]) {',
        '                        linear_extrude(height = label_thickness + 1) {',
        f'                            text(font = text_font, halign = "center", size = text_size_2, text = text_line_2, valign = "center");',
        '                        }',
        '                    }',
        f'                    translate(v = [0, -line_spacing, 0]) {{',
        '                        linear_extrude(height = label_thickness + 1) {',
        f'                            text(font = text_font, halign = "center", size = text_size_3, text = text_line_3, valign = "center");',
        '                        }',
        '                    }',
        '                }',
        '            }',
        '        }',
        '    }',
        '    // Raised version (scaled by text_style)',
        '    scale(v = [text_style, text_style, text_style]) {',
        '        union() {',
        '            cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);',
        '            translate(v = [0, 0, label_thickness/2]) {',
        '                union() {',
        f'                    translate(v = [0, line_spacing, 0]) {{',
        '                        linear_extrude(height = label_thickness) {',
        f'                            text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");',
        '                        }',
        '                    }',
        '                    translate(v = [0, 0, 0]) {',
        '                        linear_extrude(height = label_thickness) {',
        f'                            text(font = text_font, halign = "center", size = text_size_2, text = text_line_2, valign = "center");',
        '                        }',
        '                    }',
        f'                    translate(v = [0, -line_spacing, 0]) {{',
        '                        linear_extrude(height = label_thickness) {',
        f'                            text(font = text_font, halign = "center", size = text_size_3, text = text_line_3, valign = "center");',
        '                        }',
        '                    }',
        '                }',
        '            }',
        '        }',
        '    }',
        '}'
    ])

    return '\n'.join(scad_lines)

def main():
    # Determine config file
    if len(sys.argv) > 1:
        config_file = sys.argv[1]
    else:
        config_file = 'labels_config.yaml'

    # Check if config file exists
    if not os.path.exists(config_file):
        print(f"Error: Configuration file '{config_file}' not found.")
        print("Usage: python generate_labels.py [config_file]")
        sys.exit(1)

    # Load configuration
    try:
        config = load_config(config_file)
    except Exception as e:
        print(f"Error loading configuration: {e}")
        sys.exit(1)

    # Get defaults
    defaults = config.get('defaults', {})

    # Create output directory
    output_dir = Path('out')
    output_dir.mkdir(exist_ok=True)

    # Generate labels
    labels = config.get('labels', [])
    if not labels:
        print("Warning: No labels defined in configuration.")
        return

    print(f"Generating {len(labels)} label(s)...")

    for label in labels:
        name = label['name']
        description = label.get('description', '')
        parameters = merge_defaults(label, defaults)

        print(f"Processing label: {name}")
        if description:
            print(f"  Description: {description}")

        generate_scad_file(name, parameters, output_dir)

    print(f"\nCompleted! Generated {len(labels)} SCAD file(s) in the 'out' directory.")

if __name__ == '__main__':
    main()