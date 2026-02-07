#!/usr/bin/env python3
"""
Script to organize exercise videos into categories:
1. Equipment type: machines, dumbbells_barbells_kettlebells, bodyweight
2. Body parts: chest, arms, shoulders, back, legs, abdominals
3. Bodyweight exercises all in one folder (not separated by body part)
"""

import os
import shutil
from pathlib import Path
from collections import defaultdict

# Base paths
BASE_DIR = Path('/home/felix/fitnessos')
VIDEOS_DIR = BASE_DIR / 'assets' / 'exercise_videos'

# Equipment categorization keywords
MACHINE_KEYWORDS = ['cable', 'lever', 'smith', 'sled', 'machine']
DUMBBELL_BARBELL_KEYWORDS = ['dumbbell', 'barbell', 'kettlebell', 'kettle-bell']

# Body part mapping from file names (case-insensitive, handles -FIX suffix)
BODY_PART_MAPPING = {
    'chest': ['chest'],
    'arms': ['upper-arms', 'forearms', 'forearm', 'triceps', 'biceps', 'hand', 'hands', 'upper-arms-fix', 'forearms-fix'],
    'shoulders': ['shoulders', 'shoulder', 'shoulders-fix', 'neck'],  # Neck exercises mapped to shoulders
    'back': ['back', 'back-fix'],
    'legs': ['thighs', 'thigh', 'calves', 'calf', 'hips', 'hip', 'thighs-fix', 'hips-fix'],
    'abdominals': ['waist', 'abs', 'abdominal', 'waist-fix']
}

def categorize_equipment(filename):
    """Categorize exercise by equipment type"""
    filename_lower = filename.lower()
    
    # Check for machine keywords
    for keyword in MACHINE_KEYWORDS:
        if keyword in filename_lower:
            return 'machines'
    
    # Check for dumbbell/barbell/kettlebell keywords
    for keyword in DUMBBELL_BARBELL_KEYWORDS:
        if keyword in filename_lower:
            return 'dumbbells_barbells_kettlebells'
    
    # Default to bodyweight if no equipment keywords found
    return 'bodyweight'

def categorize_body_part(filename):
    """Extract body part from filename"""
    # Filename format: ID-Exercise-Name_BodyPart_Quality.mp4
    # Handle both: Name_BodyPart_720.mp4 and Name_BodyPart-FIX_720.mp4
    parts = filename.split('_')
    if len(parts) >= 2:
        # Get body part (second to last part before quality number)
        body_part_str = parts[-2].lower()
        
        # Remove any trailing -fix suffix for matching
        body_part_clean = body_part_str.replace('-fix', '')
        
        # Map to our categories (check both with and without -fix)
        for category, keywords in BODY_PART_MAPPING.items():
            for keyword in keywords:
                keyword_clean = keyword.replace('-fix', '')
                # Match if keyword is in body part string
                if keyword_clean in body_part_clean or body_part_clean in keyword_clean:
                    return category
                # Also check exact match
                if body_part_str == keyword or body_part_clean == keyword_clean:
                    return category
    
    return 'unknown'

def is_bodyweight_exercise(filename):
    """Check if exercise is bodyweight (no equipment)"""
    filename_lower = filename.lower()
    
    # If it has ANY equipment keywords, it's NOT bodyweight
    all_equipment_keywords = MACHINE_KEYWORDS + DUMBBELL_BARBELL_KEYWORDS
    for keyword in all_equipment_keywords:
        if keyword in filename_lower:
            return False
    
    # If no equipment keywords found, it's bodyweight
    return True

def main():
    import sys
    
    # Check for dry-run flag
    dry_run = '--dry-run' in sys.argv or '-n' in sys.argv
    
    if dry_run:
        print("🔍 DRY RUN MODE - No files will be moved\n")
    
    print("🚀 Starting exercise organization...")
    print(f"📁 Source directory: {VIDEOS_DIR}")
    
    # Verify source directory exists
    if not VIDEOS_DIR.exists():
        print(f"❌ ERROR: Directory {VIDEOS_DIR} does not exist!")
        return
    
    # Get all MP4 files (including in subdirectories for dry-run, but only root for actual run)
    if dry_run:
        mp4_files = list(VIDEOS_DIR.rglob('*.mp4'))
        # Filter out files already in organized folders
        mp4_files = [f for f in mp4_files if f.parent == VIDEOS_DIR]
    else:
        mp4_files = list(VIDEOS_DIR.glob('*.mp4'))
    
    total_files = len(mp4_files)
    print(f"📊 Found {total_files} MP4 files to organize\n")
    
    if total_files == 0:
        print("❌ No MP4 files found!")
        return
    
    # Statistics
    stats = {
        'machines': defaultdict(int),
        'dumbbells_barbells_kettlebells': defaultdict(int),
        'bodyweight': 0,
        'unknown': []
    }
    
    # Process each file
    for mp4_file in mp4_files:
        filename = mp4_file.name
        
        # Determine if bodyweight
        if is_bodyweight_exercise(filename):
            # Bodyweight exercises go in one folder
            target_dir = VIDEOS_DIR / 'bodyweight'
            target_path = target_dir / filename
            
            if dry_run:
                print(f"✓ Bodyweight: {filename}")
            else:
                target_dir.mkdir(parents=True, exist_ok=True)
                if not target_path.exists():
                    shutil.move(str(mp4_file), str(target_path))
            
            stats['bodyweight'] += 1
        else:
            # Categorize equipment
            equipment = categorize_equipment(filename)
            
            # Categorize body part
            body_part = categorize_body_part(filename)
            
            if body_part == 'unknown':
                stats['unknown'].append(filename)
                print(f"⚠️  Unknown body part: {filename}")
                continue
            
            # Create target directory structure
            target_dir = VIDEOS_DIR / equipment / body_part
            target_path = target_dir / filename
            
            if dry_run:
                print(f"✓ {equipment}/{body_part}: {filename}")
            else:
                target_dir.mkdir(parents=True, exist_ok=True)
                if not target_path.exists():
                    shutil.move(str(mp4_file), str(target_path))
            
            stats[equipment][body_part] += 1
    
    # Print summary
    print("\n" + "="*60)
    print("📊 ORGANIZATION SUMMARY")
    print("="*60)
    
    print(f"\n🏋️  MACHINES:")
    for body_part, count in sorted(stats['machines'].items()):
        print(f"   {body_part}: {count}")
    print(f"   Total: {sum(stats['machines'].values())}")
    
    print(f"\n💪 DUMBBELLS/BARBELLS/KETTLEBELLS:")
    for body_part, count in sorted(stats['dumbbells_barbells_kettlebells'].items()):
        print(f"   {body_part}: {count}")
    print(f"   Total: {sum(stats['dumbbells_barbells_kettlebells'].values())}")
    
    print(f"\n🤸 BODYWEIGHT:")
    print(f"   Total: {stats['bodyweight']}")
    
    if stats['unknown']:
        print(f"\n⚠️  UNKNOWN BODY PARTS ({len(stats['unknown'])}):")
        for filename in stats['unknown'][:10]:  # Show first 10
            print(f"   {filename}")
        if len(stats['unknown']) > 10:
            print(f"   ... and {len(stats['unknown']) - 10} more")
    
    total_organized = (sum(stats['machines'].values()) + 
                      sum(stats['dumbbells_barbells_kettlebells'].values()) + 
                      stats['bodyweight'])
    
    print(f"\n✅ Total organized: {total_organized} / {total_files}")
    
    if total_organized < total_files:
        remaining = total_files - total_organized
        print(f"⚠️  {remaining} files not organized (check unknown list above)")
    
    print("\n🎉 Organization complete!")

if __name__ == '__main__':
    main()
