#!/usr/bin/env python3
"""
Script to filter exercises - SMART MATCHING
Matches exercises even when names are similar but not identical
"""

import re
from pathlib import Path

MOVEMENT_ENGINE_FILE = Path('/home/felix/fitnessos/lib/core/patterns/movement_engine.dart')
ORGANIZATION_LIST = Path('/home/felix/fitnessos/COMPLETE_EXERCISE_ORGANIZATION_LIST.md')
OUTPUT_FILE = Path('/home/felix/fitnessos/EXERCISES_NOT_IN_MOVEMENT_ENGINE.md')

def extract_movement_engine_exercises():
    """Extract all exercise IDs from movement engine"""
    with open(MOVEMENT_ENGINE_FILE, 'r') as f:
        content = f.read()
    
    exercises = set()
    pattern = r"'([^']+)':\s*ExerciseConfig"
    matches = re.findall(pattern, content)
    
    for match in matches:
        exercises.add(match.lower())
    
    return exercises

def normalize_exercise_name(filename):
    """Convert filename to normalized exercise ID format"""
    # Remove ID prefix and file extension
    name = filename.replace('_720.mp4', '').replace('_360.mp4', '').replace('_180.mp4', '').replace('_1080.mp4', '')
    name = re.sub(r'^\d{8}-', '', name)
    
    # Remove body part suffix
    parts = name.split('_')
    if len(parts) >= 2:
        name_parts = []
        for i, part in enumerate(parts):
            if i == len(parts) - 1:
                break
            if part.upper() == 'FIX' and i == len(parts) - 2:
                break
            name_parts.append(part)
        name = '_'.join(name_parts)
    
    # Convert to lowercase and replace hyphens with underscores
    normalized = name.lower().replace('-', '_').replace(' ', '_')
    normalized = re.sub(r'_+', '_', normalized)
    normalized = normalized.strip('_')
    
    return normalized

def get_core_words(normalized):
    """Extract core exercise words (remove equipment, modifiers)"""
    words = normalized.split('_')
    # Remove equipment words
    equipment_words = {'barbell', 'dumbbell', 'db', 'cable', 'lever', 'smith', 'machine', 'sled', 'ez', 'ezbarbell', 'plate', 'loaded'}
    # Remove common modifiers
    modifiers = {'version', 'fix', 'male', 'female', 'ii', 'iii', 'iv', 'v2', 'v3', 'v4', 'version2', 'version3', 'version4'}
    
    core_words = [w for w in words if w not in equipment_words and w not in modifiers]
    return set(core_words), words

def is_in_movement_engine(normalized, movement_engine_exercises):
    """Smart matching - handles variations in naming"""
    # Try exact match
    if normalized in movement_engine_exercises:
        return True
    
    # Get core words
    core_words, all_words = get_core_words(normalized)
    
    # Try variations (remove suffixes/prefixes)
    variations = [
        normalized.replace('_ii', '').replace('_iii', '').replace('_iv', ''),
        normalized.replace('_version_2', '').replace('_version2', '').replace('_version_3', '').replace('_version3', '').replace('_version_4', '').replace('_version4', ''),
        normalized.replace('_fix', ''),
        normalized.replace('_male', '').replace('_female', ''),
        re.sub(r'_\([^)]+\)$', '', normalized),  # Remove (parentheses)
        re.sub(r'_v\d+$', '', normalized),  # Remove _v2, _v3
    ]
    
    for variant in variations:
        variant = variant.strip('_')
        if variant and variant in movement_engine_exercises:
            return True
    
    # Remove last word if it's a modifier
    words = normalized.split('_')
    if len(words) > 1:
        modifiers = {'version', 'fix', 'male', 'female', 'ii', 'iii', 'iv', 'v2', 'v3', 'v4', 'version2', 'version3', 'version4', 'plate', 'loaded'}
        if words[-1] in modifiers:
            variant = '_'.join(words[:-1])
            if variant in movement_engine_exercises:
                return True
    
    # SMART MATCHING: Compare core exercise words
    # If core words match (ignoring equipment), it's likely the same exercise
    if len(core_words) >= 2:  # Need at least 2 core words
        for me_exercise in movement_engine_exercises:
            me_core_words, me_all_words = get_core_words(me_exercise)
            
            # If core words are the same (or one is subset of other), it's a match
            if core_words == me_core_words:
                return True
            
            # If most core words match (at least 80% or 2+ words)
            if len(core_words) >= 2 and len(me_core_words) >= 2:
                common_core = core_words.intersection(me_core_words)
                if len(common_core) >= 2:  # At least 2 core words match
                    # Check if it's a meaningful match (not just common words like "press", "curl")
                    # If all core words from one match the other, it's a match
                    if core_words.issubset(me_core_words) or me_core_words.issubset(core_words):
                        return True
                    # Or if most words match
                    match_ratio = len(common_core) / max(len(core_words), len(me_core_words))
                    if match_ratio >= 0.75 and len(common_core) >= 2:
                        return True
    
    # Also try matching with equipment variations
    # e.g., "barbell_bench_press" should match "bench_press"
    if len(core_words) >= 2:
        core_str = '_'.join(sorted(core_words))
        for me_exercise in movement_engine_exercises:
            me_core_words, _ = get_core_words(me_exercise)
            if len(me_core_words) >= 2:
                me_core_str = '_'.join(sorted(me_core_words))
                if core_str == me_core_str:
                    return True
    
    return False

def main():
    print("🔍 Extracting exercises from movement engine...")
    movement_engine_exercises = extract_movement_engine_exercises()
    print(f"   Found {len(movement_engine_exercises)} exercises in movement engine")
    
    print("\n📋 Reading organization list...")
    with open(ORGANIZATION_LIST, 'r') as f:
        lines = f.readlines()
    
    print("\n✂️  Filtering exercises (smart matching)...")
    
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
            
            # Check if this exercise is in movement engine (smart matching)
            in_engine = is_in_movement_engine(normalized, movement_engine_exercises)
            
            if in_engine:
                skipped_count += 1
                i += 1
                continue
            else:
                exercise_count += 1
                output_lines.append(line)
                i += 1
        else:
            output_lines.append(line)
            i += 1
    
    # Write output
    with open(OUTPUT_FILE, 'w') as f:
        f.writelines(output_lines)
    
    print(f"\n✅ Filtered list created!")
    print(f"   Kept: {exercise_count} exercises (NOT in movement engine)")
    print(f"   Removed: {skipped_count} exercises (already in movement engine)")
    print(f"   Output: {OUTPUT_FILE}")

if __name__ == '__main__':
    main()
