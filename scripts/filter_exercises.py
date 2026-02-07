#!/usr/bin/env python3
"""
Script to filter exercises from the organization list by removing
those that are already in the movement engine.
"""

import re
from pathlib import Path

# Read movement engine exercises
MOVEMENT_ENGINE_FILE = Path('/home/felix/fitnessos/lib/core/patterns/movement_engine.dart')
ORGANIZATION_LIST = Path('/home/felix/fitnessos/COMPLETE_EXERCISE_ORGANIZATION_LIST.md')
OUTPUT_FILE = Path('/home/felix/fitnessos/EXERCISES_NOT_IN_MOVEMENT_ENGINE.md')

def extract_movement_engine_exercises():
    """Extract all exercise IDs from movement engine"""
    with open(MOVEMENT_ENGINE_FILE, 'r') as f:
        content = f.read()
    
    # Find the exercises map
    exercises = set()
    
    # Pattern to match exercise IDs: 'exercise_id': ExerciseConfig(...)
    pattern = r"'([^']+)':\s*ExerciseConfig"
    matches = re.findall(pattern, content)
    
    for match in matches:
        exercises.add(match.lower())
    
    return exercises

def normalize_exercise_name(filename):
    """Convert filename to normalized exercise ID format"""
    # Example: 00251301-Barbell-Bench-Press_Chest-FIX_720.mp4
    # Extract: Barbell-Bench-Press
    # Normalize: barbell_bench_press
    
    # Remove ID prefix and file extension
    name = filename.replace('_720.mp4', '').replace('_360.mp4', '').replace('_180.mp4', '').replace('_1080.mp4', '')
    
    # Remove ID at start (8 digits)
    name = re.sub(r'^\d{8}-', '', name)
    
    # Remove body part suffix (everything after last underscore before quality)
    # Handle both: Name_BodyPart_720 and Name_BodyPart-FIX_720
    parts = name.split('_')
    if len(parts) >= 2:
        # Remove last part (body part) and second-to-last if it's just "FIX"
        name_parts = []
        for i, part in enumerate(parts):
            if i == len(parts) - 1:
                # Last part is body part, skip
                break
            if part.upper() == 'FIX' and i == len(parts) - 2:
                # Skip FIX before body part
                break
            name_parts.append(part)
        name = '_'.join(name_parts)
    
    # Convert to lowercase and replace hyphens with underscores
    normalized = name.lower().replace('-', '_').replace(' ', '_')
    
    # Clean up multiple underscores
    normalized = re.sub(r'_+', '_', normalized)
    normalized = normalized.strip('_')
    
    return normalized

def extract_exercises_from_list():
    """Extract all exercise filenames from the organization list"""
    with open(ORGANIZATION_LIST, 'r') as f:
        content = f.read()
    
    # Find all MP4 filenames
    pattern = r'(\d{8}-[^_]+_[^_]+_\d+\.mp4)'
    matches = re.findall(pattern, content)
    
    return matches

def is_in_movement_engine(normalized, movement_engine_exercises):
    """Check if normalized exercise name matches any in movement engine"""
    # Try exact match
    if normalized in movement_engine_exercises:
        return True
    
    # Try variations
    variations = [
        normalized.replace('_ii', '').replace('_version_2', '').replace('_version2', '').replace('_version_4', '').replace('_version4', ''),
        normalized.replace('_fix', ''),
        normalized.replace('_male', '').replace('_female', ''),
        # Remove common suffixes
        re.sub(r'_\([^)]+\)$', '', normalized),  # Remove (parentheses) at end
        re.sub(r'_v\d+$', '', normalized),  # Remove _v2, _v3 etc
        # Try without last word
        '_'.join(normalized.split('_')[:-1]) if '_' in normalized else normalized,
    ]
    
    for variant in variations:
        variant = variant.strip('_')
        if variant and variant in movement_engine_exercises:
            return True
    
    # Try partial matching (if normalized contains key words from movement engine)
    normalized_words = set(normalized.split('_'))
    for me_exercise in movement_engine_exercises:
        me_words = set(me_exercise.split('_'))
        # If most words match, consider it a match
        if len(normalized_words) >= 2 and len(me_words) >= 2:
            common_words = normalized_words.intersection(me_words)
            if len(common_words) >= min(2, len(normalized_words) - 1):
                return True
    
    return False

def main():
    print("🔍 Extracting exercises from movement engine...")
    movement_engine_exercises = extract_movement_engine_exercises()
    print(f"   Found {len(movement_engine_exercises)} exercises in movement engine")
    
    print("\n📋 Reading organization list...")
    exercise_files = extract_exercises_from_list()
    print(f"   Found {len(exercise_files)} exercise files in list")
    
    print("\n🔗 Matching exercises...")
    matched = set()
    unmatched_files = []
    
    for filename in exercise_files:
        normalized = normalize_exercise_name(filename)
        
        if is_in_movement_engine(normalized, movement_engine_exercises):
            matched.add(normalized)
        else:
            unmatched_files.append((filename, normalized))
    
    print(f"   Matched: {len(matched)} exercises")
    print(f"   Not matched: {len(unmatched_files)} exercises")
    
    # Now filter the organization list
    print("\n✂️  Creating filtered list...")
    
    with open(ORGANIZATION_LIST, 'r') as f:
        lines = f.readlines()
    
    output_lines = []
    exercise_count = 0
    skipped_count = 0
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Check if this line contains an exercise filename
        mp4_match = re.search(r'(\d{8}-[^_]+_[^_]+_\d+\.mp4)', line)
        
        if mp4_match:
            filename = mp4_match.group(1)
            normalized = normalize_exercise_name(filename)
            
            # Check if this exercise is in movement engine
            in_engine = is_in_movement_engine(normalized, movement_engine_exercises)
            
            if in_engine:
                # Skip this exercise line
                skipped_count += 1
                i += 1
                continue
            else:
                # Keep this exercise
                exercise_count += 1
                output_lines.append(line)
                i += 1
        else:
            # Regular line, keep it
            output_lines.append(line)
            i += 1
    
    # Write output
    with open(OUTPUT_FILE, 'w') as f:
        f.writelines(output_lines)
    
    print(f"\n✅ Filtered list created!")
    print(f"   Kept: {exercise_count} exercises")
    print(f"   Removed: {skipped_count} exercises")
    print(f"   Output: {OUTPUT_FILE}")

if __name__ == '__main__':
    main()
